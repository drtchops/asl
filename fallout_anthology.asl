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

state("Fallout4")
{
    // Fallout 4 v1.1
    bool isLoadingScreen : 0x6FB1524;
    bool isQuickloading : 0x44BB958;
    bool isCellTransitionLoad : 0x6CC83C8;
    byte isWaiting : 0x704329B;
}

state("Fallout4", "v1.2.33")
{
    // Fallout 4 v1.2
    bool isLoadingScreen : 0x6FB2524;
    bool isQuickloading : 0x44BC958;
    bool isCellTransitionLoad : 0x6CC93D8;
    byte isWaiting : 0x704429B;
}

init
{
    if (game.ProcessName == "Fallout4") {
        switch (modules.First().ModuleMemorySize) {
            case 132591616:
                version = "v1.2.33";
                break;
        }
    }

    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = true;
}

isLoading
{
    if (timer.CurrentSplit.Name.ToLower().Contains("setup")) {
        return true;
    } else if (game.ProcessName == "Fallout3" || game.ProcessName == "FalloutNV") {
        return current.isLoading;
    } else if (game.ProcessName == "Fallout4") {
        return (
            current.isLoadingScreen ||
            current.isQuickloading ||
            current.isCellTransitionLoad ||
            current.isWaiting == 68
        );
    } else {
        return false;
    }
}
