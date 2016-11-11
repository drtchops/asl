state("Dishonored2")
{
    bool isLoading : 0x26AD288;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading;
}
