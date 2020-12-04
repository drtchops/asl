state("Fallout3")
{
    bool isLoading : 0xC76CE8;
	bool introDone : 0xC771D0;
}
update
{
   vars.isLoading = false;
   if ((current.isLoading) || (!current.introDone)) {
        vars.isLoading = true;
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
