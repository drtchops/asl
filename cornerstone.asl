/*
    v0.1
*/

state("Cornerstone")
{
    int isLoadingLevel : 0xA33124, 0x74; // Unity's Application.isloadinglevel
}

startup
{
    vars.FreeMemory = (Action<Process>)(p =>
    {
        p.FreeMemory((IntPtr)vars.isFmodInitPtr);
        p.FreeMemory((IntPtr)vars.injectedFuncPtr);
        p.FreeMemory((IntPtr)vars.oInitFmodPtr);
    });

    vars.CopyMemory = (Action<Process, IntPtr, IntPtr, int>)((p, src, dest, nbr) =>
    {
        var bytes = p.ReadBytes(src, nbr);
        p.WriteBytes(dest, bytes);
    });

    vars.CheckInitFmodPtr = (Func<Process, IntPtr, bool>)((p, ptr) =>
    {
        if (ptr == IntPtr.Zero)
            return false;

        byte[] bytes;
        if (!p.ReadBytes(ptr, 3, out bytes))
            return false;

        var expectedBytes = new byte[] { 0x55, 0x8B, 0xEC };
        if (!bytes.SequenceEqual(expectedBytes))
            return false;

        return true;
    });
}

init
{
    // find the FMOD_Listener:Initialize function
    var initFmodDeepPtr = new DeepPointer("mono.dll", 0x1F58F4, 0x4DC, 0x154);
    uint ptr;
    if (!initFmodDeepPtr.Deref<uint>(game, out ptr))
        throw new Exception("Couldn't read the pointer path for FMOD_Listener:Initialize");

    // check the pointer because it can be wrong while starting the game
    vars.initFmodPtr = ptr + 0x2F0;
    print("FMOD_Listener:Initialize : " + vars.initFmodPtr.ToString("X"));
    if (!vars.CheckInitFmodPtr(game, (IntPtr)vars.initFmodPtr))
        throw new Exception("Invalid FMOD_Listener:Initialize pointer");

    vars.isFmodInitPtr = game.AllocateMemory(sizeof(int)); // our injected bool
    var isFmodInitPtrBytes = BitConverter.GetBytes((uint)vars.isFmodInitPtr);


    // injected function body
    var initFmodDetourBytes = new List<byte>() {
        0x55,             // push ebp
        0x8B, 0xEC,       // mov ebp, esp
        0xFF, 0x75, 0x08, // push ebp+8
        0xC7, 0x05        // mov dword ptr [isFmodInitPtr], 01
    };
    initFmodDetourBytes.AddRange(isFmodInitPtrBytes);
    initFmodDetourBytes.AddRange(new byte[] { 1, 0, 0, 0 });

    var callOffset = initFmodDetourBytes.Count;
    initFmodDetourBytes.AddRange(new byte[] {
        255, 255, 255, 255, 255, // call oInitFmodPtr (placeholder)
        0xC7, 0x05               // mov dword ptr [isFmodInitPtr], 00
    });
    initFmodDetourBytes.AddRange(isFmodInitPtrBytes);
    initFmodDetourBytes.AddRange(new byte[] {
        0, 0, 0, 0,
        0xC9,       // leave
        0xC3        // ret
    });

    vars.injectedFuncPtr = game.AllocateMemory(initFmodDetourBytes.Count);


    game.Suspend(); // it'd crash if it executed code we're in the middle of changing
    try
    {
        // install hook
        vars.oInitFmodPtr = game.WriteDetour((IntPtr)vars.initFmodPtr, 5, (IntPtr)vars.injectedFuncPtr);

        // write the body of the injected function
        var oInitFmodPtrBytes = BitConverter.GetBytes((uint)vars.oInitFmodPtr);
        game.WriteBytes((IntPtr)vars.injectedFuncPtr, initFmodDetourBytes.ToArray());

        // replace the call placeholder
        game.WriteCallInstruction((IntPtr)vars.injectedFuncPtr + callOffset, (IntPtr)vars.oInitFmodPtr);
    }
    catch
    {
        vars.FreeMemory(game);
        throw;
    }
    finally
    {
        game.Resume();
    }

    print("isFmodInitPtr: " + vars.isFmodInitPtr.ToString("X"));
}

shutdown
{
    if (game == null)
        return;

    game.Suspend();
    try
    {
        // restore function prologue
        vars.CopyMemory(game, (IntPtr)vars.oInitFmodPtr, (IntPtr)vars.initFmodPtr, 5);
    }
    catch
    {
        throw;
    }
    finally
    {
        game.Resume();
        vars.FreeMemory(game);
    }
}

update
{
    vars.isFmodInit = game.ReadValue<bool>((IntPtr)vars.isFmodInitPtr);
}

isLoading
{
    return current.isLoadingLevel != 0 || vars.isFmodInit;
}
