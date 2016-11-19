state("Dishonored2", "1.0")
{
    // 1.74.0
    // 153489408
    bool isLoading : 0x26AD288;
}

state("Dishonored2", "1.1")
{
    // 1.74.0
    // 158679040
    bool isLoading : 0x26AD188;
}

init
{
    if (modules.First().ModuleMemorySize == 158679040) {
        version = "1.1";
    } else {
        version = "1.0";
    }
    // print(modules.First().FileVersionInfo.FileVersion);
    // print(modules.First().ModuleMemorySize.ToString());
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading;
}
