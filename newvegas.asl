state("FalloutNV")
{
    bool loading : 0xDDA4EC;
    bool introDone : 0xDDA590;
}

update
{
   vars.isLoading = false;
   if ((current.loading) || (!current.introDone)) {
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


