// Yakuza Kiwami (PC, Steam) autosplitter & load remover
// Autosplitter by ToxicTT (Discord: ToxicTT#4487)
// Load remover by DrTChops
// v1.0 (2021-05-24)

state("YakuzaKiwami")
{
    int loadState : 0x19D5050, 0x1E8, 0x4A0, 0x4A0, 0x310, 0x1EDC;
    string25 gameState1 : 0x0128DD50, 0xC8, 0x490, 0x72;
    string25 gameState2 : 0x0128DD50, 0xC8, 0x490, 0xBA;
    string25 gameState3 : 0x0128DD50, 0xC8, 0x490, 0x102;
}

startup
{
    vars.isLoading = false;
    vars.doSplit = false;
    vars.doStart = false;
    vars.chapter = 1;
    vars.prevPhase = timer.CurrentPhase;
}

update
{
    vars.isLoading = current.loadState == 1;
    vars.doSplit = false;
    vars.doStart = false;

    // reset chapter on both manual start or auto start (if it ever gets added)
    if (timer.CurrentPhase == TimerPhase.Running && vars.prevPhase == TimerPhase.NotRunning)
    {
        vars.chapter = 1;
    }
    vars.prevPhase = timer.CurrentPhase;

    if (current.gameState1 == "" && old.gameState1 == "pjcm_title_ps3_c.sbb" &&
        current.gameState3 == "pjcm_syotitle.sbb" && old.gameState3 == "")
    {
        vars.doStart = true;
    }

    if (current.gameState1 == "pjcm_syotitle.sbb" && old.gameState1 != "pjcm_syotitle.sbb")
    {
        vars.chapter++;
        vars.doSplit = true;
    }
    else if (vars.chapter == 9 && current.gameState2 == "pjcm_syotitle.sbb" && old.gameState2 != "pjcm_syotitle.sbb")
    {
        vars.doSplit = true;
    }
}

start
{
    return vars.doStart;
}

split
{
    return vars.doSplit;
}

isLoading
{
    return vars.isLoading;
}
