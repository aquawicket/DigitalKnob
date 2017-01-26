DKCreate("DKWindow");
DKCreate("DKRocket");
DKCreate("DKWidget");
DKCreate("DKScale/DKScale.js", function(){});
DKCreate("DKFrame/DKFrame.js", function(){});
DKCreate("DKDebug/DKDebug.js", function(){});
DKCreate("DKWebview/DKWebviewTest.js", function(){});

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
