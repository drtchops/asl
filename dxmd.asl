state("DXMD")
{
    bool isLoading : 0x2E7FEE0, 0x34;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading;
}
