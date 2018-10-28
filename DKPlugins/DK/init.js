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
	DKINFO("Init_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "resize")){ //NOTE: this is for SDL, OSG, ROCKET or any other created windows.
		DK_CallFunc("DKSDLCef::OnResize", "SdlWindow,0,0,"+String(DKWindow_GetWidth())+","+String(DKWindow_GetHeight()));
	}
	if(DK_Type(event, "keydown") && DK_GetValue(event) == "4"){ //NOTE: this is the back button on Android
		DK_Exit();
	}
}

////////////////////////////////////
if(DK_GetJavascript() == "Duktape"){ //C++: Create a window LoadPage() can support
	if(USE_ROCKET && USE_CEF){
		DKINFO("Creating SDL -> Rocket -> Cef -> GUI\n");
		DKCreate("DKWindow");
		DKWindow_Create();
		DKCreate("DKRocket");
		DKRocket_LoadUrl("DKRocket/blank.html");
		DKCreate("DKWidget");
		var iframe = DKWidget_CreateElement("body", "iframe", "DKCef_frame");
		DKWidget_SetProperty(iframe, "position", "absolute");
		DKWidget_SetProperty(iframe, "top", "0rem");
		DKWidget_SetProperty(iframe, "left", "0rem");
		DKWidget_SetProperty(iframe, "width", "100%");
		DKWidget_SetProperty(iframe, "height", "100%");
		//DKWidget_SetProperty(iframe, "right", "0rem");
		//DKWidget_SetProperty(iframe, "bottom", "0rem");
		DKWidget_SetAttribute(iframe, "src", DKApp_url);
		DKCef_SetFocus(DKCef_GetCurrentBrowser());
	}
	else if(USE_ROCKET){
		DKINFO("Creating SDL -> ROCKET -> GUI\n");
		DKCreate("DKWindow");
		DKWindow_Create();
		DKCreate("DKRocket");
		DKRocket_LoadUrl("index.html");
		//DKCreate("DKWidget");
		//if(typeof app_LoadPage === "function"){
		//	app_LoadPage();
		//}
	}
	else if(USE_SDL && USE_CEF){
		DKINFO("Creating SDL -> CEF -> GUI\n");
		DKCreate("DKWindow");
		DKWindow_Create();
		var width = DKWindow_GetWidth();
		var height = DKWindow_GetHeight();
		DKCreate("DKCef");
		DKCef_NewBrowser("SdlWindow", 0, 0, width, height, DKApp_url);
		DKCef_SetFocus(0);
		DKAddEvent("GLOBAL", "resize", init_OnEvent);
		DK_CallFunc("DKSDLCef::OnResize", "SdlWindow,0,0,"+String(DKWindow_GetWidth())+","+String(DKWindow_GetHeight()));
	}
	else if(USE_CEF){
		DKINFO("Creating CEF -> GUI\n");
		var assets = DKAssets_LocalAssets();
		var width = Number(DKFile_GetSetting(assets+"settings.txt", "[WIDTH]"));
		var height = Number(DKFile_GetSetting(assets+"settings.txt", "[HEIGHT]"));
		DKCreate("DKCef");
		DKCef_NewBrowser("CefWindow", 0, 0, width, height, DKApp_url);
		DKCef_SetFocus(DKCef_GetCurrentBrowser());
		DKCreate("DKWindow");
	}
	else if(USE_WEBVIEW){ //TODO
		DKINFO("Creating WEBVIEW -> GUI\n");
		DKAddEvent("GLOBAL", "keydown", init_OnEvent);
	}
	
	if(typeof app_LoadPlugins === "function"){
		app_LoadPlugins();
	}
}