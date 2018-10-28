// executable app startup script

var USE_CEF     = 0; //Use Cef browser
var USE_ROCKET  = 1; //Use Rocket browser
var USE_SDL     = 0; //Use SDL window
var USE_WEBVIEW = 0; //TODO: Android, iOS

var DKApp_url   = "file:///"+DKAssets_LocalAssets()+"index.html";
//var DKApp_url = "http://google.com";
//var DKApp_url   = "file:///"+DKAssets_LocalAssets()+"index.html?plugin=DKNotepad/DKNotepad";

DKCreate("DK/init.js", function(){}); //load DKApp_url using flags above, then call app_LoadPlugins()

//////////////////////////
function app_LoadPlugins()
{
	if(USE_SDL){
		DKCreate("DKSDLText"); //Class contains SDL fps counter
	}
	DKCreate("DKTray/DKTray.js", function(){});
	DKCreate("DKDebug/DKDebug.js", function(){});
}