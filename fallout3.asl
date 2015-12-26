state("Fallout3")
{
    bool isLoading : 0xC76CE8;
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
