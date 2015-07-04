state("game")
{
    bool isLoading : "game.exe", 0xDEADBEEF;
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
