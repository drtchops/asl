state("Fallout3")
{
    bool isLoading : 0xC76CE8;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading;
}
