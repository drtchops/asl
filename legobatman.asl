state("legobatman")
{
    bool isLoading : 0x5C9998;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading;
}
