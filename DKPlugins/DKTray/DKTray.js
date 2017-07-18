//////////////////////
function DKTray_Init()
{
	//DKLog("DKTray_Init()\n");
	
	if(DK_GetOS() != "Win32" && DK_GetOS() != "Win64"){
		return;
	}
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

/////////////////////
function DKTray_End()
{
	//DKLog("DKTray_End()\n");
	
	DKRemoveEvents(DKTray_OnEvent);
}

//////////////////////////////
function DKTray_OnEvent(event)
{
	//DKLog("DKTray_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
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
	//DKLog("DKTray_ToggleWindow()\n");
	
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