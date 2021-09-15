// executable app startup script
var USE_CEF     = 0; //Use Cef browser
var USE_RML  = 1; //Use Rocket browser
var USE_SDL     = 0; //Use SDL window
var USE_WEBVIEW = 0; //TODO: Android, iOS

var DKApp_url   = "file:///"+DKAssets_LocalAssets()+"index.html";
//var DKApp_url = "http://google.com";
//var DKApp_url   = "file:///"+DKAssets_LocalAssets()+"index.html?plugin=DKNotepad/DKNotepad";

dk.create("DK/init.js", function(){}); //load DKApp_url using flags above, then call app_LoadPlugins()

function app_LoadPlugins() {
	if(USE_SDL)
		dk.create("DKSDLText"); //Class contains SDL fps counter
	dk.create("DKTray/DKTray.js", function(){});
	dk.create("DKDebug/DKDebug.js", function(){});
}