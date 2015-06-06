state("Dredd")
{
    int chapterNumber : "Dredd.exe", 0x21410C;
    byte isLoading : "Dredd.exe", 0x240A5C, 0xC;
}

start
{
}

reset
{
}

split
{
    return current.chapterNumber != 12 && current.chapterNumber > old.chapterNumber;
}

isLoading
{
    return current.isLoading != 0;
}
