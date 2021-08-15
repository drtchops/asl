// Original by ToxicTT and DrTChops.

state("Yakuza0")
{
	int Loading    : 0x132C520, 0xA38, 0x38, 0x4A0, 0x4A0, 0x4A0, 0x1EDC;
	string15 State : 0x1305FC8, 0x50, 0x6E2;
	string40 Map   : 0x1163F28, 0x150, 0x18, 0x50;
}

startup
{
	string[,] SubChapters =
	{
		{ "Chapter 1", "1_Nakamichi St. Entrance", "Visited Dojima Family HQ", "Splits when you are back in Kamurocho and about to fight Bruno." },
		{ "Chapter 1", "1_Dojima Family HQ", "Arrived at Dojima Family HQ to fight", "Splits on the first cutscene of the HQ." },

		{ "Chapter 2", "2_Hotel District", "Visited Kiryu's Apartment", "Splits when you are back in Kamurocho, Hotel District." },
		{ "Chapter 2", "2_Public Park 3", "Arrived in Public Park 3 to homeless men", "Splits right as you step into that little park area." },

		{ "Chapter 3", "3_Sotenbori St. West", "Out of Cabaret Grand", "Splits after you first leave your cabaret." },
		{ "Chapter 3", "3_Shofukucho South", "Out of Club Odyssey", "Splits when you leave Odyssey club and about to talk on the payphone." },

		{ "Chapter 4", "4_Shofukucho East", "Out of Maharaja", "Splits when you leave Maharaja and about to fight outside." },
		{ "Chapter 4", "4_Shofukucho South", "Out of Hogushi Kaikan Massage", "Splits when you leave the clinic and start looking for Makoto." },

		{ "Chapter 5", "5_Serena Backlot", "Out of Serena", "Splits once you exit out of Serena bar, before the fight." },

		{ "Chapter 6", "6_Near Kiryu's Apartment", "Out of Komurocho to Kiryu's Apartment", "Splits when you arrive in the area near Kiryu's Apartment." },
		{ "Chapter 6", "6_Sewer", "Into the Sewer", "Splits when you step into the sewers." },

		{ "Chapter 7", "7_Magutako", "Bought takoyaki", "Splits after you bought takoyaki and heading back to Makoto." },
		{ "Chapter 7", "7_Hoganji Yokocho", "Went through the hidden door in clinic", "Splits when you stepped through the hidden door in Hogushi Kaikan Massage and appeared in the back alley." },

		{ "Chapter 8", "8_Sotenbori St. West", "Out of Cabaret Grand", "Splits when you exit out of cabaret after Nishitani fight." },
		{ "Chapter 8", "8_Shofukucho", "Reached the 2nd stealth section", "Splits when you get to Shofukucho street, the 2nd stealth section." },

		{ "Chapter 9", "9_Serena Backlot", "Out of Serena", "Splits when you done fighting in Serena and exit through the backdoor." },

		{ "Chapter 10", "10_Tojo Clan Headquarters", "Arrived at Tojo Clan HQ", "Splits when you arrive at Tojo Clan HQ." },
		{ "Chapter 10", "10_Pier", "Out of Tojo Clan HQ (Pier cutscene)", "Splits once you escape from Tojo Clan HQ, on pier cutscene." },

		{ "Chapter 11", "11_Bishamon Bridge", "Out of Colosseum", "Splits once you are back at the bridge after The Bed of Styx." },

		{ "Chapter 13", "13_Benten Inn", "Got to Benten Inn", "Splits when Oda and Kiryu reach Benten Inn, right before the chase begins." },
		{ "Chapter 13", "13_Building Under Construction", "Got to Building Under Construction", "Splits once you get to the construction site." },

		{ "Chapter 14", "14_Crescendo Building", "Got to Crescendo Building", "Splits once you get to the door of Crescendo Building." },

		{ "Chapter 15", "15_Certain Rooftop", "Got to rooftop with Kashiwagi", "Splits once get to the rooftop of Kazama HQ." },
		{ "Chapter 15", "15_Nakamichi Alley", "Back on the streets after Kashiwagi fight", "Splits after the Kashiwagi fight, on Nakamichi Alley." },
		{ "Chapter 15", "15_Tenkaichi St.", "Out of Serena", "Splits after Nishiki fight, on Tenkaichi St." },

		{ "Chapter 16", "16_Children's Park", "Reached Children's Park with Makoto", "Splits when cutscene in Children's Park starts." },
		{ "Chapter 16", "16_Sebastian Building", "Reached Sebastian Building", "Splits once you reach Sebastian Building." },

		{ "Chapter 17", "17_Sagawa's Secret Office", "Out of Kamurocho", "Splits when you get to the office with Majima after leaving Kamurocho." },
		{ "Chapter 17", "17_Dojima Family HQ", "Finished fighting through the Consortium Ship", "Splits once you done going through the ship and switched to Majima." },
		{ "Chapter 17", "17_Dojima Family HQ Top Floor", "Reached the top floor of Dojima HQ", "Splits once you enter the cutscene with Awano." },
		{ "Chapter 17", "17_Nikkyo Consortium Ship", "Finished with Dojima HQ fights", "Splits once you done fighting at Dojima HQ and transitioned to the Consortium Ship." }
	};

	settings.Add("Chapters", true, "Split on the end of each chapter");

	for (int i = 1; i <= 17; ++i)
		settings.Add("Chapter " + i, false);

	for (int i = 0; i < SubChapters.GetLength(0); ++i)
	{
		string parent = SubChapters[i, 0];
		string id = SubChapters[i, 1];
		string desc = SubChapters[i, 2];
		string tt = SubChapters[i, 3];

		settings.Add(id, false, desc, parent);
		settings.SetToolTip(id, tt);
	}

	vars.TimerStart = (EventHandler) ((s, e) => vars.Chapter = 1);
	timer.OnStart += vars.TimerStart;
}

init
{
	vars.Chapter = 1;
	vars.LastValidMap = "";
}

update
{
	if (!string.IsNullOrEmpty(old.Map) && string.IsNullOrEmpty(current.Map))
		vars.LastValidMap = old.Map;
}

split
{
	if (old.State != "pjcm_result.sbb" && current.State == "pjcm_result.sbb")
	{
		++vars.Chapter;
		return settings["Chapters"];
	}

	return vars.LastValidMap != current.Map && settings[vars.Chapter + "_" + (vars.LastValidMap = current.Map)];
}

isLoading
{
	return current.Loading == 1;
}

shutdown
{
	timer.OnStart -= vars.TimerStart;
}