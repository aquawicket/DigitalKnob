if(DK_GetOS() == "Win32" || DK_GetOS() == "Win64"  || DK_GetOS() == "Mac" || DK_GetOS() == "Linux"){
	var USE_CEF = 1;
}
if(DK_GetOS() == "Android"){
	var USE_Webview = 1;
}

if(DK_GetBrowser() == "Rocket"){
	DKCreate("DKWindow");
	DKCreate("DKRocket");
	DKCreate("DKWidget");
	DKCreate("DKWebview");
}
DKCreate("DKDebug/DKDebug.js", function(){});


///////////////////////////////////////////////
DKAddEvent("GLOBAL", "keydown", User_OnEvent);
function User_OnEvent(event)  //Duktape
{
	DKLog("User_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Type(event, "DKCef_OnQueueNewBrowser")){
		var currentBrowser = DKCef_GetCurrentBrowser("DKCef_frame");
		DKCef_SetUrl("DKCef_frame", DKWidget_GetValue(event), currentBrowser);
	}
	if(DK_Type(event, "keydown")){
		if(DKWidget_GetValue(event) == "4"){ //Exit for ANDROID
		    DK_Exit();
		}
	}
}


if(DK_GetBrowser() == "Rocket" && USE_CEF){
	var assets = DKAssets_LocalAssets();
	var url = "file:///"+assets+"/index.html";
	var iframe = DKWidget_CreateElement("body", "iframe", "DKCef_frame");
	DKWidget_SetAttribute(iframe, "src", url);
	DKWidget_SetProperty(iframe, "position", "absolute");
	DKWidget_SetProperty(iframe, "top", "0rem");
	DKWidget_SetProperty(iframe, "left", "0rem");
	DKWidget_SetProperty(iframe, "width", "100%");
	DKWidget_SetProperty(iframe, "bottom", "0rem");
	var currentBrowser = DKCef_GetCurrentBrowser(iframe);
	DKCef_SetUrl(iframe, url, currentBrowser);
	DKCef_SetFocus(iframe);
	
	DKAddEvent("GLOBAL", "DKCef_OnQueueNewBrowser", User_OnEvent);
}
else if(DK_GetBrowser() == "Rocket" && USE_Webview){ //Duktape
	var assets = DKAssets_LocalAssets();
	var url = "file:///"+assets+"/index.html";
	DKAddEvent("GLOBAL", "keydown", User_OnEvent);
}
else{  //Duktape or V8 or Webview
	DKWidget_SetProperty("body","background-color","grey");
	DKCreate("DKScale/DKScale.js", function(){});
	DKCreate("DKWebview/DKWebviewTest.js", function(){});
}
