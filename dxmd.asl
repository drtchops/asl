state("DXMD", "1, 1, 524, 7")
{
    // 524.7 - day 1 patch
    bool isLoading : 0x2E7FEE0, 0x34;
}

state("DXMD", "1, 1, 524, 10")
{
    // 524.10 - day 3 patch
    bool isLoading : 0x2DBA720;
}

state("DXMD")
{
    // 1.2.524.15 - day 7 patch
    // 1.3.524.17 - day 9 patch
    bool isLoading : 0x2DBC6A0;
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
