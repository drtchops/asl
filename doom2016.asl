// People who collectively worked on this:
// DrTChops
// TheFuncannon
// loitho
// sychotixx
// Instagibz
// blairmadison11
// probably more

//===NOTES AND CHANGELOG===//
//Glurmo						@21\01\19:	Fixed map name pointer for steam update (4.89.17.15) + added skipping of rune loadscreens for 100%
//Instagibz						@04\04\18:	Updated the splitter for latest 6,1,1,321 version, VULKAN only
//Loitho						@13\10\17:	Fixed mapname variable. Invalid pointer caused by a steam update of the tier0_s64.dll | Works for Steam >= 4.17.60.88
//Loitho						@09\09\17:	Fixed the splitter for auto split on last boss hit 6,1,1,818 - Vulkan only
//blairmadison11				@02\09\17:	Partially updated the splitter for the latest 6,1,1,818, VULKAN only
//Instagibz & blairmadison11	@22\07\17:	Updated the splitter for the latest 6,1,1,513 version, VULKAN only for now. Note: Versioning changed back from 6,1,1,1219 to 6,1,1,513
//Instagibz                     @29\01\17:	Updated the splitter for latest steam-api change
//Instagibz						@20\12\16:	Updated the splitter for latest 6,1,1,1219 version, VULKAN only for now
//Instagibz						@08\12\16:	Updated the splitter for latest 6,1,1,1201 version, VULKAN only for now
//Instagibz						@14\11\16:	Updated the splitter for latest 6,1,1,1109 version
//Instagibz						@19\10\16:	Updated the splitter for latest 6,1,1,1012 version
//Instagibz						@30\09\16:	Added auto-end to 6,1,1,706 also changed auto-start, was broken for me a few times
//TheFuncannon					@30\09\16:	Updated the OGL version 6,1,1,706 to auto-start 
//Instagibz						@30\09\16:	Updated the vulkan and OGL version 6,1,1,920 to auto-start, auto-split and auto-end the run. Requires 13 splits 
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
	bool start: 0x5684168;                          				//NOT UPDATED YET
	bool canStart: 0x2C14A44;                       				//NOT UPDATED YET
	bool finalHit: 0x535F274;                       				//NOT UPDATED YET
	bool isLoading: 0x535EE10;                      				//NOT UPDATED YET
	string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;  				//NOT UPDATED YET
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
	bool start: 0x57BDEE0;                          				//NOT UPDATED YET
	bool canStart: 0x54DC3D8;                       				//NOT UPDATED YET
	bool finalHit: 0x535F274;                       				//NOT UPDATED YET
	bool isLoading: 0x56844C9;                      				//NOT UPDATED YET
	string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;  				//NOT UPDATED YET
}

state("DOOMx64vk", "6, 1, 1, 531") {
	float bossHealth: 0x4C6F9D0, 0x30, 0x4E8, 0x2F0, 0x1B4;
	bool start: 0x57BDEE0;
	bool canStart: 0x54DC3D8;
	bool finalHit: 0x53C5DD4;
	bool isLoading: 0x56844C9;
	string35 mapName: "tier0_s64.dll", 0x4E170, 0x17;
}

state("DOOMx64vk", "6, 1, 1, 818") {
	float bossHealth: 0x2B0F3C0, 0x2CD80, 0x2B78; 		// Fixed
	bool start: 0x5686EE0;								// confirmed working
	bool canStart: 0x53A53D8;							// confirmed working
	bool finalHit: 0x528EDB4;							// confirmed working
	bool isLoading: 0x554D4C9;							// confirmed working
	
	string35 mapName: "tier0_s64.dll", 0x58180, 0x17;
}

state("DOOMx64vk", "6, 1, 1, 321") {
	float bossHealth: 0x307EF08, 0x2CD80, 0x2B78;
	bool start: 0x597FCD0;
	bool canStart: 0x56BF5D8;
	bool finalHit: 0x5557504;
	bool isLoading: 0x5845a29;

	string35 mapName: "tier0_s64.dll", 0x58180, 0x17;

}

init {
	version = modules.First().FileVersionInfo.FileVersion;
	print(version);
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
	} else if (version == "6, 1, 1, 706" || version == "6, 1, 1, 920" || version == "6, 1, 1, 1012" || version == "6, 1, 1, 1109" || version == "6, 1, 1, 1201" || version == "6, 1, 1, 1219" || version == "6, 1, 1, 531" || version == "6, 1, 1, 818" || version == "6, 1, 1, 321") {
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
	} else if (version == "6, 1, 1, 706" || version == "6, 1, 1, 920" || version == "6, 1, 1, 1012" || version == "6, 1, 1, 1109" || version == "6, 1, 1, 1201" || version == "6, 1, 1, 1219" || version == "6, 1, 1, 531" || version == "6, 1, 1, 818" || version == "6, 1, 1, 321") {
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
			current.bossHealth == 1);
		}
}

isLoading { return current.isLoading; }
