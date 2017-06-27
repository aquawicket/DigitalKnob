var USE_SDL = 0;
var USE_ROCKET = 0;
var USE_CEF = 1;
var USE_WEBVIEW = 1;
var DKApp_url = "file:///"+DKAssets_LocalAssets()+"index.html";

	
//Validate settings
if(DK_GetOS() == "Android" || DK_GetOS() == "iOS"){  USE_CEF = 0;  }
else{ 	USE_WEBVIEW = 0;  }


////////////////////////////
function User_OnEvent(event)  //Duktape
{
	DKLog("User_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "DKCef_OnQueueNewBrowser")){
		DKCef_SetUrl("DKCef_frame", DK_GetValue(event), DKCef_GetCurrentBrowser("DKCef_frame"));
	}
	if(DK_Type(event, "keydown") && DK_GetValue(event) == "4"){
		DK_Exit();
	}
	if(DK_Type(event, "resize")){
		DK_CallFunc("CefSDL::OnResize", "0,0,"+String(DKWindow_GetWidth())+","+String(DKWindow_GetHeight()));
	}
}

////////////////////////////////
if(DK_GetJavascript() == "Duktape"){
	if(USE_SDL && USE_ROCKET && USE_CEF){
		DKLog("Creating SDL -> Rocket -> Cef -> GUI \n");
		DKCreate("DKWindow");
		DKWindow_Create();
		DKCreate("DKRocket");
		DKCreate("DKWidget");
		var assets = DKAssets_LocalAssets();
		var iframe = DKWidget_CreateElement("body", "iframe", "DKCef_frame");
		DKWidget_SetAttribute(iframe, "src", DKApp_url);
		DKWidget_SetProperty(iframe, "position", "absolute");
		DKWidget_SetProperty(iframe, "top", "0rem");
		DKWidget_SetProperty(iframe, "left", "0rem");
		DKWidget_SetProperty(iframe, "width", "100%");
		DKWidget_SetProperty(iframe, "bottom", "0rem");
		var currentBrowser = DKCef_GetCurrentBrowser(iframe);
		DKCef_SetUrl(iframe, DKApp_url, currentBrowser);
		DKCef_SetFocus(iframe);
		DKAddEvent("GLOBAL", "DKCef_OnQueueNewBrowser", User_OnEvent);
	}
	else if(USE_SDL && USE_ROCKET){
		DKLog("Creating SDL -> ROCKET -> GUI \n");
		DKCreate("DKWindow");
		DKWindow_Create();
		DKCreate("DKRocket");
		DKCreate("DKWidget");
		LoadPage();
	}
	else if(USE_SDL && USE_CEF){
		DKLog("Creating SDL -> CEF -> GUI \n");
		DKCreate("DKWindow");
		DKWindow_Create();
		var width = DKWindow_GetWidth();
		var height = DKWindow_GetHeight();
		DKCreate("DKCef,CefSDL,0,0,"+width+","+height+","+DKApp_url);
		var currentBrowser = DKCef_GetCurrentBrowser("CefSDL");
		DKCef_SetUrl("CefSDL", DKApp_url, currentBrowser);
		DKCef_SetFocus("CefSDL");
		DKAddEvent("GLOBAL", "resize", User_OnEvent);
	}
	else if(USE_CEF){
		DKLog("Creating CEF -> GUI \n");
		var width = 800;
		var height = 600;
		DKCreate("DKCef,Cef,0,0,"+width+","+height+","+DKApp_url);
		DK_SetFramerate(5);
		DKCreate("DKWindow");
	}
	else if(USE_WEBVIEW){
		DKLog("Creating WEBVIEW -> GUI \n");
		DKAddEvent("GLOBAL", "keydown", User_OnEvent);
	}
	
	DKCreate("DKTray/DKTray.js", function(){});
	//DKCreate("DKDebug/DKDebug.js", function(){});
}
else{  //V8 or WEBVIEW
	LoadPage();
}


///////////////////
function LoadPage()
{
	DKLog("LoadPage()\n");
	
	DKCreate("DKWindow/DKWindow.js", function(){
	DKCreate("DKScale/DKScale.js", function(){
	//DKCreate("YourApp.js", function(){ /* process */ });
	});
	});
}