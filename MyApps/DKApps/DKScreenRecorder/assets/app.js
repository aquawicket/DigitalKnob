var USE_CEF     = 0; //Desktop
var USE_WEBVIEW = 0; //TODO: Android, iOS
var USE_SDL     = 0; //Use with caution
var USE_ROCKET  = 0; //Use with caution
var DKApp_url   = "file:///"+DKAssets_LocalAssets()+"index.html";

DKCreate("DK/init.js", function(){});

///////////////////////////
function app_OnEvent(event)
{
	DKLog("app_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "1003")){ //Tray, Fullscreen
		DKLog("Clicked Tray -> Record\n", DKINFO);
		//TODO: Record the screen to a file. 
	}
}

//////////////////////////
function app_LoadPlugins()
{
	DKCreate("DKScreenRecorder");
	DKCreate("DKTray/DKTray.js", function(){
		DKTray_AddItem("Record", 1003);
		DKAddEvent("DKTray", "1003", app_OnEvent);
	});
}

///////////////////////
function app_LoadPage()
{
	DKLog("app_LoadPage()\n");
	
	//TODO
}