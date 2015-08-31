state("DragonAge2")
{
    bool isLoading : "DragonAge2.exe", 0x95869C, 0x1D0;
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
    return current.isLoading;
}
