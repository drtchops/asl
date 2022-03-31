// People who collectively worked on this:
// DrTChops
// Glurmo
// TheFuncannon
// loitho
// sychotixx
// Instagibz
// blairmadison11
// heny
// Meta
// SabuilneHorizon
// probably more

//===NOTES AND CHANGELOG===//

//SabulineHorizon               @08\12\21:  Added Auto-Reset, added split for Spider Mastermind Skip, fixed timer start delays, fixed optional intro split bug, fixed random intro timer starts, fixed UN start split
//Meta                          @03\08\21:  Added popup that detects real time & asks if you want game time comparison. Added livesplit cycle fix that otherwise starts timer @ 0.00 - 0.06 
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
	float playerX: 0x41C16C8;
	float playerY: 0x41C16CC;
	float playerZ: 0x41C16C0;
    bool start: 0x427EA00;
    bool canStart: 0x2E4A378;
    bool finalHit: 0x3E59794;
    bool isLoading: 0x41434D9;
	bool menuOpen: 0x3E57624; //need to verify
	byte menuSelection: 0x04280338, 0x4D0, 0x10, 0x1B8, 0x1A4; //0-Resume, 1-Settings , 2-Load Checckpoint , 3-Restart Mission , 4-Exit to Main Menu , 5-Exit to Desktop
	byte deathReset: 0x427ECBA; //44 when death menu appears, and 36 when resetting
	byte difficulty: 0x490F380; //0-I'm Too Young To Die, 1-Hurt Me Plenty, 2-Ultra-Violence, 3-Nightmare 4 = Ultra-Nightmare
	int checkpointCounter: 0x40FE988;
	int finalCutscene: 0x4C3ED68;

    string35 mapName: "tier0_s64.dll", 0x58180, 0x17;
    string60 mapFile: 0x415FE15;
}

// 2018-03-29 Patch (Latest, Vulkan)
state("DOOMx64vk", "6, 1, 1, 321") {
    float bossHealth: 0x307EF08, 0x2CD80, 0x2B78;
	float playerX: 0x58C27F8;
	float playerY: 0x58C27FC;
	float playerZ: 0x58C27F0;
    bool start: 0x597FCD0;
    bool canStart: 0x56BF5D8;
    bool finalHit: 0x5557504;
    bool isLoading: 0x5845A29;
	bool menuOpen: 0x5555364;
	byte menuSelection: 0x5981608, 0x4D0, 0x10, 0x1B8, 0x1A4; //0-Resume, 1-Settings , 2-Load Checckpoint , 3-Restart Mission , 4-Exit to Main Menu , 5-Exit to Desktop
	byte deathReset: 0x597FF8A; //44 when death menu appears, and 36 when resetting
	byte difficulty: 0x6011070; //0-I'm Too Young To Die, 1-Hurt Me Plenty, 2-Ultra-Violence, 3-Nightmare 4 = Ultra-Nightmare
	int checkpointCounter: 0x57FC388;
	int finalCutscene: 0x6338518;
	
    string35 mapName: "tier0_s64.dll", 0x58180, 0x17;
    string60 mapFile: 0x5862785;
}

startup {
	vars.TimerStart = (EventHandler) ((s, e) => timer.IsGameTimePaused = true);

    timer.OnStart += vars.TimerStart;
//^ Ensures the timer starts at 0.00, thanks Gelly for this
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

	if (timer.CurrentTimingMethod == TimingMethod.RealTime) // Pops up if real time comparison is detected, asking if you want to switch to Game Time. Thanks Micrologist for this.
        {        
        var timingMessage = MessageBox.Show (
               "This game uses Time without Loads (Game Time) as the main timing method.\n"+
                "LiveSplit is currently set to show Real Time (RTA).\n"+
                "Would you like to set the timing method to Game Time? This will make verification easier",
                "LiveSplit | DOOM 2016",
               MessageBoxButtons.YesNo,MessageBoxIcon.Question
            );
        
            if (timingMessage == DialogResult.Yes)
            {
                timer.CurrentTimingMethod = TimingMethod.GameTime;
            }
        }
    });

    settings.Add("optionalSplits", false, "Optional Splits (Game Version 6, 1, 1, 321)");
    settings.Add("splitForIntro", false, "Intro", "optionalSplits");
    settings.Add("splitForLazarusLabs1", false, "Lazarus Labs 1", "optionalSplits");
	settings.Add("noCheckpointResets", false, "No checkpoint reset");
    settings.SetToolTip("optionalSplits", "Optionally split for special situations/in special locations (currently only working on game version 6, 1, 1, 321)");
    settings.SetToolTip("splitForIntro", "Split when smashing the elevator button panel in the intro section");
    settings.SetToolTip("splitForLazarusLabs1", "Split at the end of the first part of Lazarus Labs");
    settings.SetToolTip("noCheckpointResets", "Do not reset the timer when reloading checkpoint at the start of Intro");

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
	vars.resetType = 0;
	vars.checkpointCounterStart = 0;
	vars.pauseStart = false;
	vars.endCutsceneTriggered = false;
	
    var firstModule = modules.First();
    version = firstModule.FileVersionInfo.FileVersion;
    print(version);
}

update {
	if (version == "6, 1, 1, 321") { // Latest patch
		
		if (vars.pauseStart){
			vars.pauseStart = current.menuOpen;
		}
	}
}

exit {
    timer.IsGameTimePaused = true;
}

start {
    vars.hasSplitForIntro = false;
    vars.visitedMapFiles = new List<string>();
	vars.pauseStart = false;
	vars.resetType = 0;
	vars.checkpointCounterStart = 0;
	vars.endCutsceneTriggered = false;

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
    } else if (version == "6, 1, 1, 818") {
        return (
            !current.isLoading &&
            !old.start &&
            current.start &&
            current.canStart &&
            current.mapFile == vars.introMapFile
        );
    } else if (version == "6, 1, 1, 321") { // Latest patch
	
		//If we're starting UN instead of another difficulty
		if (old.isLoading && !current.isLoading && (current.difficulty == 4)){
			Thread.Sleep(3560);
			return (
				((current.playerX - (-10200.00)) < 0.1) &&
				((current.playerY - (-2624.00)) < 0.1) &&
				((current.playerZ - (9540.00)) < 6)
			);
		}
		if (
			//reload checkpoint or failed restart mission
			current.mapFile == vars.introMapFile &&
			((old.isLoading &&
			!current.isLoading &&
			((current.playerX - (-18101.34)) < 0.5) &&
			((current.playerY - (-2782.34)) < 0.5) &&
			((current.playerZ - (3076.90)) < 0.5))
			| //new game or restart mission
			(!current.isLoading &&
			!old.start &&
			current.start &&
			((current.playerX - (-18029.99)) < 0.5) &&
			((current.playerY - (-2736.30)) < 0.5) &&
			((current.playerZ - (3073.49)) < 0.5)
			))
		){
			vars.checkpointCounterStart = current.checkpointCounter;
			vars.pauseStart = true; //pause timer on start if menu is open during loading (usually caused by alt+tabbing during load)
			return true;
		}
    }
}

reset {
	if (version == "6, 1, 1, 321") { // Latest patch
		if (current.difficulty == 4){
			//UN difficulty
			return (
				(old.deathReset == 44) &&
				(current.deathReset == 36)
			);
		} else {
			//Other difficulty
			if (current.menuSelection == 2){ vars.resetType = 2;}
			else if (current.menuSelection == 3){ vars.resetType = 3;}
			return (
				current.mapFile == "game/sp/intro/intro" &&
				!old.isLoading &&
				current.isLoading &&
				(((current.menuSelection == 2 |
				((old.deathReset == 44) &&
				(current.deathReset == 36))) &&
				!settings["noCheckpointResets"] &&
				(current.checkpointCounter == vars.checkpointCounterStart)
				)|
				(current.menuSelection == 3
				))
			);
		}
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
    } else if (version == "6, 1, 1, 818") {
        // Previous patch (2017-08-24)
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
        }
        return false;
    } else if (version == "6, 1, 1, 321") {
		// Latest patch (2018-03-29)
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
        }  else if (current.mapFile == "game/sp/intro/intro") {
            if (!vars.hasSplitForIntro && settings["splitForIntro"]) { // Optional intro split when smashing the panel
                bool inUAC = current.mapFile.Equals("game/sp/intro/intro");
                bool correctIntroSplitXPos = Math.Abs(current.playerX - (-10152.54)) < 0.1;
                bool correctIntroSplitYPos = Math.Abs(current.playerY - (-2685.575)) < 0.1;
                bool correctIntroSplitZPos = Math.Abs(current.playerZ - 3148.311) < 0.1;
                bool correctIntroSplitPos = correctIntroSplitXPos && correctIntroSplitYPos && correctIntroSplitZPos;

                if (inUAC && correctIntroSplitPos) {
                    vars.hasSplitForIntro = true;
                    return true;
                }
            }
        } else if (current.mapFile == "game/sp/titan/titan") {
			//Spider Mastermind Skip
			if (
				//need to look in the game scripts to get a more precise trigger location
				(current.playerX > -80) &&
				(current.playerX < 215) &&
				(current.playerY > -80) &&
				(current.playerY < 215) &&
				(current.playerZ > -10080) &&
				(current.playerZ < -9800)
			){
				vars.endCutsceneTriggered = true;
			}
			if (
				(current.finalCutscene == 5) &&
				(old.finalCutscene != 5) &&
				vars.endCutsceneTriggered
			){
				return true;
			}
		} else if (current.isLoading && vars.endCutsceneTriggered) {vars.endCutsceneTriggered = false;}

        return false;
    }
}

isLoading { return (current.isLoading | vars.pauseStart); }

shutdown{
    timer.OnStart -= vars.TimerStart;
}
