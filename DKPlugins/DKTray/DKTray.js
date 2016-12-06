//////////////////////
function DKTray_Init()
{
	DKCreate("DKTray");
	DKAddEvent("DKTray", "1000", DKTray_OnEvent);
	DKAddEvent("DKTray", "1001", DKTray_OnEvent);
	DKAddEvent("DKTray", "1002", DKTray_OnEvent);
	DKAddEvent("DKTray", "click", DKTray_OnEvent);
	DKAddEvent("DKTray", "doubleclick", DKTray_OnEvent);
	
	DKTray_AddItem("Exit", 1002);
	DKTray_AddItem("Minimize", 1001);
	DKTray_AddItem("Restore", 1000);
	
	DKTray_SetTooltip("DKReceiver");
}

//////////////////////////////
function DKTray_OnEvent(event)
{
	//DKLog("DKTray_OnEvent("+event+") \n");
	if(DK_Type(event, "1000") || DK_Type(event, "doubleclick")){
		DKCreate("DKWindowJS");
		DKWindow_Show();
	}
	if(DK_Type(event, "1001")){
		DKCreate("DKWindowJS");
		DKWindow_Hide();
	}
	if(DK_Type(event, "1002")){
		DK_Exit();
	}
}
