// Yakuza Kiwami (PC, Steam) autosplitter & load remover
// Autosplitter by ToxicTT (Discord: ToxicTT#4487)
// Load remover by DrTChops

state("YakuzaKiwami")
{
    int loadState : 0x19D5050, 0x1E8, 0x4A0, 0x4A0, 0x310, 0x1EDC;
    string25 gameState0 : 0x128DD50, 0xC8, 0x490, 0x72;
    string25 gameState1 : 0x128DD50, 0xC8, 0x490, 0xBA;
    string25 gameState2 : 0x128DD50, 0xC8, 0x490, 0x102;
    string25 gameState3 : 0x128DD50, 0xC8, 0x490, 0x14A;
    string25 gameState4 : 0x128DD50, 0xC8, 0x490, 0x192;
    string25 gameState5 : 0x128DD50, 0xC8, 0x490, 0x1DA;
    int mainEnemyHealth : 0x10D9488, 0x78, 0x108, 0x10C;
}

startup
{
    vars.isLoading = false;
    vars.doSplit = false;
    vars.doStart = false;
    vars.prevChapterDisplay = false;
    vars.nishikiStarted = false;
    vars.prevPhase = timer.CurrentPhase;
}

update
{
    vars.isLoading = current.loadState == 1;
    vars.doSplit = false;
    vars.doStart = false;

    if (timer.CurrentPhase == TimerPhase.Running && vars.prevPhase == TimerPhase.NotRunning)
    {
        vars.nishikiStarted = false;
    }
    vars.prevPhase = timer.CurrentPhase;

    bool chapterDisplay = false;

    if (current.gameState0 == "pjcm_syotitle.sbb" ||
        current.gameState1 == "pjcm_syotitle.sbb" ||
        current.gameState2 == "pjcm_syotitle.sbb" ||
        current.gameState3 == "pjcm_syotitle.sbb" ||
        current.gameState4 == "pjcm_syotitle.sbb" ||
        current.gameState5 == "pjcm_syotitle.sbb")
    {
        chapterDisplay = true;
    }
    if (chapterDisplay && !vars.prevChapterDisplay)
    {
        vars.doSplit = true;
        vars.doStart = true;
    }
    vars.prevChapterDisplay = chapterDisplay;

    if (!vars.nishikiStarted && current.loadState == -1 && current.mainEnemyHealth == 7500)
    {
        vars.nishikiStarted = true;
    }
    else if (vars.nishikiStarted && old.mainEnemyHealth > 0 && current.mainEnemyHealth == 0)
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
