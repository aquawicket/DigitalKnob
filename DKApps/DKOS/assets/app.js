var USE_CEF     = 1; //Desktop
var USE_WEBVIEW = 0; //TODO: Android, iOS
var USE_SDL     = 0; //Use with caution
var USE_ROCKET  = 0; //Use with caution
var DKApp_url = "file:///"+DKAssets_LocalAssets()+"/index.html";
//var DKApp_url = "http://digitalknob.com/DKOS/index.html";
//var DKApp_url = "http://google.com";
//var DKApp_url = "chrome://gpu";

DKCreate("DK/init.js", function(){});

//////////////////////////
function app_LoadPlugins()
{
	
}

///////////////////////
function app_LoadPage()
{
	//DKLog("Loading page... \n");
	DKWidget_SetProperty("body","background-color","grey");
	DKCreate("DKScale/DKScale.js", function(){});
	DKCreate("DKOS/DKOS.js", function(){});
	DKCreate("DKDebug/DKDebug.js", function(){});
	
	//DKCreate("DKFileMenu/DKFileMenu.js", function(){
	//	DKFileMenu_Widget("body");
	//});
	
	//if(DK_GetBrowser() != "CEF"){ 
	//	DKCreate("DKGoogleAd/DKGoogleAd.js", function(){
	//		var id = DKGoogleAd_CreateAd("body", "100%", "100rem");
	//	});
	//}
}
