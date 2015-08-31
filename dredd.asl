state("Dredd")
{
    int chapterNumber : "Dredd.exe", 0x21410C;
    bool isLoading : "Dredd.exe", 0x240A5C, 0xC;
}

update
{
    // temporary fix until ASL initializes game time on manual start
    if (!timer.IsGameTimeInitialized) {
        timer.IsGameTimeInitialized = true;
    }
}

split
{
    return current.chapterNumber != 12 && current.chapterNumber > old.chapterNumber;
}

isLoading
{
    return current.isLoading;
}
