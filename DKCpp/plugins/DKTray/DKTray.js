<<<<<<< HEAD:DKPlugins/DKTray/DKTray.js
function DKTray_init() {
=======
function DKTray_init(){
>>>>>>> Development:DKCpp/plugins/DKTray/DKTray.js
	if(DK_GetOS() !== "Win32" && DK_GetOS() !== "Win64")
		return;
	if(DK_GetBrowser() !== "Cef" && DK_GetBrowser() !== "Rml")
		return;
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

<<<<<<< HEAD:DKPlugins/DKTray/DKTray.js
function DKTray_end() {
=======
function DKTray_end(){
>>>>>>> Development:DKCpp/plugins/DKTray/DKTray.js
	ById("DKTray").removeEventListener("1000", DKTray_onevent);
	byId("DKTray").removeEventListener("1001", DKTray_onevent);
	byId("DKTray").removeEventListener("1002", DKTray_onevent);
	byId("DKTray").removeEventListener("click", DKTray_onevent);
	byId("DKTray").removeEventListener("doubleclick", DKTray_onevent);
}

<<<<<<< HEAD:DKPlugins/DKTray/DKTray.js
function DKTray_OnEvent(event) {
=======
function DKTray_OnEvent(event){
>>>>>>> Development:DKCpp/plugins/DKTray/DKTray.js
	if(event.type === "dblclick")
		DKTray_ToggleWindow();
	if(event.type === "1000"){
		DK_ShowConsole();
		dk.create("DKWindowJS");
		CPP_DKWindow_Show();
		CPP_DKWindow_Restore();
	}
	if(event.type === "1001"){
		DK_HideConsole();
		dk.create("DKWindowJS");
		CPP_DKWindow_Hide();
	}
	if(event.type === "1002")
		DK_Exit();
}

<<<<<<< HEAD:DKPlugins/DKTray/DKTray.js
function DKTray_ToggleWindow() {
=======
function DKTray_ToggleWindow(){
>>>>>>> Development:DKCpp/plugins/DKTray/DKTray.js
	dk.create("DKWindowJS");
	if(CPP_DKWindow_IsVisible()){
		CPP_DKWindow_Hide();
		DK_HideConsole();
	}
	else{
		CPP_DKWindow_Show();
		CPP_DKWindow_Restore();
	}
}