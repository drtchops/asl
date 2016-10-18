state("DXMD", "1, 1, 524, 7")
{
    // 1.1.524.7 - 2016-08-24 patch
    bool isLoading : 0x2E7FEE0, 0x34;
}

state("DXMD", "1, 1, 524, 10")
{
    // 1.1.524.10 - 2016-08-26 patch
    bool isLoading : 0x2DBA720;
}

state("DXMD", "1, 2, 524, 15")
{
    // 1.2.524.15 - 2016-08-30 patch
    bool isLoading : 0x2DBC6A0;
}

state("DXMD", "1, 3, 524, 17")
{
    // 1.3.524.17 - 2016-09-02 patch
    bool isLoading : 0x2DBC6A0;
}

state("DXMD", "1, 4, 545, 4")
{
    // 1.4.545.4 - 2016-09-08 patch
    bool isLoading : 0x2DC19C0;
}

state("DXMD", "1, 4, 545, 5")
{
    // 1.4.545.5 - 2016-09-15 patch
    bool isLoading : 0x2DC19D0;
}

state("DXMD", "1, 7, 551, 7")
{
    // 1.7.551.7 - 2016-09-23 patch
    bool isLoading : 0x2DC91B0;
}

state("DXMD", "1, 8, 565, 4")
{
    // 1.8.565.4 - 2016-10-03 patch
    bool isLoading : 0x2DF02A0;
}

state("DXMD", "1, 9, 582, 1")
{
    // 1.9.582.1 - 2016-10-08 patch
    bool isLoading : 0x2DF3280;
}

state("DXMD")
{
    // 1.10.592.1 - 2016-10-18 patch
    bool isLoading : 0x2DF43D0;
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
