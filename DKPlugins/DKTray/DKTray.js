//////////////////////
function DKTray_Init()
{
	if(DK_GetBrowser() != "CEF" && DK_GetBrowser() != "Rocket"){
		return;
	}
	DKCreate("DKTray");
	DKAddEvent("DKTray", "1000", DKTray_OnEvent);
	DKAddEvent("DKTray", "1001", DKTray_OnEvent);
	DKAddEvent("DKTray", "1002", DKTray_OnEvent);
	DKAddEvent("DKTray", "click", DKTray_OnEvent);
	DKAddEvent("DKTray", "doubleclick", DKTray_OnEvent);
	
	DKTray_AddItem("Exit", 1002);
	DKTray_AddItem("Minimize", 1001);
	DKTray_AddItem("Restore", 1000);
	
	var app = DKFile_GetExeName();
	app = app.replace(".exe","");
	DKTray_SetTooltip(app);
	DKTray_ShowBalloon(app);
}

//////////////////////////////
function DKTray_OnEvent(event)
{
	DKLog("DKTray_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Type(event, "doubleclick")){
		DKTray_ToggleWindow();
	}
	if(DK_Type(event, "1000")){
		DKCreate("DKWindowJS");
		DKWindow_Show();
		DKWindow_Restore();
	}
	if(DK_Type(event, "1001")){
		DKCreate("DKWindowJS");
		DKWindow_Hide();
		DK_HideConsole();
	}
	if(DK_Type(event, "1002")){
		DK_Exit();
	}
}

//////////////////////////////
function DKTray_ToggleWindow()
{
	DKCreate("DKWindowJS");
	if(DKWindow_IsVisible()){
		DKWindow_Hide();
		DK_HideConsole();
	}
	else{
		DKWindow_Show();
		DKWindow_Restore();
	}
}
