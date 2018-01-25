var USE_CEF = 0;     //Desktop
var USE_WEBVIEW = 0; //Android, iOS?
var USE_SDL = 1;     //Use with caution
var USE_ROCKET = 1;  //Use with caution
var DKApp_url = "file:///"+DKAssets_LocalAssets()+"index.html";
//var DKApp_url = "http://digitalknob.com/DKBuilderGUI";

DKCreate("DK/init.js", function(){});

//////////////////////////
function app_LoadPlugins()
{

}

///////////////////////
function app_LoadPage()
{
	DKLog("app_LoadPage()\n");
	
	DKWidget_SetProperty("body", "background-color", "grey");
	DKCreate("DKWindow/DKWindow.js", function(){
	DKCreate("DKScale/DKScale.js", function(){
	DKCreate("DKGui/DKFrame.js", function(){
	DKCreate("DKGui/DKMenu.js", function(){
	DKCreate("DKDebug/DKDebug.js", function(){
	DKCreate("DKBuild/DKBuildGUI.js", function(){
		DKCreate("DKSDLText"); //SDL fps counter
		DKLog("width = "+DKWindow_GetWidth()+"\n");
		DKLog("height = "+DKWindow_GetHeight()+"\n");
		//DKCreate("DKNotepad/DKNotepad.js", function(){
		//	DKFrame_Widget("DKNotepad/DKNotepad.html");
		//});
	});
	});
	});
	});
	});
	});
}