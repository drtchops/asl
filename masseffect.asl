state("MassEffect")
{
    bool isLoading : "MassEffect.exe", 0x1263BDC;
}

isLoading
{
    return current.isLoading;
}
