var USE_CEF     = 1; //Desktop
var USE_WEBVIEW = 0; //TODO: Android, iOS
var USE_SDL     = 0; //Use with caution
var USE_ROCKET  = 0; //Use with caution
var DKApp_url   = "file:///"+DKAssets_LocalAssets()+"index.html";
//var DKApp_url = "http://digitalknob.com/DKGui/index.html";

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

///////////////////////
function app_LoadPage()
{
	DKLog("app_LoadPage()\n");
	
	DKCreate("DK/DKBrowser.css");
	DKCreate("DKWindow/DKWindow.js", function(){
	DKCreate("DKScale/DKScale.js", function(){
	DKCreate("DKGui/DKFrame.js", function(){
	DKCreate("DKGui/DKMenu.js", function(){
	DKCreate("DKDebug/DKDebug.js", function(){
	DKCreate("DKGui/Desktop.js", function(){
	DKCreate("DKGui/DKTaskbar/Taskbar.js", function(){
	
	});
	});
	});
	});
	});
	});
	});
}