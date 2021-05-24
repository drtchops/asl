// Yakuza 0 (PC, Steam) autosplitter & load remover
// Autosplitter by ToxicTT (Discord: ToxicTT#4487)
// Load remover by DrTChops
// v1.0 (2021-05-24)

state("Yakuza0")
{
    bool isLoading : 0x132C520, 0xA38, 0x38, 0x4A0, 0x4A0, 0x4A0, 0x1EDC;
    string15 result : 0x01305FC8, 0x50, 0x6E2;
}

isLoading
{
    return current.isLoading;
}

split
{
    if (current.result == "pjcm_result.sbb" && old.result != "pjcm_result.sbb") 
    {
        return true;
    }
}
