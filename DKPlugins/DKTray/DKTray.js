//////////////////////
function DKTray_Init()
{
	DKCreate("DKTray");
	DKCreate("DKTrayJS");
	DKCreate("DKFileJS");
	DKCreate("DKAssetsJS");
	DKAddEvent("DKTray", "click", DKTray_OnEvent);
	DKAddEvent("DKTray", "Restore", DKTray_OnEvent);
	DKAddEvent("DKTray", "Minimize", DKTray_OnEvent);
	DKAddEvent("DKTray", "Exit", DKTray_OnEvent);
	
	//var datapath = DKAssets_GetDataPath();
	//DKTray_SetIcon(datapath+"icon.ico");
}

//////////////////////////////
function DKTray_OnEvent(event)
{
	DKLog("DKTray_OnEvent("+event+") \n");
	if(DK_Type(event, "click")){
		DKTray_ToggleIcon();
	}
}

////////////////////////////
function DKTray_ToggleIcon()
{
	DKLog("DKTray_ToggleIcon() \n", DKDEBUG);
	var icon = DKTray_GetIcon();
	var file = DKFile_GetFilename(icon);
	DKLog(file+"\n");
	
}