state("FalloutNV")
{
    byte isLoading : "FalloutNV.exe", 0xDDA4EC;
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
