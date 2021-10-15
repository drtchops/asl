state("Fallout3","GOG")
{
	bool isLoading : 0xC76CE8;
	bool introDone : 0xC771D0;
}	
state("Fallout3","Steam")
{
	bool introDone : 0xD152B8;
	bool isLoading : 0xE3ABBC;
	
}

init
{
    switch (modules.First().ModuleMemorySize) { // This is to know what version you are playing on
        case  17952768: version = "Steam";
            break;
        case    16166912: version = "GOG"; 
            break;
        default:        version = ""; 
            break;
    }
}

update
{
	if(version=="GOG")
	{
		vars.intro = !(current.introDone);
	}
	else
	{
		vars.intro = current.introDone;
	}
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading || vars.intro;
}
