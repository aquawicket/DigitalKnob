DKCreate("DKSDLWindow");
DKCreate("DKWindow");

DKLog("DKWindow_TestInt(1234) = "+DKWindow_TestInt(1234)+"\n", DKINFO);
DKLog("DKWindow_TestString(\"test string\") = "+DKWindow_TestString("test string")+"\n", DKINFO);
DKLog("DKWindow_TestReturnInt() = "+DKWindow_TestReturnInt()+"\n", DKINFO);
DKLog("DKWindow_TestReturnString() = "+DKWindow_TestReturnString()+"\n", DKINFO);

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
