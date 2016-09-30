// People who collectively worked on this:
// DrTChops
// TheFuncannon
// loitho
// sychotixx
// Instagibz
// probably more

//===NOTES AND CHANGELOG===//
//Instagibz     @30\09\16:  Added auto-end to 6,1,1,706 also changed auto-start, was broken for me a few times
//TheFuncannon  @30\09\16:  Updated the OGL version 6,1,1,706 to auto-start 
//Instagibz     @30\09\16:  Updated the vulkan and OGL version 6,1,1,920 to auto-start, auto-split and auto-end the run. Requires 13 splits 
//===NOTES AND CHANGELOG===//

state("DOOMx64", "6, 1, 1, 527") {
    bool isLoading: 0x308C930;
    bool canStart: 0x2839D44;
    bool start: 0x337CA9C;
    bool mainMenu: 0xAD03804;
    string20 mapName: 0x318AFE8;
    float bossHealth: 0x03084EF8, 0x30, 0x4E8, 0x2D8, 0x1B4;
    bool finalHit: 0x308CB7C;
}

state("DOOMx64", "6, 1, 1, 706") {
    // Timer restart when you exit a loading screen
    // (You have to press space)
    // So basically here you can chill during loading
    bool isLoading: 0x31D3B10;
    
    // Timer restart when "real" loading is finished
    // (even if you don't press space, the time WILL start)
    // Here you need to spam the spacebar during loading screen
    // bool isLoading: 0xB99B1E4;
    
    bool canStart: 0x297CF3A;// 0xB401C78; seems semi broken
    bool start: 0x34C5304;
    bool finalHit: 0x31D3F74;
    float bossHealth: 0x31CC008, 0x30, 0x4E8, 0x2D8, 0x1B4;
    string35 mapName: "tier0_s64.dll", 0x4D170, 0x17;
}

state("DOOMx64", "6, 1, 1, 808") {
    bool isLoading: 0x31D13C0;
    string35 mapName: "tier0_s64.dll", 0x4D170, 0x17;
}

state("DOOMx64vk", "6, 1, 1, 808") {
    bool isLoading: 0x4CE5AB0;
    string35 mapName: "tier0_s64.dll", 0x4D170, 0x17;
}

state("DOOMx64", "6, 1, 1, 920") {
    float bossHealth: 0x322EEB8, 0x30, 0x4E8, 0x2E0, 0x1B4;
    bool canStart: 0x29B41DA;
    bool start: 0x3562DB0;
    bool isLoading: 0x3236CD0;
    bool finalHit: 0x3237134;
    string35 mapName: "tier0_s64.dll", 0x4D170, 0x17;
}

state("DOOMx64vk", "6, 1, 1, 920") {
    float bossHealth: 0x0492AF48, 0x30, 0x4E8, 0x2E0, 0x1B4;
    bool start: 0x4C620D4;
    bool canStart: 0x2947314;
    bool finalHit: 0x49332E4;
    bool isLoading: 0x4932E80;
    string35 mapName: "tier0_s64.dll", 0x4D170, 0x17;
}

init {
    version = modules.First().FileVersionInfo.FileVersion;
    //print(version);
}

exit { timer.IsGameTimePaused = true; }

start {
    if (version == "6, 1, 1, 527") {
        return (
            !old.start &&
            current.start &&
            !current.isLoading &&
            current.canStart &&
            current.mapName.StartsWith("intro")
        );
    } else if (version == "6, 1, 1, 706" || version == "6, 1, 1, 920") {
        // Start the timer only if it's not running
        // Mapname contains The UAC, we're not loading anything,  We used to be in the intro and we're not anymore
        return (
            !current.isLoading &&
            !old.start &&
            current.start &&
            current.canStart &&
            current.mapName.Contains("The UAC")
        );
    }
}

split {
    if (version == "6, 1, 1, 527") {
        return (
            !String.IsNullOrEmpty(current.mapName) &&
            old.mapName != current.mapName &&
            !old.mainMenu
        ) || (
            !current.finalHit &&
            current.bossHealth == 1);   
    } else if (version == "6, 1, 1, 808") {
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
    } else if (version == "6, 1, 1, 706" || version == "6, 1, 1, 920") {
        //used to fix buggy mapname which goes blank sometimes
        if(current.mapName == "" && old.mapName != ""){ 
        current.mapName = old.mapName; 
        }

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
            ) || (
            !current.finalHit &&
            current.bossHealth == 1);
        }
}

isLoading { return current.isLoading; }
