state("Titanfall2", "2.0.0.5")
{
    // 2.0.0.5 - unknown size
    bool isGameplay : "engine.dll", 0x129E6AF4;
}

state("Titanfall2")
{
    // 2.0.0.7 - 1781760
    bool isGameplay : "engine.dll", 0x129E7B34;
}

init
{
    if (modules.First().ModuleMemorySize == 1781760) {
        version = "2.0.0.7";
    } else {
        version = "2.0.0.5";
    }
    // print(modules.First().ModuleMemorySize.ToString());
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
