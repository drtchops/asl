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
    // TES 3: Morrowind
    bool loadingScreenVisible : 0x3BBCE0;
}

state("Oblivion")
{
    // TES 4: Oblivion, unknown version
}

state("Oblivion", "1.0")
{
    // TES 4: Oblivion, original version
    // version 1.0.228
    // size 7704576
    bool isLoadingScreen : 0x074F594;
    bool notTalking : 0x06D25A0;
    bool gamePaused : 0x07480BC;
    bool midSpeech : 0x06E4C08;
    bool isWaiting : 0x6BE410;
}

state("Oblivion", "1.2")
{
    // TES 4: Oblivion, steam version
    // version 1.2.0416
    // size 8409088
    bool isLoadingScreen : 0x742D54;
    bool notTalking : 0x72D91C;
    bool notPaused : 0x73341C;
    bool isWaiting : 0x712DE0;
}

state("TESV")
{
    // TES 5: Skyrim
    bool isLoading : 0x17337CC;
    bool isLoadingScreen : 0xEE3561;
}

init
{
    vars.prevPhase = timer.CurrentPhase;
    vars.isLoading = false;

    if (game.ProcessName == "Oblivion") {
        version = modules.First().FileVersionInfo.FileVersion;
        if (version == "1.0.228") {
            version = "1.0";
        } else if (version == "1.2.0416") {
            version = "1.2";
        } else {
            version = "";
        }

        vars.dontLoad = false;
        vars.mapTravel = false;
        vars.guardWarp = false;
        vars.guardWarp2 = false;
    } else {
        version = "";
    }
}

exit
{
    timer.IsGameTimePaused = true;
}

update
{
    if (timer.CurrentSplit.Name.ToLower().Contains("setup")) {
        vars.isLoading = true;

    } else if (game.ProcessName == "Morrowind") {
        vars.isLoading = current.loadingScreenVisible;

    } else if (game.ProcessName == "Oblivion" && version != "") {
        if (timer.CurrentPhase == TimerPhase.Running && vars.prevPhase == TimerPhase.NotRunning) {
            vars.dontLoad = false;
            vars.mapTravel = false;
            vars.guardWarp = false;
            vars.guardWarp2 = false;
        }

        vars.isLoading = (current.isLoadingScreen && current.notTalking && !vars.dontLoad) || current.isWaiting;
        if (version == "1.0") {
            // load pointer breaks when you start a conversation
            if (current.midSpeech) {
                vars.dontLoad = true;
                vars.mapTravel = false;
                vars.guardWarp2 = false;
            }
            if (current.isLoadingScreen && current.gamePaused && vars.dontLoad) {
                vars.mapTravel = true;
                vars.guardWarp = true;
            }
            if ((!current.isLoadingScreen && !current.gamePaused) || (current.gamePaused && !current.isLoadingScreen && vars.mapTravel)) {
                vars.dontLoad = false;
                vars.guardWarp = false;
            }
            if (vars.guardWarp && !current.gamePaused) {
                vars.guardWarp2 = true;
            }
            if (vars.guardWarp2 && current.isLoadingScreen && current.gamePaused) {
                vars.dontLoad = false;
            }
        } else {
            if (current.isLoadingScreen && !current.notTalking) {
                vars.dontLoad = true;
                vars.mapTravel = false;
            }
            if (current.isLoadingScreen && !current.notPaused && vars.dontLoad && current.notTalking) {
                vars.mapTravel = true;
            }
            if (vars.mapTravel && !current.notPaused && !current.isLoadingScreen || (current.notTalking && !current.isLoadingScreen)) {
                vars.dontLoad = false;
            }
            if (!current.isLoadingScreen && current.notPaused) {
                vars.dontLoad = false;
            }
        }
    } else if (game.ProcessName == "TESV") {
        vars.isLoading = current.isLoading || current.isLoadingScreen;

    } else {
        vars.isLoading = false;
    }

    vars.prevPhase = timer.CurrentPhase;
}

isLoading
{
    return vars.isLoading;
}
