// Yakuza 0 (PC, Steam) autosplitter & load remover
// Autosplitter by ToxicTT (Discord: ToxicTT#4487)
// Thank you rythin_sr for the advice, Drake_Shadow and JustSayKuro for initial testing.
// Description: https://pastebin.com/uTDJEGCk
// Load remover by DrTChops

state("Yakuza0")
{
    int loadState : 0x132C520, 0xA38, 0x38, 0x4A0, 0x4A0, 0x4A0, 0x1EDC;
    string15 gameState : 0x01305FC8, 0x50, 0x6E2;
    string40 location : 0x01163F28, 0x150, 0x18, 0x50;
}

startup
{
    vars.isLoading = false;
    vars.doSplit = false;
    vars.chapter = 1;
    vars.postEmptyLocation = "";
    vars.prevPhase = timer.CurrentPhase;

    settings.Add("Chapters", true, "Split on the end of each chapter");
    settings.Add("Main", false, "Optional splits (check tooltips)");

    settings.Add("ch1", false, "Chapter 1", "Main");
    settings.Add("ch1A", false, "Visited Dojima Family HQ", "ch1");
    settings.SetToolTip("ch1A", "Splits when you are back in Kamurocho and about to fight Bruno.");
    settings.Add("ch1B", false, "Arrived at Dojima Family HQ to fight", "ch1");
    settings.SetToolTip("ch1B", "Splits on the first cutscene of the HQ.");

    settings.Add("ch2", false, "Chapter 2", "Main");
    settings.Add("ch2A", false, "Visited Kiryu's Apartment", "ch2");
    settings.SetToolTip("ch2A", "Splits when you are back in Kamurocho, Hotel District.");
    settings.Add("ch2B", false, "Arrived in Public Park 3 to homeless men", "ch2");
    settings.SetToolTip("ch2B", "Splits right as you step into that little park area.");

    settings.Add("ch3", false, "Chapter 3", "Main");
    settings.Add("ch3A", false, "Out of Cabaret Grand", "ch3");
    settings.SetToolTip("ch3A", "Splits after you first leave your cabaret.");
    settings.Add("ch3B", false, "Out of Club Odyssey", "ch3");
    settings.SetToolTip("ch3B", "Splits when you leave Odyssey club and about to talk on the payphone.");

    settings.Add("ch4", false, "Chapter 4", "Main");
    settings.Add("ch4A", false, "Out of Maharaja", "ch4");
    settings.SetToolTip("ch4A", "Splits when you leave Maharaja and about to fight outside.");
    settings.Add("ch4B", false, "Out of Hogushi Kaikan Massage", "ch4");
    settings.SetToolTip("ch4B", "Splits when you leave the clinic and start looking for Makoto.");

    settings.Add("ch5", false, "Chapter 5", "Main");
    settings.Add("ch5A", false, "Out of Serena", "ch5");
    settings.SetToolTip("ch5A", "Splits once you exit out of Serena bar, before the fight");

    settings.Add("ch6", false, "Chapter 6", "Main");
    settings.Add("ch6A", false, "Out of Komurocho to Kiryu's Apartment", "ch6");
    settings.SetToolTip("ch6A", "Splits when you arrive in the area near Kiryu's Apartment.");
    settings.Add("ch6B", false, "Into the Sewer", "ch6");
    settings.SetToolTip("ch6B", "Splits when you step into the sewers.");

    settings.Add("ch7", false, "Chapter 7", "Main");
    settings.Add("ch7A", false, "Bought takoyaki", "ch7");
    settings.SetToolTip("ch7A", "Splits after you bought takoyaki and heading back to Makoto.");
    settings.Add("ch7B", false, "Went through the hidden door in clinic", "ch7");
    settings.SetToolTip("ch7B", "Splits when you stepped through the hidden door in Hogushi Kaikan Massage and appeared in the back alley.");

    settings.Add("ch8", false, "Chapter 8", "Main");
    settings.Add("ch8A", false, "Out of Cabaret Grand", "ch8");
    settings.SetToolTip("ch8A", "Splits when you exit out of cabaret after Nishitani fight.");
    settings.Add("ch8B", false, "Reached the 2nd stealth section", "ch8");
    settings.SetToolTip("ch8B", "Splits when you get to Shofukucho street, the 2nd stealth section.");

    settings.Add("ch9", false, "Chapter 9", "Main");
    settings.Add("ch9A", false, "Out of Serena", "ch9");
    settings.SetToolTip("ch9A", "Splits when you done fighting in Serena and exit through the backdoor.");

    settings.Add("ch10", false, "Chapter 10", "Main");
    settings.Add("ch10A", false, "Arrived at Tojo Clan HQ", "ch10");
    settings.SetToolTip("ch10A", "Splits when you arrive at Tojo Clan HQ.");
    settings.Add("ch10B", false, "Out of Tojo Clan HQ (Pier cutscene)", "ch10");
    settings.SetToolTip("ch10B", "Splits once you escape from Tojo Clan HQ, on pier cutscene.");

    settings.Add("ch11", false, "Chapter 11", "Main");
    settings.Add("ch11A", false, "Out of colosseum", "ch11");
    settings.SetToolTip("ch11A", "Splits once you are back at the bridge after The Bed of Styx.");

    // no splits for ch 12
    // short chapter, all in the same location

    settings.Add("ch13", false, "Chapter 13", "Main");
    settings.Add("ch13A", false, "Got to Benten Inn", "ch13");
    settings.SetToolTip("ch13A", "Splits when Oda and Kiryu reach Benten Inn, right before the chase begins.");
    settings.Add("ch13B", false, "Got to Building Under Construction", "ch13");
    settings.SetToolTip("ch13B", "Splits once you get to the construction site.");

    settings.Add("ch14", false, "Chapter 14", "Main");
    settings.Add("ch14A", false, "Got to Crescendo Building", "ch14");
    settings.SetToolTip("ch14A", "Splits once you get to the door of Crescendo Building.");

    settings.Add("ch15", false, "Chapter 15", "Main");
    settings.Add("ch15A", false, "Got to rooftop with Kashiwagi", "ch15");
    settings.SetToolTip("ch15A", "Splits once get to the rooftop of Kazama HQ.");
    settings.Add("ch15B", false, "Back on the streets after Kashiwagi fight", "ch15");
    settings.SetToolTip("ch15B", "Splits after the Kashiwagi fight, on Nakamichi Alley.");
    settings.Add("ch15C", false, "Out of Serena", "ch15");
    settings.SetToolTip("ch15C", "Splits after Nishiki fight, on Tenkaichi St.");

    settings.Add("ch16", false, "Chapter 16", "Main");
    settings.Add("ch16A", false, "Reached Children's Park with Makoto", "ch16");
    settings.SetToolTip("ch16A", "Splits when cutscene in Children's Park starts.");
    settings.Add("ch16B", false, "Reached Sebastian Building", "ch16");
    settings.SetToolTip("ch16B", "Splits once you reach Sebastian Building.");

    settings.Add("ch17", false, "Chapter 17", "Main");
    settings.Add("ch17A", false, "Out of Kamurocho", "ch17");
    settings.SetToolTip("ch17A", "Splits when you get to the office with Majima after leaving Kamurocho.");
    settings.Add("ch17B", false, "Finished fighting through the Consortium Ship", "ch17");
    settings.SetToolTip("ch17B", "Splits once you done going through the ship and switched to Majima.");
    settings.Add("ch17C", false, "Reached the top floor of Dojima HQ", "ch17");
    settings.SetToolTip("ch17C", "Splits once you enter the cutscene with Awano.");
    settings.Add("ch17D", false, "Finished with Dojima HQ fights", "ch17");
    settings.SetToolTip("ch17D", "Splits once you done fighting at Dojima HQ and transitioned to the Consortium Ship.");
}

update
{
    vars.isLoading = current.loadState == 1;
    vars.doSplit = false;

    // reset chapter on both manual start or auto start (if it ever gets added)
    if (timer.CurrentPhase == TimerPhase.Running && vars.prevPhase == TimerPhase.NotRunning)
    {
        vars.chapter = 1;
    }
    vars.prevPhase = timer.CurrentPhase;

    if (current.location == "" && old.location != "")
    {
        vars.postEmptyLocation = old.location;
    }

    if (current.gameState == "pjcm_result.sbb" && old.gameState != "pjcm_result.sbb")
    {
        vars.chapter++;
        vars.doSplit = settings["Chapters"];
    }
    else if (vars.chapter == 1)
    {
        if (current.location == "Nakamichi St. Entrance" && vars.postEmptyLocation == "Dojima Family HQ")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch1A"];
        }
        else if (current.location == "Dojima Family HQ" && vars.postEmptyLocation == "Tenkaichi St. Entrance")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch1B"];
        }
    }
    else if (vars.chapter == 2)
    {
        if (current.location == "Hotel District" && vars.postEmptyLocation == "Near Kiryu's Apartment")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch2A"];
        }
        else if (current.location == "Public Park 3" && old.location == "Tenkaichi Alley" && vars.postEmptyLocation != "Public Park 3")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch2B"];
        }
    }
    else if (vars.chapter == 3)
    {
        if (current.location == "Sotenbori St. West" && vars.postEmptyLocation == "Cabaret Grand")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch3A"];
        }
        else if (current.location == "Shofukucho South" && vars.postEmptyLocation == "Odyssey")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch3B"];
        }
    }
    else if (vars.chapter == 4)
    {
        if (current.location == "Shofukucho East" && vars.postEmptyLocation == "Maharaja Sotenbori")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch4A"];
        }
        else if (current.location == "Shofukucho South" && vars.postEmptyLocation == "Hogushi Kaikan Massage")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch4B"];
        }
    }
    else if (vars.chapter == 5)
    {
        if (current.location == "Serena Backlot" && vars.postEmptyLocation == "Serena")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch5A"];
        }
    }
    else if (vars.chapter == 6)
    {
        if (current.location == "Near Kiryu's Apartment" && vars.postEmptyLocation == "Hotel District")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch6A"];
        }
        else if (current.location == "Sewer" && vars.postEmptyLocation == "Asia")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch6B"];
        }
    }
    else if (vars.chapter == 7)
    {
        if (current.location != "Magutako" && old.location == "Magutako" && vars.postEmptyLocation != "Magutako")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch7A"];
        }
        else if (current.location == "Hoganji Yokocho" && vars.postEmptyLocation == "Hogushi Kaikan Massage")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch7B"];
        }
    }
    else if (vars.chapter == 8)
    {
        if (current.location == "Sotenbori St. West" && vars.postEmptyLocation == "Cabaret Grand")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch8A"];
        }
        else if (current.location == "Shofukucho" && vars.postEmptyLocation == "Odyssey's Warehouse")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch8B"];
        }
    }
    else if (vars.chapter == 9)
    {
        if (current.location == "Serena Backlot" && vars.postEmptyLocation == "Serena")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch9A"];
        }
    }
    else if (vars.chapter == 10)
    {
        if (current.location == "Tojo Clan Headquarters" && vars.postEmptyLocation == "West Park")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch10A"];
        }
        else if (current.location == "Pier" && vars.postEmptyLocation == "Tojo Clan Headquarters")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch10B"];
        }
    }
    else if (vars.chapter == 11)
    {
        if (current.location == "Bishamon Bridge" && vars.postEmptyLocation == "The Bed of Styx")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch11A"];
        }
    }
    else if (vars.chapter == 13)
    {
        if (current.location == "Benten Inn" && vars.postEmptyLocation == "CAL Videos")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch13A"];
        }
        else if (current.location == "Building Under Construction" && vars.postEmptyLocation == "Benten Inn")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch13B"];
        }
    }
    else if (vars.chapter == 14)
    {
        if (current.location == "Crescendo Building" && vars.postEmptyLocation == "West Park")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch14A"];
        }
    }
    else if (vars.chapter == 15)
    {
        if (current.location == "Certain Rooftop" && vars.postEmptyLocation == "Tenkaichi St.")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch15A"];
        }
        else if (current.location == "Nakamichi Alley" && vars.postEmptyLocation == "Certain Rooftop")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch15B"];
        }
        else if (current.location == "Tenkaichi St." && vars.postEmptyLocation == "Serena")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch15C"];
        }
    }
    else if (vars.chapter == 16)
    {
        if (current.location == "Children's Park" && old.location == "Theater Square" && vars.postEmptyLocation == "The Empty Lot")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch16A"];
        }
        else if (current.location == "Sebastian Building" && vars.postEmptyLocation == "Park Blvd.")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch16B"];
        }
    }
    else if (vars.chapter == 17)
    {
        if (current.location == "Sagawa's Secret Office" && vars.postEmptyLocation == "Tenkaichi St. Entrance")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch17A"];
        }
        else if (current.location == "Dojima Family HQ" && vars.postEmptyLocation == "Nikkyo Consortium Ship")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch17B"];
        }
        else if (current.location == "Dojima Family HQ Top Floor" && vars.postEmptyLocation == "Dojima Family HQ")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch17C"];
        }
        else if (current.location == "Nikkyo Consortium Ship" && vars.postEmptyLocation == "Dojima Family HQ Top Floor")
        {
            vars.postEmptyLocation = current.location;
            vars.doSplit = settings["ch17D"];
        }
    }
}

split
{
    return vars.doSplit;
}

isLoading
{
    return vars.isLoading;
}
