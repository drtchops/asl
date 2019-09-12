state("falloutw")
{
    // Fallout 1 (no vars)
}

state("FALLOUT2")
{
    // Fallout 2 (no vars)
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return false;
}
