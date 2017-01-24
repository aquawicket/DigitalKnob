DKCreate("DKSDLWindow");
DKCreate("DKWindow");

/*
for(var i=0; i<10000; i++){
	DKLog("DKWindow_TestInt() = "+DKWindow_TestInt(23931)+"\n", DKINFO);
	DKLog("DKWindow_TestString() = "+DKWindow_TestString("this is a test string")+"\n", DKINFO);
}
*/

/////////////////////////
//ANDROID back key = exit
DKAddEvent("GLOBAL", "keydown", User_OnEvent);
function User_OnEvent(event)  //Duktape
{
	if(DK_Type(event, "keydown")){
		if(DKWidget_GetValue(event) == "4"){ //Exit for ANDROID
		    DK_Exit();
		}
	}
}
//////////////////////////