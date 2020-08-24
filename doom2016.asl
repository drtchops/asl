// People who collectively worked on this:
// DrTChops
// Glurmo
// TheFuncannon
// loitho
// sychotixx
// Instagibz
// blairmadison11
// heny
// probably more

//===NOTES AND CHANGELOG===//
//heny                          @21\08\20:  Added setting to optionally split at the end of the intro section
//heny                          @21\08\20:  Updated the splitter for the latest 6,1,1,321 version to support OpenGL + added setting to optionally split between Lazarus Labs 1 & 2
//Glurmo                        @23\01\19:  Removed steam api ("tier0_s64.dll") dependency to prevent steam client updates breaking autosplitter + Add NG+ support
//Glurmo                        @21\01\19:  Fixed map name pointer for steam update (4.89.17.15) + added skipping of rune loadscreens for 100%
//Instagibz                     @04\04\18:  Updated the splitter for latest 6,1,1,321 version, VULKAN only
//Loitho                        @13\10\17:  Fixed mapname variable. Invalid pointer caused by a steam update of the tier0_s64.dll | Works for Steam >= 4.17.60.88
//Loitho                        @09\09\17:  Fixed the splitter for auto split on last boss hit 6,1,1,818 - Vulkan only
//blairmadison11                @02\09\17:  Partially updated the splitter for the latest 6,1,1,818, VULKAN only
//Instagibz & blairmadison11    @22\07\17:  Updated the splitter for the latest 6,1,1,513 version, VULKAN only for now. Note: Versioning changed back from 6,1,1,1219 to 6,1,1,513
//Instagibz                     @29\01\17:  Updated the splitter for latest steam-api change
//Instagibz                     @20\12\16:  Updated the splitter for latest 6,1,1,1219 version, VULKAN only for now
//Instagibz                     @08\12\16:  Updated the splitter for latest 6,1,1,1201 version, VULKAN only for now
//Instagibz                     @14\11\16:  Updated the splitter for latest 6,1,1,1109 version
//Instagibz                     @19\10\16:  Updated the splitter for latest 6,1,1,1012 version
//Instagibz                     @30\09\16:  Added auto-end to 6,1,1,706 also changed auto-start, was broken for me a few times
//TheFuncannon                  @30\09\16:  Updated the OGL version 6,1,1,706 to auto-start
//Instagibz                     @30\09\16:  Updated the vulkan and OGL version 6,1,1,920 to auto-start, auto-split and auto-end the run. Requires 13 splits
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

    bool canStart: 0x297CF3A;
    bool start: 0x34C5304;
    bool finalHit: 0x31D3F74;
    float bossHealth: 0x31CC008, 0x30, 0x4E8, 0x2D8, 0x1B4;
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;
}

state("DOOMx64", "6, 1, 1, 808") {
    bool isLoading: 0x31D13C0;
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;
}

state("DOOMx64vk", "6, 1, 1, 808") {
    bool isLoading: 0x4CE5AB0;
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;
}

state("DOOMx64", "6, 1, 1, 920") {
    float bossHealth: 0x322EEB8, 0x30, 0x4E8, 0x2E0, 0x1B4;
    bool canStart: 0x29B41DA;
    bool start: 0x3562DB0;
    bool isLoading: 0x3236CD0;
    bool finalHit: 0x3237134;
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;
}

state("DOOMx64vk", "6, 1, 1, 920") {
    float bossHealth: 0x0492AF48, 0x30, 0x4E8, 0x2E0, 0x1B4;
    bool start: 0x4C620D4;
    bool canStart: 0x2947314;
    bool finalHit: 0x49332E4;
    bool isLoading: 0x4932E80;
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;
}

state("DOOMx64", "6, 1, 1, 1012") {
    float bossHealth: 0x0330D838, 0x30, 0x4E8, 0x2E0, 0x1B8;
    bool start: 0x362E9BC;
    bool canStart: 0x2A4D304;
    bool finalHit: 0x3315AF4;
    bool isLoading: 0x3315690;
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;
}

state("DOOMx64vk", "6, 1, 1, 1012") {
    float bossHealth: 0x04A0A918, 0x30, 0x4E8, 0x2E0, 0x1B8;
    bool start: 0x4D2ED84;
    bool canStart: 0x2A2F804;
    bool finalHit: 0x4A12CE4;
    bool isLoading: 0x4E47580;
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;
}

state("DOOMx64", "6, 1, 1, 1109") {
    float bossHealth: 0x0330D838, 0x30, 0x4E8, 0x2E0, 0x1B8;
    bool start: 0x362E9BC;
    bool canStart: 0x2A4D304;
    bool finalHit: 0x3315AF4;
    bool isLoading: 0x3315690;
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;
}

state("DOOMx64vk", "6, 1, 1, 1109") {
    float bossHealth: 0x04A0A918, 0x30, 0x4E8, 0x2E0, 0x1B8;
    bool start: 0x4D2ED84;
    bool canStart: 0x2A2F804;
    bool finalHit: 0x4A12CE4;
    bool isLoading: 0x4E47580;
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;
}

state("DOOMx64", "6, 1, 1, 1201") {
    float bossHealth: 0x0330D838, 0x30, 0x4E8, 0x2E0, 0x1B8;        //NOT UPDATED YET
    bool start: 0x362E9BC;                                          //NOT UPDATED YET
    bool canStart: 0x2A4D304;                                       //NOT UPDATED YET
    bool finalHit: 0x3315AF4;                                       //NOT UPDATED YET
    bool isLoading: 0x3315690;                                      //NOT UPDATED YET
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;               //NOT UPDATED YET
}

state("DOOMx64vk", "6, 1, 1, 1201") {
    float bossHealth: 0x04C08DC0, 0x30, 0x4E8, 0x2E0, 0x1B4;
    bool start: 0x5684168;
    bool canStart: 0x2C14A44;
    bool finalHit: 0x535F274;
    bool isLoading: 0x535EE10;
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;
}

state("DOOMx64", "6, 1, 1, 1219") {
    float bossHealth: 0x04C08DC0, 0x30, 0x4E8, 0x2E0, 0x1B4;        //NOT UPDATED YET
    bool start: 0x5684168;                                          //NOT UPDATED YET
    bool canStart: 0x2C14A44;                                       //NOT UPDATED YET
    bool finalHit: 0x535F274;                                       //NOT UPDATED YET
    bool isLoading: 0x535EE10;                                      //NOT UPDATED YET
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;               //NOT UPDATED YET
}

state("DOOMx64vk", "6, 1, 1, 1219") {
    float bossHealth: 0x04C08DC0, 0x30, 0x4E8, 0x2E0, 0x1B4;
    bool start: 0x5684168;
    bool canStart: 0x2C14A44;
    bool finalHit: 0x535F274;
    bool isLoading: 0x535EE10;
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;
}

state("DOOMx64", "6, 1, 1, 531") {
    float bossHealth: 0x04C08DC0, 0x30, 0x4E8, 0x2E0, 0x1B4;        //NOT UPDATED YET
    bool start: 0x57BDEE0;                                          //NOT UPDATED YET
    bool canStart: 0x54DC3D8;                                       //NOT UPDATED YET
    bool finalHit: 0x535F274;                                       //NOT UPDATED YET
    bool isLoading: 0x56844C9;                                      //NOT UPDATED YET
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;               //NOT UPDATED YET
}

state("DOOMx64vk", "6, 1, 1, 531") {
    float bossHealth: 0x4C6F9D0, 0x30, 0x4E8, 0x2F0, 0x1B4;
    bool start: 0x57BDEE0;
    bool canStart: 0x54DC3D8;
    bool finalHit: 0x53C5DD4;
    bool isLoading: 0x56844C9;
    string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;
}

// 2017-08-24 Patch
state("DOOMx64vk", "6, 1, 1, 818") {
    float bossHealth: 0x2B0F3C0, 0x2CD80, 0x2B78;       // Fixed
    bool start: 0x5686EE0;                              // confirmed working
    bool canStart: 0x53A53D8;                           // confirmed working
    bool finalHit: 0x528EDB4;                           // confirmed working
    bool isLoading: 0x554D4C9;                          // confirmed working

    string35 mapName: "tier0_s64.dll", 0x58180, 0x17;
    string60 mapFile: 0x556B325;
}

// 2018-03-29 Patch (Latest, OpenGL)
state("DOOMx64", "6, 1, 1, 321") {
    float bossHealth: 0x036F9E08, 0x30, 0x4D0, 0x420, 0x2F8, 0x20, 0x2F0, 0x1B4;
    bool start: 0x427EA00;
    bool canStart: 0x2E4A378;
    bool finalHit: 0x3E59794;
    bool isLoading: 0x41434D9;

    string35 mapName: "tier0_s64.dll", 0x58180, 0x17;
    string60 mapFile: 0x415FE15;
}

// 2018-03-29 Patch (Latest, Vulkan)
state("DOOMx64vk", "6, 1, 1, 321") {
    float bossHealth: 0x307EF08, 0x2CD80, 0x2B78;
    bool start: 0x597FCD0;
    bool canStart: 0x56BF5D8;
    bool finalHit: 0x5557504;
    bool isLoading: 0x5845A29;

    string35 mapName: "tier0_s64.dll", 0x58180, 0x17;
    string60 mapFile: 0x5862785;
}

startup {
    vars.readOffset = (Func<Process, IntPtr, int, int, IntPtr>)((proc, ptr, offsetSize, remainingBytes) => {
        byte[] offsetBytes;
        if (ptr == IntPtr.Zero || !proc.ReadBytes(ptr, offsetSize, out offsetBytes)) {
            return IntPtr.Zero;
        }

        int offset;
        switch (offsetSize) {
            case 1:
                offset = offsetBytes[0];
                break;
            case 2:
                offset = BitConverter.ToInt16(offsetBytes, 0);
                break;
            case 4:
                offset = BitConverter.ToInt32(offsetBytes, 0);
                break;
            default:
                throw new Exception("Unsupported offset size");
        }

        return ptr + offsetSize + remainingBytes + offset;
    });

    settings.Add("optionalSplits", false, "Optional Splits (Game Version 6, 1, 1, 321)");
    settings.Add("splitForIntro", false, "Intro", "optionalSplits");
    settings.Add("splitForLazarusLabs1", false, "Lazarus Labs 1", "optionalSplits");
    settings.SetToolTip("optionalSplits", "Optionally split for special situations/in special locations (currently only working on game version 6, 1, 1, 321)");
    settings.SetToolTip("splitForIntro", "Split when smashing the elevator button panel in the intro section");
    settings.SetToolTip("splitForLazarusLabs1", "Split at the end of the first part of Lazarus Labs");

    vars.visitedMapFiles = new List<string>();
    vars.introMapFile = "game/sp/intro/intro"; // UAC
    vars.mapFileSplits = new List<string>() {
        "game/sp/resource_ops/resource_ops", // Resource Operations
        "game/sp/resource_ops_foundry/resource_ops_foundry", // Foundry
        "game/sp/surface1/surface1", // Argent Facility
        "game/sp/argent_tower/argent_tower", // Argent Energy Tower
        "game/sp/blood_keep/blood_keep", // Kadingir Sanctum
        "game/sp/surface2/surface2", // Argent Facility (Destroyed)
        "game/sp/bfg_division/bfg_division", // Advanced Research Complex
        "game/sp/lazarus/lazarus", // Lazarus Labs (1)
        "game/sp/blood_keep_b/blood_keep_b", // Titan's Realm
        "game/sp/blood_keep_c/blood_keep_c", // The Necropolis
        "game/sp/polar_core/polar_core", // VEGA Central Processing
        "game/sp/titan/titan", // Argent D'Nur
    };
}

init {
    vars.hasSplitForIntro = false;

    vars.playerPosPtr = 0;
    vars.playerX = 0.0;
    vars.playerY = 0.0;
    vars.playerZ = 0.0;

    var firstModule = modules.First();
    version = firstModule.FileVersionInfo.FileVersion;

    if (version == "6, 1, 1, 321") {
        // Delay signature scanning slightly to wait for the game's memory to be properly accessible
        vars.sigScanDelay = new System.Threading.Timer(_ => {
            var playerSigTarget = new SigScanTarget(3, "48 03 0D ?? ?? ?? ?? 39 01");
            var sigScanner = new SignatureScanner(game, firstModule.BaseAddress, firstModule.ModuleMemorySize);
            var playerSigPtr = sigScanner.Scan(playerSigTarget);
            vars.playerSigAddr = vars.readOffset(game, playerSigPtr, sizeof(int), 0);
        }, null, 3000, Timeout.Infinite);
    }

    print(version);
}

update {
    if (version == "6, 1, 1, 321" && settings["splitForIntro"]) { // Untested for other versions at the moment
        if (old.isLoading && !current.isLoading) {
            var playerBasePtr = new DeepPointer(vars.playerSigAddr, 0x8, 0x808, 0x1AB8);
            IntPtr playerPosPtr;
            playerBasePtr.DerefOffsets(game, out playerPosPtr);
            vars.playerPosPtr = playerPosPtr;
        }

        if (timer.CurrentPhase == TimerPhase.Running && !vars.hasSplitForIntro && !current.isLoading) {
            vars.playerX = memory.ReadValue<float>((IntPtr)vars.playerPosPtr);
            vars.playerY = memory.ReadValue<float>((IntPtr)vars.playerPosPtr + 4);
            vars.playerZ = memory.ReadValue<float>((IntPtr)vars.playerPosPtr + 8);
        }
    }
}

exit {
    timer.IsGameTimePaused = true;
    vars.sigScanDelay.Dispose();
}

start {
    vars.hasSplitForIntro = false;
    vars.visitedMapFiles = new List<string>();

    if (settings["splitForLazarusLabs1"]) {
        vars.mapFileSplits.Add("game/sp/lazarus_2/lazarus_2");
    } else {
        vars.mapFileSplits.Remove("game/sp/lazarus_2/lazarus_2");
    }

    if (version == "6, 1, 1, 527") {
        return (
            !old.start &&
            current.start &&
            !current.isLoading &&
            current.canStart &&
            current.mapName.StartsWith("intro")
        );
    } else if (version == "6, 1, 1, 706" || version == "6, 1, 1, 920" || version == "6, 1, 1, 1012" || version == "6, 1, 1, 1109" || version == "6, 1, 1, 1201" || version == "6, 1, 1, 1219" || version == "6, 1, 1, 531") {
        // Start the timer only if it's not running
        // Mapname contains The UAC, we're not loading anything,  We used to be in the intro and we're not anymore
        return (
            !current.isLoading &&
            !old.start &&
            current.start &&
            current.canStart &&
            current.mapName.Contains("The UAC")
        );
    } else if (version == "6, 1, 1, 818" || version == "6, 1, 1, 321") {
        // Latest 2 patches
        return (
            !current.isLoading &&
            !old.start &&
            current.start &&
            current.canStart &&
            current.mapFile == vars.introMapFile
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
    } else if (version == "6, 1, 1, 706" || version == "6, 1, 1, 920" || version == "6, 1, 1, 1012" || version == "6, 1, 1, 1109" || version == "6, 1, 1, 1201" || version == "6, 1, 1, 1219" || version == "6, 1, 1, 531") {
        return (
            !String.IsNullOrEmpty(current.mapName) &&
            !String.IsNullOrEmpty(old.mapName) &&
            old.mapName != current.mapName &&
            !old.mapName.Contains("menu") &&
            !old.mapName.Contains("playing") &&
            !old.mapName.Contains("a boss") &&
            !current.mapName.Contains("menu") &&
            !current.mapName.Contains("playing") &&
            !current.mapName.Contains("a boss") &&
            !current.mapName.Contains("The UAC") && // Start timer, but don't split for UAC
            !current.mapName.Contains("Rune Trial") && // Ignore rune loadscreens for 100%
            current.isLoading // Ignore mapName change for death in UN
            ) || (
            !current.finalHit &&
            current.bossHealth == 1
        );
    } else if (version == "6, 1, 1, 818" || version == "6, 1, 1, 321") {
        // Latest 2 patches (2018-03-29, 2017-08-24)
        bool finalSplit = !current.finalHit && current.bossHealth == 1;

        bool levelSplit = !String.IsNullOrEmpty(current.mapFile) &&
            !String.IsNullOrEmpty(old.mapFile) &&
            old.mapFile != current.mapFile &&
            current.isLoading &&
            !old.mapFile.Contains("challenges/") &&
            vars.mapFileSplits.Contains(current.mapFile);

        if (finalSplit) {
            return true;
        } else if (levelSplit && !vars.visitedMapFiles.Contains(current.mapFile)) {
            // Track to prevent splitting twice in 100%
            vars.visitedMapFiles.Add(current.mapFile);
            return true;
        }  else if (version == "6, 1, 1, 321") {
            if (!vars.hasSplitForIntro && settings["splitForIntro"]) { // Optional intro split when smashing the panel
                bool inUAC = current.mapFile.Equals("game/sp/intro/intro");
                bool correctIntroSplitXPos = Math.Abs(vars.playerX - (-10152.54)) < 0.1;
                bool correctIntroSplitYPos = Math.Abs(vars.playerY - (-2685.575)) < 0.1;
                bool correctIntroSplitZPos = Math.Abs(vars.playerZ - 3148.311) < 0.1;
                bool correctIntroSplitPos = correctIntroSplitXPos && correctIntroSplitYPos && correctIntroSplitZPos;

                if (inUAC && correctIntroSplitPos) {
                    vars.hasSplitForIntro = true;
                    return true;
                }
            }
        }
        return false;
    }
}

isLoading { return current.isLoading; }
