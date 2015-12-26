state("FalloutNV")
{
    bool isLoading : 0xDDA4EC;
}

init
{
    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading;
}
