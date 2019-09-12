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
    // TES 3: Morrowind, unknown version
}

state("Morrowind", "1.0")
{
    // TES 3: Morrowind, original version
    // size 3981312
    bool loadingScreenVisible : 0x3BBCE0;
    bool extraLoadingCheck : 0x3B0704;
    float fadeInTime : 0x3AEA84, 0x348, 0x4;
    // Not 100% certain what this address correlates to but the behavior is as follows
    // 255 when loading or walking around (no menus). 0 When dialog/menu are open... UNLESS mousing over a dialog border, then 1.
    byte dialogIcon : 0x3AEA84, 0x50, 0x14;
}

state("Morrowind", "goty")
{
    // TES 3: Morrowind, goty version
    // size 4431872
    bool loadingScreenVisible : 0x3D4294;
    bool extraLoadingCheck : 0x3C85B8;
    float fadeInTime : 0x3C67DC, 0x354, 0x4;
    // Not 100% certain what this address correlates to but the behavior is as follows
    // 255 when loading or walking around (no menus). 0 When dialog/menu are open... UNLESS mousing over a dialog border, then 1.
    byte dialogIcon : 0x3C67DC, 0x50, 0x14;
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
    bool isLoadingScreen : 0x3CD4B0, 0x8, 0xEC;
    byte isWaiting : 0x172DCC, 0x10;
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
    version = ""

    if (game.ProcessName == "Morrowind") {
        if (modules.First().ModuleMemorySize == 4431872) {
            version = "goty";
        } else if (modules.First().ModuleMemorySize == 3981312) {
            version = "1.0"
        }
    } else if (game.ProcessName == "Oblivion") {
        if (modules.First().FileVersionInfo.FileVersion == "1.0.228") {
            version = "1.0";
        } else if (modules.First().FileVersionInfo.FileVersion == "1.2.0416") {
            version = "1.2";
        }

        vars.dontLoad = false;
        vars.mapTravel = false;
        vars.guardWarp = false;
        vars.guardWarp2 = false;
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
        vars.isLoading = current.loadingScreenVisible || (current.extraLoadingCheck && current.dialogIcon > 1 && current.fadeInTime > 0.0);

    } else if (game.ProcessName == "Oblivion" && version != "") {
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
