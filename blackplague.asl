state("Penumbra")
{
    float gameTime: 0x2DCAF0, 0x188, 0x4C, 0x1C;
}

startup
{
    vars.prevPhase = null;
    vars.loadedTime = 0;
}

update
{
    if (current.gameTime == 0 && old.gameTime > 0) {
        // reload previous save
        vars.loadedTime += old.gameTime;
    }

    if (timer.CurrentPhase == TimerPhase.Running && vars.prevPhase == TimerPhase.NotRunning) {
        // on reset, reset this var
        vars.loadedTime = 0;
    }

    vars.prevPhase = timer.CurrentPhase;
}

start
{
    // autostart if only a current time is higher than 0
    // can't be done using old.GamerTimer == 0, since it's already 0 in menu
    return old.gameTime == 0 && current.gameTime > 0;
}

isLoading
{
    return true;
}

gameTime
{
    return TimeSpan.FromSeconds(current.gameTime + vars.loadedTime);
}

// based on SuicideMachine's SH2 timer
// made not terrible by chops
