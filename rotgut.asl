state("Main")
{
    int level : "Adobe AIR.dll", 0x135BDF8, 0, 0x510, 0x190, 0x8, 0x25c;
}

split
{
    return current.level > old.level;
}
