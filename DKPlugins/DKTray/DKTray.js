//////////////////////
function DKTray_init()
{
	if(DK_GetOS() !== "Win32" && DK_GetOS() !== "Win64"){
		return;
	}
	if(DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML"){
		return;
	}
	dk.create("DKTray");
	ById("DKTray").addEventListener("1000", DKTray_onevent);
	byId("DKTray").addEventListener("1001", DKTray_onevent);
	byId("DKTray").addEventListener("1002", DKTray_onevent);
	byId("DKTray").addEventListener("click", DKTray_onevent);
	byId("DKTray").addEventListener("doubleclick", DKTray_onevent);
	
	DKTray_AddItem("Exit", 1002);
	DKTray_AddItem("Minimize", 1001);
	DKTray_AddItem("Restore", 1000);
	
	var app = DKFile_GetExeName();
	app = app.replace(".exe","");
	DKTray_SetTooltip(app);
	DKTray_ShowBalloon(app);
}

/////////////////////
function DKTray_end()
{
	ById("DKTray").removeEventListener("1000", DKTray_onevent);
	byId("DKTray").removeEventListener("1001", DKTray_onevent);
	byId("DKTray").removeEventListener("1002", DKTray_onevent);
	byId("DKTray").removeEventListener("click", DKTray_onevent);
	byId("DKTray").removeEventListener("doubleclick", DKTray_onevent);
}

//////////////////////////////
function DKTray_OnEvent(event)
{
	if(event.type === "dblclick"){
		DKTray_ToggleWindow();
	}
	if(event.type === (event, "1000"){
		DK_ShowConsole();
		dk.create("DKWindowJS");
		DKWindow_Show();
		DKWindow_Restore();
	}
	if(event.type === "1001"){
		DK_HideConsole();
		dk.create("DKWindowJS");
		DKWindow_Hide();
	}
	if(event.type === "1002"){
		DK_Exit();
	}
}

//////////////////////////////
function DKTray_ToggleWindow()
{
	dk.create("DKWindowJS");
	if(DKWindow_IsVisible()){
		DKWindow_Hide();
		DK_HideConsole();
	}
	else{
		DKWindow_Show();
		DKWindow_Restore();
	}
}