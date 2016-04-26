state("falloutw")
{
    // Fallout 1 (no vars)
}

state("FALLOUT2")
{
    // Fallout 2 (no vars)
}

state("BOS")
{
    // lmao good joke
}

state("Fallout3")
{
    // Fallout 3
    bool isLoading : 0xC76CE8;
}

state("FalloutNV")
{
    // Fallout: New Vegas
    bool isLoading : 0xDDA4EC;
}

state("Fallout4")
{
    // Fallout 4
}

startup
{
    vars.watchers = new MemoryWatcherList();

    vars.ReadOffset = (Func<Process, IntPtr, IntPtr>)((proc, ptr) => {
        int offset;
        if (ptr == IntPtr.Zero || !proc.ReadValue<int>(ptr, out offset)) {
            return IntPtr.Zero;
        }
        return ptr + 5 + offset;
    });

    vars.loadScreenTarget = new SigScanTarget(0,
        "80 3D ?? ?? ?? ?? 00",     // cmp byte ptr [Fallout4.exe+6CC83C8],00  ; Cell Transition
        "48 89 5C 24 70",           // mov [rsp+70],rbx
        "48 89 74 24 50",           // mov [rsp+50],rsi
        "48 89 7C 24 48",           // mov [rsp+48],rdi
        "0F 85 ?? ?? ?? ??",        // jne Fallout4.Scaleform::GFx::System::Init+1420BF
        "48 8B 05 ?? ?? ?? ??",     // mov rax,[Fallout4.exe+700FAF0]
        "48 85 C0",                 // test rax,rax
        "74 ??",                    // je Fallout4.Scaleform::GFx::System::Init+141FE1
        "80 B8 ?? ?? ?? ?? 00",     // cmp byte ptr [rax+000000C5],00
        "0F 85 ?? ?? ?? ??",        // jne Fallout4.Scaleform::GFx::System::Init+1420F2
        "80 B8 ?? ?? ?? ?? 00",     // cmp byte ptr [rax+000000C6],00
        "0F 85 ?? ?? ?? ??",        // jne Fallout4.Scaleform::GFx::System::Init+1420F2
        "48 89 6C 24 78",           // mov [rsp+78],rbp
        "C6 05 ?? ?? ?? ?? 01"      // mov byte ptr [Fallout4.exe+6FB1524],01  ; Loading Screen
    );

    vars.quickloadingTarget = new SigScanTarget(2,
        "C6 05 ?? ?? ?? ?? 01",     // mov byte ptr [Fallout4.exe+44BB958],01  ; Quickloading
        "48 8D 0D ?? ?? ?? ??",     // lea rcx,[Fallout4.exe+6FCDA38]
        "E8 ?? ?? ?? ??",           // call Fallout4.exe+1F83490
        "41 89 1F",                 // mov [r15],ebx
        "48 83 C4 58",              // add rsp,58
        "41 5F",                    // pop r15
        "5B",                       // pop rbx
        "C3"                        // ret
    );

    vars.waitingTarget = new SigScanTarget(44,
        "F0 FF 05 ?? ?? ?? ??",     // lock inc [Fallout4.exe+70432C4]
        "8B 15 ?? ?? ?? ??",        // mov edx,[Fallout4.exe+704370C]
        "8B 44 24 78",              // mov eax,[rsp+78]
        "F3 0F 10 44 24 70",        // movss xmm0,[rsp+70]
        "48 8B 0D ?? ?? ?? ??",     // mov rcx,[Fallout4.exe+7043718]
        "3B D0",                    // cmp edx,eax
        "F3 0F 11 3D ?? ?? ?? ??",  // movss [Fallout4.exe+7043294],xmm7
        "F3 0F 11 05 ?? ?? ?? ??",  // movss [Fallout4.exe+7043298],xmm0  ; isWaiting-2
        "0F 43 D6"                  // cmovae edx,esi
    );
}

init
{
    if (game.ProcessName == "Fallout4") {
        var module = modules.First();
        var scanner = new SignatureScanner(game, module.BaseAddress, module.ModuleMemorySize);

        var isQuickloadingAddr = vars.ReadOffset(game, scanner.Scan(vars.quickloadingTarget));
        var isWaitingAddr = vars.ReadOffset(game, scanner.Scan(vars.waitingTarget)) + 2;

        var loadScreenTargetAddr = scanner.Scan(vars.loadScreenTarget);
        var isCellTransitionAddr = IntPtr.Zero;
        var isLoadingScreenAddr = IntPtr.Zero;
        if (loadScreenTargetAddr != IntPtr.Zero) {
            isCellTransitionAddr = vars.ReadOffset(game, loadScreenTargetAddr + 2);
            isLoadingScreenAddr = vars.ReadOffset(game, loadScreenTargetAddr + 73);
        }

        print(
            "[NoLoads] isLoadingScreen: " + isLoadingScreenAddr.ToString("X") + "\n" +
            "[NoLoads] isQuickloading: " + isQuickloadingAddr.ToString("X") + "\n" +
            "[NoLoads] isCellTransition: " + isCellTransitionAddr.ToString("X") + "\n" +
            "[NoLoads] isWaiting: " + isWaitingAddr.ToString("X")
        );

        var addresses = new IntPtr[] {
            isQuickloadingAddr,
            isWaitingAddr,
            isCellTransitionAddr,
            isLoadingScreenAddr
        };
        if (addresses.Any(o => (ulong)o <= 100)) {
            throw new Exception("Failed to find all addresses.");
        }

        vars.isLoadingScreen = new MemoryWatcher<bool>(isLoadingScreenAddr);
        vars.isQuickloading = new MemoryWatcher<bool>(isQuickloadingAddr);
        vars.isCellTransition = new MemoryWatcher<bool>(isCellTransitionAddr);
        vars.isWaiting = new MemoryWatcher<byte>(isWaitingAddr);

        vars.watchers.Clear();
        vars.watchers.AddRange(new MemoryWatcher[] {
            vars.isLoadingScreen,
            vars.isQuickloading,
            vars.isCellTransition,
            vars.isWaiting
        });

        timer.IsGameTimePaused = false;
    }
}

exit
{
    timer.IsGameTimePaused = true;
}

update
{
    if (game.ProcessName == "Fallout4") {
        vars.watchers.UpdateAll(game);
    }
}

isLoading
{
    if (timer.CurrentSplit.Name.ToLower().Contains("setup")) {
        return true;
    } else if (game.ProcessName == "Fallout3" || game.ProcessName == "FalloutNV") {
        return current.isLoading;
    } else if (game.ProcessName == "Fallout4") {
        return (
            vars.isLoadingScreen.Current ||
            vars.isQuickloading.Current ||
            vars.isCellTransition.Current ||
            vars.isWaiting.Current == 68
        );
    } else {
        return false;
    }
}
