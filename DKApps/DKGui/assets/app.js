var USE_CEF     = 0; //Desktop
var USE_WEBVIEW = 0; //TODO: Android, iOS
var USE_SDL     = 0; //Use with caution
var USE_ROCKET  = 1; //Use with caution
//var DKApp_url = "http://google.com";
var DKApp_url   = "file:///"+DKAssets_LocalAssets()+"index.html";
//var DKApp_url   = "file:///"+DKAssets_LocalAssets()+"index.html?plugin=DKNotepad/DKNotepad";

DKCreate("DK/init.js", function(){});

//////////////////////////
function app_LoadPlugins()
{
	if(USE_SDL){
		DKCreate("DKSDLText"); //SDL fps counter
	}
	DKCreate("DKTray/DKTray.js", function(){});
	DKCreate("DKDebug/DKDebug.js", function(){});
}