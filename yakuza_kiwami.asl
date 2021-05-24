// Yakuza Kiwami (PC, Steam) autosplitter & load remover
// Autosplitter by ToxicTT (Discord: ToxicTT#4487)
// Load remover by DrTChops
// v1.0 (2021-05-24)

state("YakuzaKiwami")
{
    int isLoading : 0x19D5050, 0x1E8, 0x4A0, 0x4A0, 0x310, 0x1EDC;
    // bool isLoading : 0x127E3AC;
    string17 chapterCount1 : 0x0128DD50, 0xC8, 0x490, 0x72;
    string17 chapterCount2 : 0x0128DD50, 0xC8, 0x490, 0xBA;
}

init
{
    vars.chapter = 1;
    vars.prevPhase = timer.CurrentPhase;
    vars.isLoading = false;
    vars.doSplit = false;
}

update
{
    vars.isLoading = current.isLoading == 1;
    vars.doSplit = false;

    if (timer.CurrentPhase == TimerPhase.Running && vars.prevPhase == TimerPhase.NotRunning)
    {
        vars.chapter = 1;
    }

    if (current.chapterCount1 == "pjcm_syotitle.sbb" && old.chapterCount1 != "pjcm_syotitle.sbb") 
    {
        vars.chapter++;
        vars.doSplit = true;
    }
    else if (vars.chapter == 9 && current.chapterCount2 == "pjcm_syotitle.sbb" && old.chapterCount2 != "pjcm_syotitle.sbb") 
    {
        vars.doSplit = true;
    }

    vars.prevPhase = timer.CurrentPhase;
}

split
{
    return vars.doSplit;
}

isLoading
{
    return vars.isLoading;
}
