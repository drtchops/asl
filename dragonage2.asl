state("DragonAge2")
{
    bool isLoading : 0x95869C, 0x1D0;
}

isLoading
{
    return current.isLoading;
}
