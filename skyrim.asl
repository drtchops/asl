state("TESV")
{
    bool isLoading : "TESV.exe", 0x17337CC;
    bool isLoadingScreen : "TESV.exe", 0xEE3561;
}

isLoading
{
    return current.isLoading || current.isLoadingScreen;
}
