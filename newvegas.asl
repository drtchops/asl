state("FalloutNV")
{
    bool isLoading : "FalloutNV.exe", 0xDDA4EC;
}

init
{
    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = true;
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
