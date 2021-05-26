// Yakuza Kiwami (PC, Steam) autosplitter & load remover
// Autosplitter by ToxicTT (Discord: ToxicTT#4487)
// Load remover by DrTChops
// v1.0 (2021-05-24)

state("YakuzaKiwami")
{
    int loadState : 0x19D5050, 0x1E8, 0x4A0, 0x4A0, 0x310, 0x1EDC;
    string17 chapterState1 : 0x0128DD50, 0xC8, 0x490, 0x72;
    string17 chapterState2 : 0x0128DD50, 0xC8, 0x490, 0xBA;
}

startup
{
    vars.isLoading = false;
    vars.doSplit = false;
    vars.chapter = 1;
    vars.prevPhase = timer.CurrentPhase;
}

update
{
    vars.isLoading = current.loadState == 1;
    vars.doSplit = false;

    // reset chapter on both manual start or auto start (if it ever gets added)
    if (timer.CurrentPhase == TimerPhase.Running && vars.prevPhase == TimerPhase.NotRunning)
    {
        vars.chapter = 1;
    }
    vars.prevPhase = timer.CurrentPhase;

    if (current.chapterState1 == "pjcm_syotitle.sbb" && old.chapterState1 != "pjcm_syotitle.sbb")
    {
        vars.chapter++;
        vars.doSplit = true;
    }
    else if (vars.chapter == 9 && current.chapterState2 == "pjcm_syotitle.sbb" && old.chapterState2 != "pjcm_syotitle.sbb")
    {
        vars.doSplit = true;
    }
}

split
{
    return vars.doSplit;
}

isLoading
{
    return vars.isLoading;
}
