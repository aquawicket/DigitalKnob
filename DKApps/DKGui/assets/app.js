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

///////////////////////
function app_LoadPage()
{
	DKDEBUGFUNC();
	if(typeof window == "object"){
		var url_string = window.location.href;
		var url = new URL(url_string);
		var frame = url.searchParams.get("frame");
		var plugin = url.searchParams.get("plugin");
	
		if(plugin){
			DKCreate("DK/DK.css");	
			DKCreate("DKFile/DKFile.js", function(){
			DKCreate("DKWidget/DKWidget.js", function(){
			DKCreate("DKGui/DKFrame.js", function(){
			DKCreate(plugin+".js", function(){
				if(frame){
					DKFrame_Widget(plugin+".html");
				}
			});
			});
			});
			});
			return;
		}
	}
	
	DKCreate("DK/DK.css");	
	DKCreate("DKFile/DKFile.js", function(){
	DKCreate("DKWindow/DKWindow.js", function(){
	DKCreate("DKWidget/DKWidget.js", function(){
	DKCreate("DKDom/DKDom.js", function(){
	DKCreate("DKScale/DKScale.js", function(){
	DKCreate("DKGui/DKFrame.js", function(){
	DKCreate("DKGui/DKMenu.js", function(){
	DKCreate("DKDebug/DKDebug.js", function(){
	DKCreate("DKGui/Desktop.js", function(){
	DKCreate("DKGui/Taskbar.js", function(){
	
	});
	});
	});
	});
	});
	});
	});
	});
	});
	});
}