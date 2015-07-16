state("Fallout3")
{
    bool isLoading : "Fallout3.exe", 0xC76CE8;
}

isLoading
{
    return current.isLoading;
}
