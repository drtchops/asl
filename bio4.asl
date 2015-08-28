state("bio4")
{
	int startGame : "bio4.exe", 0x0e3b760;
	int isEndOfChapter : "bio4.exe", 0x0864311;
	int finalCutscene : "bio4.exe", 0x12FB2E6;
	byte isPaused : "bio4.exe", 0x856F01;
	byte reset : "bio4.exe", 0x856DF2;
}

start
{
	return (current.startGame == 1 && old.startGame == 0);
}

reset
{
	return old.reset != 1 && current.reset == 1;
}

split
{
	return ((current.isEndOfChapter - old.isEndOfChapter) == 1) || (old.finalCutscene == 1 && current.finalCutscene == 0);
}

isLoading
{
	return current.isPaused == 1;
}
