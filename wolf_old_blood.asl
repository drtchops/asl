state("WolfOldBlood_x64")
{
    int isLoading : 0x187ED7C;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading > 0;
}
