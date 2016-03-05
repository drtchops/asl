state("Morrowind")
{
    string50 cell : 0x3AEA88, 0xB540, 0x10, 0;
    string50 region : 0x3AEA88, 0xB540, 0x8C, 0x30;
    // float playerX : 0x3AEA88, 0, 0xAC40, 0x38;
    // float playerY : 0x3AEA88, 0, 0xAC40, 0x3C;
    // float playerZ : 0x3AEA88, 0, 0xAC40, 0x40;
    bool playerControlsDisabled : 0x3AEA84, 0x5C, 0x24, 0, 0x5A0;
    bool loadingScreenVisible : 0x3BBCE0;
    // float gameTime : 0x3AE9B0;
}

exit
{
    timer.IsGameTimePaused = true;
}

update
{
    current.cell = current.cell != null && current.cell.Length > 0 && current.region != null && current.region.Length > 0
        ? String.Join(" - ", current.cell, current.region)
        : (current.cell != null && current.cell.Length > 0 ? current.cell : current.region);

    // if (old.cell != current.cell)
    //     print(String.Format("[NoLoads] cell changed from '{0}' to '{1}'", old.cell, current.cell));
    // if (old.playerControlsDisabled != current.playerControlsDisabled)
    //     print(String.Format("[NoLoads] playerControlsDisabled changed from '{0}' to '{1}'", old.playerControlsDisabled, current.playerControlsDisabled));
    // if (old.loadingScreenVisible != current.loadingScreenVisible)
    //     print(String.Format("[NoLoads] loadingScreenVisible changed from '{0}' to '{1}'", old.loadingScreenVisible, current.loadingScreenVisible));
    // if (old.playerX != current.playerX || old.playerY != current.playerY || old.playerZ != current.playerZ)
    //     print(String.Format("[NoLoads] x,y,z changed from {0},{1},{2} to {3},{4},{5}", old.playerX, old.playerY, old.playerZ, current.playerX, current.playerY, current.playerZ));
}

start
{
    return (
        old.playerControlsDisabled &&
        !current.playerControlsDisabled &&
        !current.loadingScreenVisible &&
        current.cell == "Imperial Prison Ship"
    );
}

split
{
    return (
        !old.playerControlsDisabled &&
        current.playerControlsDisabled &&
        current.cell == "Dagoth Ur, Facility Cavern"
    );
}

reset
{
    return (
        old.loadingScreenVisible &&
        !current.loadingScreenVisible &&
        current.cell == "Imperial Prison Ship"
    );
}

isLoading
{
    return current.loadingScreenVisible;
}
