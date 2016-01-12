state("DAOrigins")
{
    bool isLoading : 0x007E0A4C, 0x0, 0x5E4, 0xA8, 0x7E0, 0x42C;
    bool isLoadingScreen : 0x007DD6D4, 0x27C, 0x274, 0x8, 0x4, 0x40C;
}

init
{
    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading || current.isLoadingScreen;
}
