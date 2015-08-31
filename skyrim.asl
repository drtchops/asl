state("TESV")
{
    bool isLoading : "TESV.exe", 0x17337CC;
    bool isLoadingScreen : "TESV.exe", 0xEE3561;
}

update
{
    // temporary fix until ASL initializes game time on manual start
    if (!timer.IsGameTimeInitialized) {
        timer.IsGameTimeInitialized = true;
    }
}

isLoading
{
    return current.isLoading || current.isLoadingScreen;
}
