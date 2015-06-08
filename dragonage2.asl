state("DragonAge2")
{
    bool isLoading : "DragonAge2.exe", 0x95869C, 0x1D0;
}

start
{
}

reset
{
}

split
{
}

isLoading
{
    return current.isLoading;
}
