state("game")
{
    bool isLoading : 0xDEADBEEF;
}

init
{
    // pause game time on crash / exit
    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = true;
}

update
{
}

start
{
}

reset
{
}

split
{
}

isLoading
{
    return current.isLoading;
}

gameTime
{
}
