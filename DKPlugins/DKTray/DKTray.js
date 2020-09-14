//////////////////////
function DKTray_Init()
{
	DKDEBUGFUNC();	
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
	DKDEBUGFUNC();	
	DKRemoveEvents(DKTray_OnEvent);
}

//////////////////////////////
function DKTray_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(event.type == "doubleclick"){
		DKTray_ToggleWindow();
	}
	if(event.type == (event, "1000"){
		DK_ShowConsole();
		DKCreate("DKWindowJS");
		DKWindow_Show();
		DKWindow_Restore();
	}
	if(event.type == "1001"){
		DK_HideConsole();
		DKCreate("DKWindowJS");
		DKWindow_Hide();
	}
	if(event.type == "1002"){
		DK_Exit();
	}
}

//////////////////////////////
function DKTray_ToggleWindow()
{
	DKDEBUGFUNC();
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