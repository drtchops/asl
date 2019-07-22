state("Morrowind", "v1.0")
{
	string50 cell : 0x3AEA88, 0xB540, 0x10, 0;
    string50 region : 0x3AEA88, 0xB540, 0x8C, 0x30;
    // float playerX : 0x3AEA88, 0, 0xAC40, 0x38;
    // float playerY : 0x3AEA88, 0, 0xAC40, 0x3C;
    // float playerZ : 0x3AEA88, 0, 0xAC40, 0x40;
    bool playerControlsDisabled : 0x3AEA84, 0x5C, 0x24, 0, 0x5A0;
	bool loadingScreenVisible : 0x3BBCE0;
    bool extraLoadingCheck : 0x3B0704;
	float fadeInTime : 0x3AEA84, 0x348, 0x4;
	// Not 100% certain what this address correlates to but the behavior is as follows
	// 255 when loading or walking around (no menus). 0 When dialog/menu are open... UNLESS mousing over a dialog border, then 1.
	byte dialogIcon : 0x3AEA84, 0x50, 0x14; 
    float gameTime : 0x3AE9B0; 
}

state("Morrowind", "goty")
{
    string50 cell : 0x3C67E0, 0xB540, 0x10, 0;
    string50 region : 0x3C67E0, 0xB540, 0x90, 0x30;
    // float playerX : 0x3AEA88, 0, 0xAC40, 0x38;
    // float playerY : 0x3AEA88, 0, 0xAC40, 0x3C;
    // float playerZ : 0x3AEA88, 0, 0xAC40, 0x40;
    bool playerControlsDisabled : 0x003C67DC, 0x5C, 0x24, 0x0, 0x5B0;
	bool loadingScreenVisible : 0x3D4294;
    bool extraLoadingCheck : 0x3C85B8;
	float fadeInTime : 0x3C67DC, 0x354, 0x4;
	// Not 100% certain what this address correlates to but the behavior is as follows
	// 255 when loading or walking around (no menus). 0 When dialog/menu are open... UNLESS mousing over a dialog border, then 1.
	byte dialogIcon : 0x3C67DC, 0x50, 0x14; 
    float gameTime : 0x3C6708;
}

init
{
	print("[Morrowind NoLoads] Module size: " + modules.First().ModuleMemorySize);
	if (modules.First().ModuleMemorySize == 4431872)
	{
		version = "goty";
	}
	else if (modules.First().ModuleMemorySize == 3981312)
	{
		version = "v1.0";
	}
}

startup
{
    vars.prevPhase = null;
    vars.isLoading = false;
	vars.wasLoading = false;
	vars.loadingChecks = 0;
    vars.doStart = false;
    vars.doSplit = false;
    vars.doReset = false;
    vars.balmoraHasSplit = false;
    vars.potionShopVisited = false;

    settings.Add("any", false, "Any%");
    settings.Add("any_guard", false, "Leave Ship", "any");
    settings.Add("any_redguard", false, "Pick Redguard", "any");
    settings.Add("any_steal", false, "Steal Platter", "any");
    settings.Add("any_ring", false, "Give Ring", "any");
    settings.Add("any_trade", false, "Trade", "any");
    settings.Add("any_rip", false, "Catch ", "any");
    settings.Add("any_walk", false, "Walk", "any");
    settings.Add("any_witch", false, "Buy Potions", "any");
    settings.Add("any_fly", false, "Fly", "any");
    settings.Add("any_dagger", false, "Get Keening", "any");
    settings.Add("any_fast", false, "Go Fast", "any");
    settings.Add("any_hammer", false, "Get Sunder", "any");
    settings.Add("any_noclip", false, "Noclip", "any");
    settings.Add("any_end", false, "End", "any");

    settings.Add("amq", true, "All Main Quests");
    settings.Add("amq_seyda_neen", true, "Seyda Neen", "amq");
    settings.Add("amq_red_mountain", true, "Red Mountain", "amq");
    settings.Add("amq_astral_burial", true, "Astral Burial", "amq");
    settings.Add("amq_potion_shop", true, "Potion Shop", "amq");
    settings.Add("amq_balmora", true, "Balmora", "amq");
    settings.Add("amq_vivec", true, "Vivec", "amq");
    settings.Add("amq_ald_ruhn", true, "Ald-ruhn", "amq");
    settings.Add("amq_sul_matuul", true, "Sul-Matuul", "amq");
    settings.Add("amq_path_of_the_incarnate", true, "Path of the Incarnate", "amq");
    settings.Add("amq_ahemmusa", true, "Ahemmusa", "amq");
    settings.Add("amq_redoran_councillors", true, "Redoran Councillors", "amq");
    settings.Add("amq_sixth_house_base", true, "Sixth House Base", "amq");
    settings.Add("amq_erabenimsun", true, "Erabenimsun", "amq");
    settings.Add("amq_corpus_cure", true, "Corpus Cure", "amq");
    settings.Add("amq_zainab", true, "Zainab", "amq");
    settings.Add("amq_lost_prophecies", true, "Lost Prophecies", "amq");
    settings.Add("amq_redoran", true, "Redoran", "amq");
    settings.Add("amq_hlaalu", true, "Hlaalu", "amq");
    settings.Add("amq_hortator_and_nerevarine", true, "Hortator and Nerevarine", "amq");
    settings.Add("amq_dagoth_ur", true, "Dagoth Ur", "amq");
}

exit
{
    timer.IsGameTimePaused = true;
}

update
{
    current.cell = current.cell != null && current.cell.Length > 0 && current.region != null && current.region.Length > 0
        ? String.Join(" - ", current.cell, current.region)
        : (current.cell != null && current.cell.Length > 0 ? current.cell : current.region);

    if (timer.CurrentPhase == TimerPhase.Running && vars.prevPhase == TimerPhase.NotRunning) {
        // reset split trackers on start
        vars.balmoraHasSplit = false;
        vars.potionShopVisited = false;
    }

    vars.prevPhase = timer.CurrentPhase;
	// Always trust the original loading screen visible
	// Extra loading check added as loadingScreenVisible doesn't handle all cases
	// Extra loading check has a few edge cases (something to do with dialog immediately after journal entry). Check if we still fading in/out
    vars.isLoading = current.loadingScreenVisible || (current.extraLoadingCheck && current.dialogIcon > 1 && current.fadeInTime > 0.0);
    vars.wasLoading = old.loadingScreenVisible || (old.extraLoadingCheck && old.dialogIcon > 1 && old.fadeInTime > 0.0); 
	
	if (vars.isLoading)
	{
		if (!vars.wasLoading)
		{
			print("[Morrowind NoLoads] Started Loading. " + DateTime.Now + "("+ DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond + ") Variables: current.loadingScreenVisible " +current.loadingScreenVisible+ " current.extraLoadingCheck " +current.extraLoadingCheck+ " current.dialogIcon " +current.dialogIcon + " last gametime " + old.gameTime + " current gameTime " + current.gameTime);
		}
		
		vars.loadingChecks++;
	}
	else
	{
		if (vars.wasLoading)
		{
			print("[Morrowind NoLoads] Finished Loading after " + vars.loadingChecks + " checks. " + DateTime.Now + "("+ DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond + ") Variables: current.loadingScreenVisible " +current.loadingScreenVisible+ " current.extraLoadingCheck " +current.extraLoadingCheck+ " current.dialogIcon " +current.dialogIcon + " last gametime " + old.gameTime + " current gameTime " + current.gameTime);
			
			vars.loadingChecks = 0;
		}
	}

    vars.doStart = false;
    vars.doSplit = false;
    vars.doReset = false;

    if (current.playerControlsDisabled != old.playerControlsDisabled) {
        if (current.playerControlsDisabled) {
            print("[Morrowind NoLoads] player controls disabled");

            if (current.cell == "Dagoth Ur, Facility Cavern" && (settings["any_end"] || settings["amq_dagoth_ur"])) {
                // split 20 Dagoth Ur
                vars.doSplit = true;
            }
        } else {
            print("[Morrowind NoLoads] player controls enabled");

            if (!current.loadingScreenVisible && current.cell == "Imperial Prison Ship") {
                // start
                vars.doStart = true;
            }
        }
    }

    if (current.cell != old.cell) {
        print(String.Format("[Morrowind NoLoads] cell changed from '{0}' to '{1}'", old.cell, current.cell));

        // Any%
        if (settings["any"]) {
            if (settings["any_guard"] && old.cell == "Imperial Prison Ship") {
                vars.doSplit = true;
            } else if (settings["any_redguard"] && current.cell == "Seyda Neen, Census and Excise Office") {
                vars.doSplit = true;
            } else if (settings["any_steal"] && old.cell == "Seyda Neen, Census and Excise Office") {
                vars.doSplit = true;
            } else if (settings["any_ring"] && current.cell == "Seyda Neen, Arrille's Tradehouse") {
                vars.doSplit = true;
            } else if (settings["any_trade"] && old.cell == "Seyda Neen, Arrille's Tradehouse") {
                vars.doSplit = true;
            } else if (settings["any_rip"] && old.cell == "Bitter Coast Region" && current.cell == "Balmora - West Gash Region") {
                vars.doSplit = true;
            } else if (settings["any_walk"] && current.cell == "Balmora, Nalcarya of White Haven: Fine Alchemist") {
                vars.doSplit = true;
            } else if (settings["any_witch"] && old.cell == "Balmora, Nalcarya of White Haven: Fine Alchemist") {
                vars.doSplit = true;
            } else if (settings["any_fly"] && old.cell == "Odrosal - Red Mountain Region" && current.cell == "Odrosal, Dwemer Training Academy") {
                vars.doSplit = true;
            } else if (settings["any_dagger"] && old.cell == "Odrosal, Dwemer Training Academy" && current.cell != "Odrosal, Tower") {
                vars.doSplit = true;
            } else if (settings["any_fast"] && current.cell == "Vemynal, Outer Fortress") {
                vars.doSplit = true;
            } else if (settings["any_hammer"] && old.cell == "Vemynal, Hall of Torque") {
                vars.doSplit = true;
            } else if (settings["any_noclip"] && current.cell == "Akulakhan's Chamber") {
                vars.doSplit = true;
            }
        }

        if (settings["amq"]) {
            if (settings["amq_seyda_neen"] && old.cell == "Bitter Coast Region" && current.cell == "Balmora - West Gash Region") {
                // split 01 Seyda Neen
                vars.doSplit = true;
            } else if (settings["amq_red_mountain"] && old.cell == "Vemynal, Outer Fortress" && current.cell != "Vemynal, Hall of Torque") {
                // split 02 Red Mountain
                vars.doSplit = true;
            } else if (settings["amq_astral_burial"] && old.cell == "Urshilaku, Juno Burial") {
                // split 03 Astral Burial
                vars.doSplit = true;
            } else if (settings["amq_potion_shop"] && old.cell == "Balmora, Nalcarya of White Haven: Fine Alchemist" && vars.potionShopVisited) {
                // split 04 Potion Shop
                vars.doSplit = true;
            } else if (settings["amq_balmora"] && old.cell == "Balmora - West Gash Region" && current.cell == "Vivec - Ascadian Isles Region" && !vars.balmoraHasSplit) {
                // split 05 Balmora
                vars.doSplit = true;
                // split make sure this doesn't double split
                vars.balmoraHasSplit = true;
            } else if (settings["amq_vivec"] && old.cell == "Vivec, Library of Vivec") {
                // split 06 Vivec
                vars.doSplit = true;
            } else if (settings["amq_ald_ruhn"] && old.cell == "Ald-ruhn - Ashlands Region" && current.cell == "Khuul - West Gash Region") {
                // split 07 Ald-ruhn
                vars.doSplit = true;
            } else if (settings["amq_sul_matuul"] && old.cell == "Urshilaku Camp, Wise Woman's Yurt") {
                // split 08 Sul-Matuul
                vars.doSplit = true;
            } else if (settings["amq_path_of_the_incarnate"] && old.cell == "Cavern of the Incarnate") {
                // split 09 Path of the Incarnate
                vars.doSplit = true;
            } else if (settings["amq_ahemmusa"] && old.cell == "Urshilaku Camp, Ashkhan's Yurt" && current.cell == "Ald-ruhn - Ashlands Region") {
                // split 10 Ahemmusa
                vars.doSplit = true;
            } else if (settings["amq_redoran_councillors"] && old.cell == "Ald-ruhn - Ashlands Region" && current.cell == "Balmora - West Gash Region") {
                // split 11 Redoran Councillors
                vars.doSplit = true;
            } else if (settings["amq_sixth_house_base"] && old.cell == "Vivec - Ascadian Isles Region" && current.cell == "Molag Mar - Molag Amur Region") {
                // split 12 Sixth House Base
                vars.doSplit = true;
            } else if (settings["amq_erabenimsun"] && old.cell == "Erabenimsun Camp, Han-Ammu's Yurt") {
                // split 13 Erabenimsun
                vars.doSplit = true;
            } else if (settings["amq_corpus_cure"] && old.cell == "Tower of Tel Fyr, Hall of Fyr" && current.cell == "Wolverine Hall - Azura's Coast Region") {
                // split 14 Corpus Cure
                vars.doSplit = true;
            } else if (settings["amq_zainab"] && old.cell == "Zainab Camp, Ashkhan's Yurt" && current.cell == "Vivec - Ascadian Isles Region") {
                // split 15 Zainab
                vars.doSplit = true;
            } else if (settings["amq_lost_prophecies"] && old.cell == "Holamayan Monastery" && current.cell == "Vivec - Ascadian Isles Region") {
                // split 16 Lost Prophecies
                vars.doSplit = true;
            } else if (settings["amq_redoran"] && old.cell == "Ald-ruhn, Sarethi Manor" && current.cell == "Vivec - Ascadian Isles Region") {
                // split 17 Redoran
                vars.doSplit = true;
            } else if (settings["amq_hlaalu"] && old.cell == "Vivec, Curio Manor" && current.cell == "Vivec, Temple - Ascadian Isles Region") {
                // split 18 Hlaalu
                vars.doSplit = true;
            } else if (settings["amq_hortator_and_nerevarine"] && old.cell == "Vivec, Palace of Vivec" && current.cell == "Vivec - Ascadian Isles Region") {
                // split 19 Hortator and Nerevarine
                vars.doSplit = true;
            }
        }

        if (old.cell == "Balmora, Nalcarya of White Haven: Fine Alchemist") {
            // enable potion shop split
            vars.potionShopVisited = true;
        }
    }

    if (current.loadingScreenVisible != old.loadingScreenVisible) {
        if (current.loadingScreenVisible) {
            print("[Morrowind NoLoads] Loading screen started");
        } else {
            print("[Morrowind NoLoads] Loading screen ended");

            if (current.cell == "Imperial Prison Ship") {
                // load finish in prison ship means reset
                vars.doReset = true;
            }
        }
    }

    // if (old.playerX != current.playerX || old.playerY != current.playerY || old.playerZ != current.playerZ)
    //     print(String.Format("[Morrowind NoLoads] x,y,z changed from {0},{1},{2} to {3},{4},{5}", old.playerX, old.playerY, old.playerZ, current.playerX, current.playerY, current.playerZ));
}

start
{
    return vars.doStart;
}

split
{
    return vars.doSplit;
}

reset
{
    return vars.doReset;
}

isLoading
{
    return vars.isLoading;
}

// Any%
// 01 from 'Imperial Prison Ship' to 'Ashlands Region'
//      or 'Ashlands Region' to 'Seyda Neen - Bitter Coast Region'
// 02 from 'Seyda Neen - Bitter Coast Region' to 'Seyda Neen, Census and Excise Office'
// 03 from 'Seyda Neen, Census and Excise Office' to 'Ashlands Region'
//      or 'Ashlands Region' to 'Seyda Neen - Bitter Coast Region'
// 04 from 'Seyda Neen - Bitter Coast Region' to 'Seyda Neen, Arrille's Tradehouse'
// 05 from 'Seyda Neen, Arrille's Tradehouse' to 'West Gash Region'
// 06 from 'Bitter Coast Region' to 'Balmora - West Gash Region'
// 07 from 'Balmora - West Gash Region' to 'Balmora, Nalcarya of White Haven: Fine Alchemist'
// 08 from 'Balmora, Nalcarya of White Haven: Fine Alchemist' to 'Balmora - West Gash Region'
// 09 from 'Odrosal - Red Mountain Region' to 'Odrosal, Dwemer Training Academy'
// 10 from 'Odrosal, Dwemer Training Academy' to 'Ashlands Region'
//      or 'Ashlands Region' to 'Odrosal - Red Mountain Region'
// 11 from 'Vemynal - Red Mountain Region' to 'Vemynal, Outer Fortress'
// 12 from 'Vemynal, Hall of Torque' to 'Dagoth Ur - Red Mountain Region'
// 13 from 'Dagoth Ur, Facility Cavern' to 'Akulakhan's Chamber'
// 14 last split

// AMQ
// 01 from 'Bitter Coast Region' to 'Balmora - West Gash Region'
// 02 from 'Vemynal, Outer Fortress' to 'Ashlands Region'
//      or 'Ashlands Region' to 'Vemynal - Red Mountain Region'
// 03 from 'Urshilaku, Juno Burial' to 'Balmora, Nalcarya of White Haven: Fine Alchemist'
// 04 from 'Balmora, Milie Hastien: Fine Clothier' to 'West Gash Region'
//      or 'West Gash Region' to 'Balmora - West Gash Region'
// 05 from 'Balmora - West Gash Region' to 'Vivec - Ascadian Isles Region'
// 06 from 'Vivec, Library of Vivec' to 'Balmora, Caius Cosades' House'
// 07 from 'Ald-ruhn - Ashlands Region' to 'Khuul - West Gash Region'
// 08 from 'Urshilaku Camp, Wise Woman's Yurt' to 'West Gash Region'
//      or 'West Gash Region' to 'Urshilaku Camp - Ashlands Region'
// 09 from 'Cavern of the Incarnate' to 'Ashlands Region'
// 10 from 'Urshilaku Camp, Ashkhan's Yurt' to 'Ald-ruhn - Ashlands Region'
// 11 from 'Ald-ruhn - Ashlands Region' to 'Balmora - West Gash Region'
// 12 from 'Vivec - Ascadian Isles Region' to 'Molag Mar - Molag Amur Region'
// 13 from 'Erabenimsun Camp, Han-Ammu's Yurt' to 'Ashlands Region'
//      or 'Ashlands Region' to 'Erabenimsun Camp - Molag Amur Region'
// 14 from 'Tower of Tel Fyr, Hall of Fyr' to 'Wolverine Hall - Azura's Coast Region'
// 15 from 'Zainab Camp, Ashkhan's Yurt' to 'Vivec - Ascadian Isles Region'
// 16 from 'Holamayan Monastery' to 'Vivec - Ascadian Isles Region'
// 17 from 'Ald-ruhn, Sarethi Manor' to 'Vivec - Ascadian Isles Region'
// 18 from 'Vivec, Curio Manor' to 'Vivec, Temple - Ascadian Isles Region'
// 19 from 'Vivec, Palace of Vivec' to 'Vivec - Ascadian Isles Region'
// 20 last split
