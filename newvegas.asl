state("Fallout NV")
{
    byte isLoading : "FalloutNV.exe", 0xDDCFB1;
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
    return current.isLoading != 0;
}
