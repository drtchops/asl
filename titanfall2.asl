state("Titanfall2") { }

startup
{
    // ptr: address of the offset (not the start of the instruction!)
    // offsetSize: the number of bytes of the offset
    // remainingBytes: the number of bytes until the end of the instruction (not including the offset bytes)
    vars.ReadOffset = (Func<Process, IntPtr, int, int, IntPtr>)((proc, ptr, offsetSize, remainingBytes) =>
    {
        byte[] offsetBytes;
        if (ptr == IntPtr.Zero || !proc.ReadBytes(ptr, offsetSize, out offsetBytes))
            return IntPtr.Zero;

        int offset;
        switch (offsetSize)
        {
            case 1:
                offset = offsetBytes[0];
                break;
            case 2:
                offset = BitConverter.ToInt16(offsetBytes, 0);
                break;
            case 4:
                offset = BitConverter.ToInt32(offsetBytes, 0);
                break;
            default:
                throw new Exception("Unsupported offset size");
        }
        return ptr + offsetSize + remainingBytes + offset;
    });

    vars.gameplayTarget = new SigScanTarget(3,
        "48 8D 0D ?? ?? ?? ??",  // lea rcx,[engine.dll+129E7B34]
        "83 E2 1F",              // and edx,1F
        "B8 01 00 00 00",        // mov eax,00000001
        "4D 69 C0 ?? ?? ?? ??",  // imul r8,r8,0002D790
        "4C 03 C1",              // add r8,rcx
        "0F B6 CA",              // movzx ecx,dl
        "D3 E0",                 // shl eax,cl
        "45 84 C9"               // test r9l,r9l
    );

    // 2.0.0.7
    // engine.F+1612D - 48 8D 0D 906F8112     - lea rcx,[engine.dll+129E7B34]
    // engine.F+16134 - 83 E2 1F              - and edx,1F
    // engine.F+16137 - B8 01000000           - mov eax,00000001
    // engine.F+1613C - 4D 69 C0 90D70200     - imul r8,r8,0002D790
    // engine.F+16143 - 4C 03 C1              - add r8,rcx
    // engine.F+16146 - 0FB6 CA               - movzx ecx,dl
    // engine.F+16149 - D3 E0                 - shl eax,cl
    // engine.F+1614B - 45 84 C9              - test r9l,r9l

    // 2.0.1.1
    // engine.F+1612D - 48 8D 0D 08F38512     - lea rcx,[engine.dll+12A3073C]
    // engine.F+16134 - 83 E2 1F              - and edx,1F
    // engine.F+16137 - B8 01000000           - mov eax,00000001
    // engine.F+1613C - 4D 69 C0 98D70200     - imul r8,r8,0002D798
    // engine.F+16143 - 4C 03 C1              - add r8,rcx
    // engine.F+16146 - 0FB6 CA               - movzx ecx,dl
    // engine.F+16149 - D3 E0                 - shl eax,cl
    // engine.F+1614B - 45 84 C9              - test r9l,r9l
}

init
{
    var module = modules.FirstOrDefault(m => m.ModuleName.ToLower() == "engine.dll");
    var scanner = new SignatureScanner(game, module.BaseAddress, module.ModuleMemorySize);
    var isGameplayPtr = scanner.Scan(vars.gameplayTarget);
    var isGameplayAddr = vars.ReadOffset(game, isGameplayPtr, 4, 0);

    // print("[NoLoads] isGameplayPtr: " + isGameplayPtr.ToString("X"));
    // print("[NoLoads] isGameplayAddr: " + isGameplayAddr.ToString("X"));

    vars.isGameplay = new MemoryWatcher<bool>(isGameplayAddr);
}

exit
{
    timer.IsGameTimePaused = true;
}

update
{
    vars.isGameplay.Update(game);

    // if (vars.isGameplay.Current != vars.isGameplay.Old) {
    //     print("[NoLoads] isGameplay changed from " + vars.isGameplay.Old + " to " + vars.isGameplay.Current);
    // }
}

isLoading
{
    return !vars.isGameplay.Current;
}
