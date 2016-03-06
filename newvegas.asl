state("FalloutNV")
{
    bool isLoading : 0xDDA4EC;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading;
}
