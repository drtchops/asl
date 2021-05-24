state("Yakuza0")
{
    bool isLoading : 0x132C520, 0xA38, 0x38, 0x4A0, 0x4A0, 0x4A0, 0x1EDC;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading;
}
