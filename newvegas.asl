state("FalloutNV")
{
    bool isLoading : "FalloutNV.exe", 0xDDA4EC;
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
