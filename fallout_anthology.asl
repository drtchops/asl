state("falloutw")
{
    // Fallout 1 (no vars)
}

state("FALLOUT2")
{
    // Fallout 2 (no vars)
}

state("Fallout3")
{
    // Fallout 3
    bool isLoading : 0xC76CE8;
}

state("FalloutNV")
{
    // Fallout: New Vegas
    bool isLoading : 0xDDA4EC;
}

isLoading
{
    if (timer.CurrentSplit.Name.ToLower().Contains("setup")) {
        return true;
    } else if (game.ProcessName == "Fallout3" || game.ProcessName == "FalloutNV") {
        return current.isLoading;
    } else {
        return false;
    }
}
