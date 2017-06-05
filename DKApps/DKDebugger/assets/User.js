var USE_CEF = 1;
var url = "http://127.0.0.1:2393";
var width = 800;
var height = 600;

DKCreate("DKCef,Cef,0,0,"+width+","+height+","+url);
DK_SetFramerate(5);
DKCreate("DKDebug/DKDebug.js");

DKAddEvent("GLOBAL", "keypress", User_OnEvent);
////////////////////////////
function User_OnEvent(event)  //Duktape
{
	DKLog("User_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "keypress")){ //press a key to run this after a DevTools context menu is open, it will find 'Save'
		DKCef_RunJavascript("CefSDL", "var x = document.getElementsByClassName('soft-context-menu');");
		DKCef_RunJavascript("CefSDL", "var shadow_root = x[0].shadowRoot;");
		DKCef_RunJavascript("CefSDL", "var y = shadow_root.childNodes;");
		DKCef_RunJavascript("CefSDL", "var z = y[3].getElementsByClassName('soft-context-menu-item');");
		DKCef_RunJavascript("CefSDL", "var save = z[z.length-2];");
		DKCef_RunJavascript("CefSDL", "console.log(save.innerHTML);");
		
		//FIXME - we can get the element of the save button, but we cannot add an event.
		DKCef_RunJavascript("CefSDL", "save.onclick = function(){alert('save clicked.')};");  ///grrrrr
		//DKCef_RunJavascript("CefSDL", "save.addEventListener('focus', function(event){ event.preventDefault(); console.log('click'); });");
	}
}


