state("TESV")
{
    bool isLoading : 0x17337CC;
    bool isLoadingScreen : 0xEE3561;
}

isLoading
{
    return current.isLoading || current.isLoadingScreen;
}
