state("game")
{
    // define your pointer paths here

    bool isLoading : 0xDEADBEEF;
}

startup
{
    // run when the script first loads, add settings here
}

shutdown
{
    // run when the script is stopped
}

init
{
    // run when the game is found, do any needed initialization here

    // resume game time on process start
    timer.IsGameTimePaused = false;
}

exit
{
    // run when the game process is lost

    // pause game time on crash / exit
    timer.IsGameTimePaused = true;
}

update
{
    // runs on every cycle, do any generic logic here
}

start
{
    // return true when you want to start the splits
}

reset
{
    // return true when you want to reset the splits
}

split
{
    // return true when you want to trigger a split
}

isLoading
{
    // return true when you want to pause the game time

    return current.isLoading;
}

gameTime
{
    // return a TimeSpan if you want to manually specify the game time
}
