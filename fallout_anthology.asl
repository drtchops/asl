state("falloutw")
{
    // Fallout 1 (no vars)
}

state("FALLOUT2")
{
    // Fallout 2 (no vars)
}

state("Fallout3")
{
    // Fallout 3
    bool isLoading : 0xC76CE8;
}

state("FalloutNV")
{
    // Fallout: New Vegas
    bool isLoading : 0xDDA4EC;
}

state("Fallout4", "v1.1.30")
{
    // Fallout 4 v1.1
    bool isLoadingScreen : 0x6FB1524;
    bool isQuickloading : 0x44BB958;
    bool isCellTransitionLoad : 0x6CC83C8;
    byte isWaiting : 0x704329B;
}

init
{
    if (game.ProcessName == "Fallout4") {
        if (modules.First().ModuleMemorySize == 132587520) {
            version = "v1.1.30";
        }

        if (string.IsNullOrEmpty(version)) {
            var decision = System.Windows.Forms.MessageBox.Show(
                timer.Form,
                "Incompatible game version. (ModuleMemorySize: " +
                modules.First().ModuleMemorySize.ToString() +
                ")\n\n" +
                "This load remover is compatible only with v1.1.30.\n" +
                "Visit speedrun.com/Fallout_4/forum to get this version.\n\n" +
                "Do you want to open the link?",
                "Fallout 4 Load Remover",
                System.Windows.Forms.MessageBoxButtons.YesNo,
                System.Windows.Forms.MessageBoxIcon.Error
            );

            if (decision == System.Windows.Forms.DialogResult.Yes) {
                System.Diagnostics.Process.Start("http://www.speedrun.com/Fallout_4/thread/fvo80");
            }
        }
    }

    timer.IsGameTimePaused = false;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    if (timer.CurrentSplit.Name.ToLower().Contains("setup")) {
        return true;
    } else if (game.ProcessName == "Fallout3" || game.ProcessName == "FalloutNV") {
        return current.isLoading;
    } else if (game.ProcessName == "Fallout4") {
        return (
            current.isLoadingScreen ||
            current.isQuickloading ||
            current.isCellTransitionLoad ||
            current.isWaiting == 68
        );
    } else {
        return false;
    }
}
