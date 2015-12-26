state("bio4")
{
	int isEndOfChapter : 0x864311;
	uint igt : 0x85BE84;
	uint finalIGT : 0xE7A9BC;
}

start
{
	return current.igt > old.igt;
}

reset
{
	return current.igt == 0;
}

isLoading
{
	return false;
}

gameTime
{
	if (current.igt != old.igt || current.igt == current.finalIGT)
	{
		return TimeSpan.FromSeconds(current.igt);
	}
}

split
{
	return (current.isEndOfChapter - old.isEndOfChapter == 1) || (current.igt == current.finalIGT && old.finalIGT != current.finalIGT);
}
