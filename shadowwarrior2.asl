state("ShadowWarrior2")
{
    bool isGameplay : 0x1811908;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return !current.isGameplay;
}
