var USE_CEF     = 1; //Desktop
var USE_WEBVIEW = 0; //TODO: Android, iOS
var USE_SDL     = 0; //Use with caution
var USE_ROCKET  = 0; //Use with caution
var DKApp_url   = "file:///"+DKAssets_LocalAssets()+"index.html";
//var DKApp_url = "http://digitalknob.com/DKOS/index.html";

DKCreate("DK/init.js", function(){});

//////////////////////////
function app_LoadPlugins()
{
	DKCreate("DKSDLText"); //SDL fps counter
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
	DKCreate("DKOS/DKOS.js", function(){
		
		/*
		DKWidget_SetProperty("body","background-color","grey");

		DKCreate("DKOS/DKOS.html", function(){
			var OS = DK_GetOS();
			DKLog("OS="+OS+"\n");
			DKWidget_SetProperty("DKOS/DKOS.html", "left", "0px");
			DKWidget_SetProperty("DKOS/DKOS.html", "top", "0px");
			DKWidget_SetProperty("DKOS/DKOS.html", "width", "100%");
			DKWidget_SetProperty("DKOS/DKOS.html", "height", "100%");
			if(OS != "iOS" && OS != "Android"){
				var screenwidth = DK_GetScreenWidth();
				var screenheight = DK_GetScreenHeight();
				var newwidth = parseInt(screenwidth)-100;
				var newheight = parseInt(screenheight)-150;
				DKWindow_SetWidth(newwidth);
				DKWindow_SetHeight(newheight);
			}
			DKCreate("DKOS/Desktop.js", function(){
			DKCreate("DKOS/Taskbar.js", function(){
			if(OS == "iOS" || OS == "Android"){
				//DKWidget_SetScale(2);   FIXME
		}
		*/
	});
	});
	});
	});
	});
	});
}