state("FalloutNV")
{
    bool isLoading : "FalloutNV.exe", 0xDDA4EC;
}

isLoading
{
    return current.isLoading;
}
