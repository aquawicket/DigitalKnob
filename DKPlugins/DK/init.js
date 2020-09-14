//Validate settings
if(DK_GetOS() == "Android" || DK_GetOS() == "iOS"){
	USE_CEF = 0;
	USE_SDL = 1;
	USE_ROCKET = 1;
	USE_WEBVIEW = 0; //TODO
}
else{ USE_WEBVIEW = 0; }

//////////////////////
function init_Init(){}

/////////////////////
function init_End(){}

////////////////////////////
function init_OnEvent(event)  //Duktape
{
	console.log("Init_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(event.type == "resize"){ //NOTE: this is for SDL, OSG, ROCKET or any other created windows.
		DK_CallFunc("DKSDLCef::OnResize", "SdlWindow,0,0,"+String(DKWindow_GetWidth())+","+String(DKWindow_GetHeight()));
	}
	if(event.type == "keydown" && DK_GetValue(event) == "4"){ //NOTE: this is the back button on Android
		DK_Exit();
	}
}

//////////////////////////////////
if(DK_GetJSEngine() == "Duktape"){ //C++: Create a window LoadPage() can support
	if(USE_ROCKET && USE_CEF){
		console.log("Creating SDL -> Rocket -> Cef -> GUI\n");
		DKCreate("DKWindow");
		DKWindow_Create();
		DKCreate("DKRocket");
		DKRocket_LoadUrl("DKRocket/blank.html");
		DKCreate("DKWidget");
		var iframe = DKWidget_CreateElement("body", "iframe", "DKCef_frame");
		document.getElementById(iframe).style.position = "absolute";
		document.getElementById(iframe).style.top = "0rem";
		document.getElementById(iframe).style.left = "0rem";
		document.getElementById(iframe).style.width = "100%";
		document.getElementById(iframe).style.height = "100%";
		//document.getElementById(iframe).style.right = "0rem";
		//document.getElementById(iframe).style.bottom = "0rem";
		DKWidget_SetAttribute(iframe, "src", DKApp_url);
		DKCef_SetFocus(DKCef_GetCurrentBrowser());
	}
	else if(USE_ROCKET){
		console.log("Creating SDL -> ROCKET -> GUI\n");
		DKCreate("DKWindow");
		DKWindow_Create();
		DKCreate("DKRocket");
		DKRocket_LoadUrl("index.html");
	}
	else if(USE_SDL && USE_CEF){
		console.log("Creating SDL -> CEF -> GUI\n");
		DKCreate("DKWindow");
		DKWindow_Create();
		var width = DKWindow_GetWidth();
		var height = DKWindow_GetHeight();
		DKCreate("DKCef");
		DKCef_NewBrowser("SdlWindow", 0, 0, width, height, DKApp_url);
		DKCef_SetFocus(0);
		DKAddEvent("window", "resize", init_OnEvent);
		DK_CallFunc("DKSDLCef::OnResize", "SdlWindow,0,0,"+String(DKWindow_GetWidth())+","+String(DKWindow_GetHeight()));
	}
	else if(USE_CEF){
		console.log("Creating CEF -> GUI\n");
		var assets = DKAssets_LocalAssets();
		var width = Number(DKFile_GetSetting(assets+"settings.txt", "[WIDTH]"));
		var height = Number(DKFile_GetSetting(assets+"settings.txt", "[HEIGHT]"));
		DKCreate("DKCef");
		DKCef_NewBrowser("CefWindow", 0, 0, width, height, DKApp_url);
		DKCef_SetFocus(DKCef_GetCurrentBrowser());
		DKCreate("DKWindow");
	}
	else if(USE_WEBVIEW){ //TODO
		console.log("Creating WEBVIEW -> GUI\n");
		DKAddEvent("window", "keydown", init_OnEvent);
	}
	
	if(typeof app_LoadPlugins === "function"){
		app_LoadPlugins();
	}
}