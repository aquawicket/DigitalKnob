var USE_CEF = 1;
var url = "http://127.0.0.1:2393";
var width = 800;
var height = 600;

/*
DKCreate("DKCef,Cef,0,0,"+width+","+height+","+url);
DK_SetFramerate(5);
DKCreate("DKDebug/DKDebug.js");
*/

////////////////////////////
function User_OnEvent(event)  //Duktape
{
	DKLog("User_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Type(event, "resize")){
		DK_CallFunc("CefSDL::OnResize", "0,0,"+String(DKWindow_GetWidth())+","+String(DKWindow_GetHeight()));
	}

	if(DK_Type(event, "keypress")){ //press a key to run this after a DevTools context menu is open, it will find 'Save'
		DKCef_RunJavascript("CefSDL", "var x = document.getElementsByClassName('soft-context-menu');");
		DKCef_RunJavascript("CefSDL", "var shadow_root = x[0].shadowRoot;");
		DKCef_RunJavascript("CefSDL", "var y = shadow_root.childNodes;");
		DKCef_RunJavascript("CefSDL", "var z = y[3].getElementsByClassName('soft-context-menu-item');");
		DKCef_RunJavascript("CefSDL", "var save = z[z.length-2];");
		DKCef_RunJavascript("CefSDL", "console.log(save.innerHTML);");
		DKCef_RunJavascript("CefSDL", "save.onmousedown = function(){alert('save clicked.')};");  ///grrrrr
	}
}

DKLog("Creating SDL -> CEF -> GUI \n", DKINFO);
DKCreate("DKWindow");
var width = DKWindow_GetWidth();
var height = DKWindow_GetHeight();
DKCreate("DKCef,CefSDL,0,0,"+width+","+height+","+url);
var currentBrowser = DKCef_GetCurrentBrowser("CefSDL");
DKCef_SetUrl("CefSDL", url, currentBrowser);
DKCef_SetFocus("CefSDL");
DKAddEvent("GLOBAL", "resize", User_OnEvent);
DKAddEvent("GLOBAL", "keypress", User_OnEvent);

