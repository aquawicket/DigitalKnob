DKCreate("test.html");

////////////////////
function test_Init()
{
	DKAddEvent("GLOBAL", "keydown", test_OnEvent);
}

////////////////////////////
function test_OnEvent(event)
{
	DKLog("test_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Type(event,"keydown")){
		DKLog("keydown "+DKWidget_GetValue(event)+" \n");
		if(DKWidget_GetValue(event) == "4"){ //ANDROID_BACK
			DK_Exit();
		}
	}
}