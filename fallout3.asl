state("Fallout3")
{
    bool isLoading : "Fallout3.exe", 0xC76CE8;
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
