state("Yakuza0")
{
    bool isLoading : 0x1A5D880, 0x158, 0x400;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading;
}
