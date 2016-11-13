state("DXMD") { }

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

    vars.loadingStructTarget = new SigScanTarget(18,
        "55",                      // push rbp
        "56",                      // push rsi
        "57",                      // push rdi
        "48 8D 6C 24 80",          // lea rbp,[rsp--80]
        "48 81 EC 80 01 00 00",    // sub rsp,00000180
        "48 8B 05 ?? ?? ?? ??",    // mov rax,[DXMD.NvOptimusEnablement+B5EF00]
        "48 89 CE",                // mov rsi,rcx
        "48 8D 0D ?? ?? ?? ??",    // lea rcx,[DXMD.NvOptimusEnablement+B5EF00]
        "FF 50 68",                // call qword ptr [rax+68]
        "48 8B 46 08",             // mov rax,[rsi+08]
        "48 8D 0D ?? ?? ?? ??",    // lea rcx,[DXMD.NvOptimusEnablement+B4CFB0]
        "48 8B 50 08"              // mov rdx,[rax+08]
    );
}

init
{
    var module = modules.First();
    var scanner = new SignatureScanner(game, module.BaseAddress, module.ModuleMemorySize);
    var isLoadingStructPtr = scanner.Scan(vars.loadingStructTarget);
    var isLoadingStructAddr = vars.ReadOffset(game, isLoadingStructPtr, 4, 0);
    var isLoadingAddr = isLoadingStructAddr + 0x6580; // lets just hope this never changes

    print("[NoLoads] isLoadingStructPtr: " + isLoadingStructPtr.ToString("X"));
    print("[NoLoads] isLoadingAddr: " + isLoadingAddr.ToString("X"));

    vars.isLoading = new MemoryWatcher<bool>(isLoadingAddr);
}

exit
{
    timer.IsGameTimePaused = true;
}

update
{
    vars.isLoading.Update(game);

    if (vars.isLoading.Current != vars.isLoading.Old) {
        print("[NoLoads] isLoading changed from " + vars.isLoading.Old + " to " + vars.isLoading.Current);
    }
}

isLoading
{
    return vars.isLoading.Current;
}
