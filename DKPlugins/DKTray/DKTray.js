//////////////////////
function DKTray_Init()
{
	DKCreate("DKTray");
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
	
	if(DK_Type(event, "Restore")){
		DKLog("DKTray_Restore \n", DKDEBUG);
		DKWindow_Restore();
	}
	if(DK_Type(event, "Minimize")){
		DKLog("DKTray_Minimize \n", DKDEBUG);
		DKWindow_Minimize();
	}
	if(DK_Type(event, "Exit")){
		DKLog("DKTray_Exit \n", DKDEBUG);
	}
}
