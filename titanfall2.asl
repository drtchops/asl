state("Titanfall2")
{
    bool isGameplay : "engine.dll", 0x129E6AF4;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return !current.isGameplay;
}
