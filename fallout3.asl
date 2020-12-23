state("Fallout3")
{
	bool isLoading : 0xC76CE8;
	bool introDone : 0xC771D0;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading || !current.introDone;
}
