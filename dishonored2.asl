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
    string128 levelName : 0x3E04E50;
    float screenFade : 0x2518A50, 0xEEF38, 0x34;
    uint interaction : 0x2566CA8, 0x1F6EB0, 0x88, 0x80, 0x4;
    uint canInteract : 0x2566CA8, 0x1F6EB0, 0xE90, 0x0;
}

state("Dishonored2", "1.4")
{
    // 1.76.0.18
    // 163115008
    bool isLoading : 0x26DF8E8; // 26DF8F4
    float x : 0x26DFC08, 0x1E8960, 0xE50, 0x540, 0x10, 0x40, 0x0, 0x3C;
    float y : 0x26DFC08, 0x1E8960, 0xE50, 0x540, 0x10, 0x40, 0x0, 0x40;
    float z : 0x26DFC08, 0x1E8960, 0xE50, 0x540, 0x10, 0x40, 0x0, 0x44;
    string128 levelName : 0x3E69FF0;
    float screenFade : 0x253B0D0, 0xEEF38, 0x34;
    uint interaction : 0x2589328, 0x1F6EC0, 0x88, 0x80, 0x4;
    uint canInteract : 0x2589328, 0x1F6EC0, 0xE90, 0x0;
}

state("Dishonored2", "1.7")
{
    // 1.77.7.0
    // 119568896
    bool isLoading : 0x271D3A8;
    float x : 0x271D6C8, 0x1E8960, 0xE58, 0x540, 0x10, 0x40, 0x0, 0x3C;
    float y : 0x271D6C8, 0x1E8960, 0xE58, 0x540, 0x10, 0x40, 0x0, 0x40;
    float z : 0x271D6C8, 0x1E8960, 0xE58, 0x540, 0x10, 0x40, 0x0, 0x44;
    string128 levelName : 0x3EB22F0;
    float screenFade : 0x2552BD8, 0xEEF38, 0x34;
    uint interaction : 0x25A0E28, 0x1F6EE8, 0x88, 0x80, 0x4;
    uint canInteract : 0x25A0E28, 0x1F6EE8, 0xE90, 0x0;
}

startup {
    //"campaign/bunker/bunker_p_lowchaos" is used before killing/darting stilton regardless of chaos
    //"campaign/bunker/bunker_p_highchaos" is used after regardless of chaos
    vars.autoSplits = new Tuple<string,string,bool>[]{
        Tuple.Create("A Strange Visit"       ,"campaign/void/void_01/void_01_p"                   ,true ),
        Tuple.Create("Edge of the World"     ,"campaign/boat/edge_of_the_world/boat_eotw_p"       ,false),
        Tuple.Create("The Good Doctor"       ,"campaign/institute/institute_p_"                   ,true ),
        Tuple.Create("The Lockwork Mansion"  ,"campaign/boat/madinventor/boat_madinventor_p"      ,true ),
        Tuple.Create("Another Strange Visit" ,"campaign/void/void_02/void_02_p"                   ,true ),
        Tuple.Create("The Royal Conservatory","campaign/boat/curator/boat_curator_p"              ,false),
        Tuple.Create("Dust District"         ,"campaign/boat/dust/boat_dust_p"                    ,true ),
        Tuple.Create("A Crack in the Slab"   ,"campaign/bunker/bunker_p_lowchaos"                 ,true ),
        Tuple.Create("The Grand Palace"      ,"campaign/boat/duke_palace/boat_palace_p"           ,true ),
        Tuple.Create("Death to the Empress"  ,"campaign/boat/dunwall_return/boat_dunwall_return_p",true ),
    };

    int i = 0;
    foreach (var autoSplit in vars.autoSplits) {
        settings.Add("autosplit_"+i.ToString(),autoSplit.Item3,"Split on \""+autoSplit.Item1+"\" start");

        ++i;
    }

    settings.Add("autosplit_end",false,"Split on run end");

    vars.autoSplitIndex = -1;
}

init
{
    switch (modules.First().ModuleMemorySize) {
        case 175591424: version = "1.7"; vars.canAutoSplit = true;  break;
        case 163115008: version = "1.4"; vars.canAutoSplit = true;  break;
        case 166068224: version = "1.3"; vars.canAutoSplit = true;  break;
        case 155365376: version = "1.2"; vars.canAutoSplit = false; break;
        case 158679040: version = "1.1"; vars.canAutoSplit = false; break;
        default:        version = "1.0"; vars.canAutoSplit = false; break;
    }
    // print(modules.First().FileVersionInfo.FileVersion);
    // print(modules.First().ModuleMemorySize.ToString());

    if (vars.autoSplitIndex == -1) {
        for (vars.autoSplitIndex = 0;vars.autoSplitIndex < vars.autoSplits.Length;++vars.autoSplitIndex) {
            if (settings["autosplit_"+vars.autoSplitIndex.ToString()]) {
                break;
            }
        }
    }
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
    if (!vars.canAutoSplit) {
        return true;
    }

    const float posX =  -28.09f,
                posY = -153.96f,
                posZ =   66.40f,
                delta =   0.005f;

    if (old.isLoading || current.isLoading) {
        vars.runStarting =
            current.levelName.Equals("campaign/dunwall/escape/tower/dunwall_escape_tower_p") &&
        //is inside starting area
            current.x>posX-delta && current.x < posX+delta &&
            current.y>posY-delta && current.y < posY+delta &&
            current.z>posZ-delta && current.z < posZ+delta;

        if(vars.runStarting){
            for (vars.autoSplitIndex = 0;vars.autoSplitIndex < vars.autoSplits.Length;++vars.autoSplitIndex) {
                if (settings["autosplit_"+vars.autoSplitIndex.ToString()]) {
                    break;
                }
            }
        }
    } else {
        vars.runStarting = false;
    }
}

reset
{
    if (!vars.canAutoSplit) {
        return false;
    }

    return current.isLoading && vars.runStarting;
}

start
{
    if (!vars.canAutoSplit) {
        return false;
    }

    return !current.isLoading && vars.runStarting;
}

split
{
    if (!vars.canAutoSplit) {
        return true;
    }

    if (vars.autoSplitIndex < vars.autoSplits.Length) {
        if (current.isLoading && current.levelName.StartsWith(vars.autoSplits[vars.autoSplitIndex].Item2)) {
            for (++vars.autoSplitIndex;vars.autoSplitIndex < vars.autoSplits.Length;++vars.autoSplitIndex) {
                if (settings["autosplit_"+vars.autoSplitIndex.ToString()]) {
                    break;
                }
            }

            return true;
        }
    } else if(vars.autoSplitIndex == vars.autoSplits.Length && settings["autosplit_end"]) {
        bool isFadingOut = (current.screenFade > old.screenFade && current.screenFade < 1.0f);
        
        //for some reason 0x4B indicates that we can interact with something
        bool canInteract = (current.canInteract == 0x4B);
        
        //0x9C673C93 is the id (possibly a hash) for "Revive your father", 0xA2674605 is for "Revive your daughter"
        bool isFinalInteraction = (current.interaction == 0x9C673C93 || current.interaction == 0xA2674605);
        
        if(isFadingOut && canInteract && isFinalInteraction) {
            ++vars.autoSplitIndex;
            return true;
        }
    }

    return false;
}
