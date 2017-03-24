state("WolfNewOrder_x64")
{
    int isLoading : 0x1679A88;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading > 0;
}
