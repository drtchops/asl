state("Dredd")
{
    int chapterNumber : "Dredd.exe", 0x21410C;
    bool isLoading : "Dredd.exe", 0x240A5C, 0xC;
}

split
{
    return current.chapterNumber != 12 && current.chapterNumber > old.chapterNumber;
}

isLoading
{
    return current.isLoading;
}
