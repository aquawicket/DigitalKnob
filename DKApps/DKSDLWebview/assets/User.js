DKCreate("DKWindow");
DKCreate("DKRocket");
DKCreate("DKWidget");
DKCreate("DKScale/DKScale.js");
DKCreate("DKFrame/DKFrame.js");
DKCreate("DKDebug/DKDebug.js");
DKCreate("DKWebview/DKWebviewTest.js");
//DKWidget_SetProperty("DKWebviewTest.html", "width", "100%");
//DKWidget_SetProperty("DKWebviewTest.html", "height", "100%");

///////////////////////////////////////////////
DKAddEvent("GLOBAL", "keydown", User_OnEvent);
function User_OnEvent(event)  //Duktape
{
	DKLog("User_OnEvent("+event+")", DKINFO);
	
	if(DK_Type(event, "keydown")){
		if(DKWidget_GetValue(event) == "4"){ //Exit for ANDROID
		    DK_Exit();
		}
	}
}
//////////////////////////

DKCreate("DKWebview");
