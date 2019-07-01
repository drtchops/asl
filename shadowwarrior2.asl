state("ShadowWarrior2")
{
    // 1.1.1.0 - 2016-10-15
    // unknown pointer
}

state("ShadowWarrior2", "1.1.2.0")
{
    // 1.1.2.0 - 2016-10-15
    bool isGameplay : 0x1811908;
}

state("ShadowWarrior2", "1.1.3.0")
{
    // 1.1.3.0 - 2016-10-22
    bool isGameplay : 0x18189E8;
}

state("ShadowWarrior2", "1.1.4.0")
{
    // 1.1.4.0 - 2016-10-26
    bool isGameplay : 0x18202D8;
}

state("ShadowWarrior2", "1.1.4.1")
{
    // 1.1.4.1 - 2016-10-27
    bool isGameplay : 0x181F2D8;
}

state("ShadowWarrior2", "1.1.5.0")
{
    // 1.1.5.0 - 2016-11-09
    bool isGameplay : 0x18273B8;
}

state("ShadowWarrior2", "1.1.5.1")
{
    // 1.1.5.1 - 2016-12-08
    bool isGameplay : 0x182BC58;
}

state("ShadowWarrior2", "1.1.7.0")
{
    // 1.1.7.0 - 2016-12-21
    bool isGameplay : 0x18ABC58;
}

state("ShadowWarrior2", "1.1.10.0")
{
    // 1.1.10.0 - 2017-03-15
    bool isGameplay : 0x18AFC98;
}

state("ShadowWarrior2", "1.1.11.0")
{
    // 1.1.11.0 - 2017-08-22
    bool isGameplay : 0x18AFC98;
}

state("ShadowWarrior2", "1.1.14.0")
{
    // 1.1.14.0 - 2018-02-17
    // Edit by Mr. Mary - it seems to remove loads where the others do, but there might be a better address to hook onto.
    // Tested on GOG release
    bool isGameplay : 0x18AE808;
}

init
{
    version = modules.First().FileVersionInfo.FileVersion;
    // print(version);
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return !current.isGameplay;
}
