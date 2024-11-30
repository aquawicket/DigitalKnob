using IWshRuntimeLibrary;


public static class APP {

//############################################################################
//# dk_info(message)
//#
public static void CreateShortcut(){	
  object shDesktop = (object)"Desktop";
  WshShell shell = new WshShell();
  string shortcutAddress = (string)shell.SpecialFolders.Item(ref shDesktop) + @"\Notepad.lnk";
  IWshShortcut shortcut = (IWshShortcut)shell.CreateShortcut(shortcutAddress);
  shortcut.Description = "New shortcut for a Notepad";
  shortcut.Hotkey = "Ctrl+Shift+N";
  shortcut.TargetPath = Environment.GetFolderPath(Environment.SpecialFolder.System) + @"\notepad.exe";
  shortcut.Save();
}


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
public static void DKTEST(){
	CreateShortcut();
}

}