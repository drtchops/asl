// People who collectively worked on this:
// DrTChops
// TheFuncannon
// loitho
// sychotixx
// Instagibz
// probably more

state("DOOMx64", "6, 1, 1, 527")
{
    bool isLoading: 0x308C930;
    bool canStart: 0x2839D44;
    bool start: 0x337CA9C;
    bool mainMenu: 0xAD03804;
    string20 mapName: 0x318AFE8;
    float bossHealth: 0x03084EF8, 0x30, 0x4E8, 0x2D8, 0x1B4;
    bool finalHit: 0x308CB7C;
}

state("DOOMx64", "6, 1, 1, 706")
{
    // Timer restart when you exit a loading screen
    // (You have to press space)
    // So basically here you can chill during loading
    bool isLoading: 0x31D3B10;


    // Timer restart when "real" loading is finished
    // (even if you don't press space, the time WILL start)
    // Here you need to spam the spacebar during loading screen
    // bool isLoading: 0xB99B1E4;

    bool isIntro: 0x2959360, 0x18, 0x130, 0x18F0;

    string20 mapName: "tier0_s64.dll", 0x4D130, 0x1C;
}

state("DOOMx64", "6, 1, 1, 808")
{
    bool isLoading: 0x31D13C0;
    string35 mapName: "tier0_s64.dll", 0x4D130, 0x17;
}

state("DOOMx64vk", "6, 1, 1, 808")
{
    bool isLoading: 0x4CE5AB0;
    string35 mapName: "tier0_s64.dll", 0x4D130, 0x17;
}

state("DOOMx64", "6, 1, 1, 920")
{
    bool isLoading: 0x3236CD0;
    string42 mapName: "steam_api64.dll", 0x387B0, 0x310, 0x300, 0x117
}

state("DOOMx64vk", "6, 1, 1, 920")
{
    bool isLoading: "DOOMx64vk.exe", 0x4932E80;
    string42 mapName: "steam_api64.dll", 0x387B0, 0x590, 0x300, 0x157;
}


init
{
    version = modules.First().FileVersionInfo.FileVersion;
    print(version);
}

exit
{
    timer.IsGameTimePaused = true;
}

start
{
    if (version == "6, 1, 1, 527") {
        return (
            !old.start &&
            current.start &&
            !current.isLoading &&
            current.canStart &&
            current.mapName.StartsWith("intro")
        );
    } else if (version == "6, 1, 1, 706") {
        // Start the timer only if it's not running
        // Mapname contains The UAC, we're not loading anything,  We used to be in the intro and we're not anymore
        return (
            !current.isLoading &&
            old.isIntro &&
            !current.isIntro &&
            current.mapName.Contains("The UAC")
        );
    }
}

split
{
    if (version == "6, 1, 1, 527") {
        return (
            !String.IsNullOrEmpty(current.mapName) &&
            old.mapName != current.mapName &&
            !old.mainMenu
        ) || (
            !current.finalHit &&
            current.bossHealth == 1
        );
    } else if (version == "6, 1, 1, 706" || version == "6, 1, 1, 808" || version == "6, 1, 1, 920") {
        return (
            !String.IsNullOrEmpty(current.mapName) &&
            !String.IsNullOrEmpty(old.mapName) &&
            old.mapName != current.mapName &&
            !old.mapName.Contains("menu") &&
            !old.mapName.Contains("playing") &&
            !old.mapName.Contains("a boss") &&
            !current.mapName.Contains("menu") &&
            !current.mapName.Contains("playing") &&
            !current.mapName.Contains("a boss")
        );
    }
}

isLoading
{
    return current.isLoading;
}
