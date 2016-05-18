state("Oblivion")
{
    // TES 4: Oblivion, unknown version
}

state("Oblivion", "1.0")
{
    // TES 4: Oblivion, original version
    // version 1.0.228
    // size 7704576
    bool isLoadingScreen : 0x74F594;
    bool notTalking : 0x6D25A0;
    bool gamePaused : 0x7480BC;
    bool midSpeech : 0x6E4C08;
    bool isWaiting : 0x6BE410;
    // uint spiesScroll : 0x6EA094;
    // uint spiesScroll2 : 0x6DB898;
}

state("Oblivion", "1.2")
{
    // TES 4: Oblivion, steam version
    // version 1.2.0416
    // size 8409088

    // Puri's vars
    bool isLoadingScreen : 0x3CD4B0, 0x8, 0xEC;
    byte isWaiting : 0x172DCC, 0x10;
    // byte startingPrompt : 0x73BD60, 0x48, 0xC8, 0xB8, 0xDC;

    // TFC's vars
    // bool isLoadingScreen : 0x742D54;
    // bool notTalking : 0x72D91C;
    // bool notPaused : 0x73341C;
    // bool isWaiting : 0x712DE0;
}

init
{
    version = modules.First().FileVersionInfo.FileVersion;
    if (version == "1.0.228") {
        version = "1.0";
    } else if (version == "1.2.0416") {
        version = "1.2";
    } else {
        version = "";
    }

    vars.prevPhase = timer.CurrentPhase;
    vars.isLoading = false;
    vars.dontLoad = false;
    vars.mapTravel = false;
    vars.guardWarp = false;
    vars.guardWarp2 = false;
}

exit
{
    timer.IsGameTimePaused = true;
}

update
{
    if (version == "") {
        // unsupported version
        return;
    }

    if (timer.CurrentPhase == TimerPhase.Running && vars.prevPhase == TimerPhase.NotRunning) {
        vars.dontLoad = false;
        vars.mapTravel = false;
        vars.guardWarp = false;
        vars.guardWarp2 = false;
    }

    if (version == "1.0") {
        vars.isLoading = (current.isLoadingScreen && current.notTalking && !vars.dontLoad) || current.isWaiting;

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
        vars.isLoading = current.isLoadingScreen || current.isWaiting != 0;

        // for TFC's vars
        // if (current.isLoadingScreen && !current.notTalking) {
        //     vars.dontLoad = true;
        //     vars.mapTravel = false;
        // }
        // if (current.isLoadingScreen && !current.notPaused && vars.dontLoad && current.notTalking) {
        //     vars.mapTravel = true;
        // }
        // if (vars.mapTravel && !current.notPaused && !current.isLoadingScreen || (current.notTalking && !current.isLoadingScreen)) {
        //     vars.dontLoad = false;
        // }
        // if (!current.isLoadingScreen && current.notPaused) {
        //     vars.dontLoad = false;
        // }
    }

    vars.prevPhase = timer.CurrentPhase;
}

isLoading
{
    return vars.isLoading;
}
