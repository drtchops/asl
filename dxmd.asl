state("DXMD", "1, 1, 524, 7")
{
    // 524.7 - 2016-08-24 patch
    bool isLoading : 0x2E7FEE0, 0x34;
}

state("DXMD", "1, 1, 524, 10")
{
    // 524.10 - 2016-08-26 patch
    bool isLoading : 0x2DBA720;
}

state("DXMD", "1.2.524.15")
{
    // 1.2.524.15 - 2016-08-30 patch
    bool isLoading : 0x2DBC6A0;
}

state("DXMD", "1.2.524.15")
{
    // 1.3.524.17 - 2016-09-02 patch
    bool isLoading : 0x2DBC6A0;
}

state("DXMD")
{
    // 1.4.545.4 - 2016-09-08 patch
    bool isLoading : 0x2DC19C0;
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
