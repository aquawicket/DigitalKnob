//////////////////////
function DKTray_Init()
{
	if(DK_GetOS() !== "Win32" && DK_GetOS() !== "Win64"){
		return;
	}
	if(DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML"){
		return;
	}
	DK_Create("DKTray");
	ById("DKTray").addEventListener("1000", DKTray_OnEvent);
	byId("DKTray").addEventListener("1001", DKTray_OnEvent);
	byId("DKTray").addEventListener("1002", DKTray_OnEvent);
	byId("DKTray").addEventListener("click", DKTray_OnEvent);
	byId("DKTray").addEventListener("doubleclick", DKTray_OnEvent);
	
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
	ById("DKTray").removeEventListener("1000", DKTray_OnEvent);
	byId("DKTray").removeEventListener("1001", DKTray_OnEvent);
	byId("DKTray").removeEventListener("1002", DKTray_OnEvent);
	byId("DKTray").removeEventListener("click", DKTray_OnEvent);
	byId("DKTray").removeEventListener("doubleclick", DKTray_OnEvent);
}

//////////////////////////////
function DKTray_OnEvent(event)
{
	if(event.type === "dblclick"){
		DKTray_ToggleWindow();
	}
	if(event.type === (event, "1000"){
		DK_ShowConsole();
		DK_Create("DKWindowJS");
		DKWindow_Show();
		DKWindow_Restore();
	}
	if(event.type === "1001"){
		DK_HideConsole();
		DK_Create("DKWindowJS");
		DKWindow_Hide();
	}
	if(event.type === "1002"){
		DK_Exit();
	}
}

//////////////////////////////
function DKTray_ToggleWindow()
{
	DK_Create("DKWindowJS");
	if(DKWindow_IsVisible()){
		DKWindow_Hide();
		DK_HideConsole();
	}
	else{
		DKWindow_Show();
		DKWindow_Restore();
	}
}