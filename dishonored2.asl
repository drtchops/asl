state("Dishonored2")
{
    // default unknown version
}

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
    float x : 0x26BD688, 0x1E8960, 0xE50, 0x540, 0x10, 0x40, 0x0, 0x3C;
    float y : 0x26BD688, 0x1E8960, 0xE50, 0x540, 0x10, 0x40, 0x0, 0x40;
    float z : 0x26BD688, 0x1E8960, 0xE50, 0x540, 0x10, 0x40, 0x0, 0x44;
    string64 pckFile : 0x31F34D0, 0x578, 0x0;
    float screenFade : 0x2518A50, 0xEEF38, 0x34;
}

state("Dishonored2", "1.4")
{
    // 1.76.0.18
    // 163115008
    bool isLoading : 0x26DF8E8; // 26DF8F4
    float x : 0x26DFC08, 0x1E8960, 0xE50, 0x540, 0x10, 0x40, 0x0, 0x3C;
    float y : 0x26DFC08, 0x1E8960, 0xE50, 0x540, 0x10, 0x40, 0x0, 0x40;
    float z : 0x26DFC08, 0x1E8960, 0xE50, 0x540, 0x10, 0x40, 0x0, 0x44;
    string64 pckFile : 0x3255AF0, 0x578, 0x0;
    float screenFade : 0x253B0D0, 0xEEF38, 0x34;
}
state("Dishonored2", "1.7")
{
    // 1.77.7.0
    // 119568896
    bool isLoading : 0x271D374;
    float x : 0x271D6C8, 0x1E8960, 0xE58, 0x540, 0x10, 0x40, 0x0, 0x3C;
    float y : 0x271D6C8, 0x1E8960, 0xE58, 0x540, 0x10, 0x40, 0x0, 0x40;
    float z : 0x271D6C8, 0x1E8960, 0xE58, 0x540, 0x10, 0x40, 0x0, 0x44;
    string64 pckFile : 0x329B6B0, 0x578, 0x0;
    float screenFade : 0x2552BD8, 0xEEF38, 0x34;
}

init
{
    switch (modules.First().ModuleMemorySize) {
        case 175591424: version = "1.7"; vars.autoStart = true;  break;
        case 163115008: version = "1.4"; vars.autoStart = true;  break;
        case 166068224: version = "1.3"; vars.autoStart = true;  break;
        case 155365376: version = "1.2"; vars.autoStart = false; break;
        case 158679040: version = "1.1"; vars.autoStart = false; break;
        default:        version = "1.0"; vars.autoStart = false; break;
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
    if (!vars.autoStart) {
        return true;
    }
    
    const float posX =  -28.09f,
                posY = -153.96f,
                posZ =   66.40f,
                delta =   0.005f;

    if (old.isLoading || current.isLoading) {
        vars.runStarting =
            current.pckFile.Equals("main-game1-dunwall_escape_tower_p-sfx.pck") &&
        //is inside starting area
            current.x>posX-delta && current.x<posX+delta &&
            current.y>posY-delta && current.y<posY+delta &&
            current.z>posZ-delta && current.z<posZ+delta;
    } else {
        vars.runStarting = false;
    }
}

reset
{
    if (!vars.autoStart) {
        return false;
    }

    return current.isLoading && vars.runStarting;
}

start
{
    if (!vars.autoStart) {
        return false;
    }

    return !current.isLoading && vars.runStarting;
}

split
{
    if (!vars.autoStart) {
        return true;
    }
    
    const float posX = -41.85f,
                posY =  23.18f,
                posZ =  61.00f,
                delta =  0.005f;
    
    return
        current.screenFade>0 &&
        current.pckFile.Equals("main-game2-dunwall_return_tower_p-sfx.pck") &&
    //was outside ending cutscene area
       (old.x <= posX-delta || old.x >= posX+delta ||
        old.y <= posY-delta || old.y >= posY+delta ||
        old.z <= posZ-delta || old.z >= posZ+delta) &&
    //is inside ending cutscene area
        current.x>posX-delta && current.x<posX+delta &&
        current.y>posY-delta && current.y<posY+delta &&
        current.z>posZ-delta && current.z<posZ+delta;
}
