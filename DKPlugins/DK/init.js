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
	DKLog("Init_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "DKCef_OnQueueNewBrowser")){ //NOTE: look into this
		DKCef_SetUrl(DKCef_GetCurrentBrowser(), DK_GetValue(event));
	}
	if(DK_Type(event, "resize")){ //NOTE: this is for SDL, OSG, ROCKET or any other created windows.
		DK_CallFunc("CefSDL::OnResize", "0,0,"+String(DKWindow_GetWidth())+","+String(DKWindow_GetHeight()));
	}
	if(DK_Type(event, "keydown") && DK_GetValue(event) == "4"){ //NOTE: this is the back button on Android
		DK_Exit();
	}
}

////////////////////////////////////
if(DK_GetJavascript() == "Duktape"){ //C++: Create a window LoadPage() can support
	if(USE_ROCKET && USE_CEF){
		DKLog("Creating SDL -> Rocket -> Cef -> GUI \n");
		DKCreate("DKWindow");
		DKWindow_Create();
		DKCreate("DKRocket");
		DKCreate("DKWidget");
		var iframe = DKWidget_CreateElement("body", "iframe", "DKCef_frame");
		DKWidget_SetAttribute(iframe, "src", DKApp_url);
		DKWidget_SetProperty(iframe, "position", "absolute");
		DKWidget_SetProperty(iframe, "top", "0rem");
		DKWidget_SetProperty(iframe, "left", "0rem");
		DKWidget_SetProperty(iframe, "width", "100%");
		DKWidget_SetProperty(iframe, "bottom", "0rem");
		DKCef_SetUrl(DKCef_GetCurrentBrowser(), DKApp_url);
		DKCef_SetFocus(0);
		//DKAddEvent("GLOBAL", "DKCef_OnQueueNewBrowser", init_OnEvent);
	}
	else if(USE_ROCKET){
		DKLog("Creating SDL -> ROCKET -> GUI \n");
		DKCreate("DKWindow");
		DKWindow_Create();
		DKCreate("DKRocket");
		DKCreate("DKWidget");
		if(typeof app_LoadPage === "function"){
			app_LoadPage();
		}
	}
	else if(USE_SDL && USE_CEF){
		/////////////  FIXME: BROKEN /////////////////////
		DKLog("Creating SDL -> CEF -> GUI \n");
		DKCreate("DKWindow");
		DKWindow_Create();
		var width = DKWindow_GetWidth();
		var height = DKWindow_GetHeight();
		DKCreate("DKCef,CefSDL,0,0,"+width+","+height+","+DKApp_url);
		DKCef_SetUrl(0, DKApp_url);
		DKCef_SetFocus(0);
		DKAddEvent("GLOBAL", "resize", init_OnEvent);
	}
	else if(USE_CEF){
		DKLog("Creating CEF -> GUI \n");
		var width = 800;
		var height = 600;
		DKCreate("DKCef,Cef,0,0,"+width+","+height+","+DKApp_url);
		DKCreate("DKWindow");
	}
	else if(USE_WEBVIEW){ //TODO
		DKLog("Creating WEBVIEW -> GUI \n");
		DKAddEvent("GLOBAL", "keydown", init_OnEvent);
	}
	
	if(typeof app_LoadPlugins === "function"){
		app_LoadPlugins();
	}
}
else{  //Javascript: V8, WEBVIEW or Duktape
	if(typeof app_LoadPage === "function"){
		app_LoadPage();
	}
}