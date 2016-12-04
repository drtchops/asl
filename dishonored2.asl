state("Dishonored2", "1.0")
{
    // 1.74.0
    // 153489408
    bool isLoading : 0x26AD288;
}

state("Dishonored2", "1.1")
{
    // 1.74.0
    // 158679040
    bool isLoading : 0x26AD188; // 26AD194
}

state("Dishonored2", "1.2")
{
    // 1.75.0.7
    // 155365376
    bool isLoading : 0x26B4234; // 26B4228
}

state("Dishonored2", "1.3")
{
    // 1.75.0.12
    // 166068224
    bool isLoading : 0x26BD368; // 26BD374
    float x : 0x2566CA8, 0x1E8960, 0xE50, 0x540, 0x10, 0x40, 0x0, 0x3C;
    float y : 0x2566CA8, 0x1E8960, 0xE50, 0x540, 0x10, 0x40, 0x0, 0x40;
    float z : 0x2566CA8, 0x1E8960, 0xE50, 0x540, 0x10, 0x40, 0x0, 0x44;
    string64 pckFile : 0x31F34D0, 0x578, 0x0;
}

init
{
    switch (modules.First().ModuleMemorySize) {
        case 166068224: version = "1.3"; break;
        case 155365376: version = "1.2"; break;
        case 158679040: version = "1.1"; break;
        default:        version = "1.0"; break;
    }
    // print(modules.First().FileVersionInfo.FileVersion);
    // print(modules.First().ModuleMemorySize.ToString());
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isLoading;
}

update
{
    if (string.Compare("1.3",version)<0) {
        return true;
    }

    if (old.isLoading || current.isLoading) {
        vars.runStarting =
            current.pckFile.Equals("main-game1-dunwall_escape_tower_p-sfx.pck") &&
            current.x> -28.10 && current.x< -28.09 &&
            current.y>-153.97 && current.y<-153.96 &&
            current.z>  66.40 && current.z<  66.41;
    } else {
        vars.runStarting = false;
    }
}

reset
{
    if (string.Compare("1.3",version)<0) {
        return false;
    }

    return current.isLoading && vars.runStarting;
}

start
{
    if (string.Compare("1.3",version)<0) {
        return false;
    }

    return !current.isLoading && vars.runStarting;
}
