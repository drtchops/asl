state("Arena")
{
    // TES 1: Arena (no vars)
}

state("DOSBox")
{
    // TES 2: Daggerfall (no vars)
}

state("Morrowind")
{
    // TES 3: Morrowind (no vars)
}

state("Oblivion")
{
    // TES 4: Oblivion
    bool isLoading : 0x074F594;
    bool notTalking : 0x06D25A0;
    bool gamePaused : 0x07480BC;
    bool midSpeech : 0x06E4C08;
    bool isWaiting : 0x6BE410;
    uint spiesScroll : 0x6EA094;
    uint spiesScroll2 : 0x6DB898;
}

state("TESV")
{
    // TES 5: Skyrim
    bool isLoading : 0x17337CC;
    bool isLoadingScreen : 0xEE3561;
}

init
{
    if (game.ProcessName == "Oblivion") {
        vars.dontLoad = 0;
        vars.mapTravel = 0;
    }
}

update
{
    // temporary fix until ASL initializes game time on manual start
    if (!timer.IsGameTimeInitialized) {
        timer.IsGameTimeInitialized = true;
    }
}

isLoading
{
    if (timer.CurrentSplit.Name.ToLower().Contains("setup")) {
        return true;
    } else if (game.ProcessName == "Oblivion") {
        bool b = (current.isLoading && current.notTalking && vars.dontLoad == 0) || current.isWaiting;
        if (current.midSpeech || (current.spiesScroll == 1 && current.spiesScroll2 == 654430032))
        {
            vars.dontLoad = 1;
            vars.mapTravel = 0;
        }
        if (current.isLoading && current.gamePaused && vars.dontLoad == 1)
        {
            vars.mapTravel = 1;
        }
        if (vars.mapTravel == 1 && current.gamePaused && !current.isLoading || (current.notTalking && !current.isLoading && vars.dontLoad == 1))
        {
            vars.dontLoad = 0;
        }
        if (!current.isLoading && !current.gamePaused)
        {
            vars.dontLoad = 0;
        }
        return b;
    } else if (game.ProcessName == "TESV") {
        return current.isLoading || current.isLoadingScreen;
    } else {
        return false;
    }
}
