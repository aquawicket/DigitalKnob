DKCreate("DKWindow");
//var url = "file:///C:/digitalknob/DKApps/DKIDE/assets/index.html";
var url = "http://127.0.0.1:2393";
var width = DKWindow_GetWidth();
var height = DKWindow_GetHeight();
DKCreate("DKCef,CefSDL,0,0,"+width+","+height+","+url);
var currentBrowser = DKCef_GetCurrentBrowser("CefSDL");
DKCef_SetUrl("CefSDL", url, currentBrowser);
DKCef_SetFocus("CefSDL");

//DKCreate("DKDebug/DKDebug.js");

DKAddEvent("GLOBAL", "resize", User_OnEvent);


////////////////////////////
function User_OnEvent(event)
{
	if(DK_Type(event, "resize")){
		//DKLog("User_OnEvent(): resize\n", DKINFO);
		//DKCef_SetSize("CefSDL", 100, 100);
		var width = DKWindow_GetWidth();
		var height = DKWindow_GetHeight();
		DK_CallFunc("CefSDL::OnResize", "0,0,"+String(width)+","+String(height));
	}
}