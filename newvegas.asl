state("FalloutNV")
{
    bool loading : 0xDDA4EC;
	bool videoPlaying : "binkw32.dll", 0x54A9C;
	bool introDone : 0xDDA590;
	bool fadeIn : 0xDD884C;
}

update
{
	vars.isLoading = false;
	vars.doReset = false;
	vars.doStart = false;
	if ((current.loading) || (!current.introDone)) {
        vars.isLoading = true;
    }
	if (current.videoPlaying) {
        vars.doReset = true;
    }
	if (current.fadeIn) {
        vars.doStart = true;
    }	
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return vars.isLoading;
}

reset
{
    return vars.doReset;
}

start
{
    return vars.doStart;
}


