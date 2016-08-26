state("DXMD", "1, 1, 524, 7")
{
    // 524.7 - day 1 patch
    bool isLoading : 0x2E7FEE0, 0x34;
}

state("DXMD")
{
    // 524.10 - day 3 patch
    bool isLoading : 0x2DBA720;
}

init
{
    version = modules.First().FileVersionInfo.FileVersion;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading;
}
