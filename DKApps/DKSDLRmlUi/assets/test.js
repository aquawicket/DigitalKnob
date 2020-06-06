DKCreate("test.html");

////////////////////
function test_Init()
{
	DKAddEvent("GLOBAL", "keydown", test_OnEvent);
}

////////////////////////////
function test_OnEvent(event)
{
	DKLog("test_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Type(event,"keydown")){
		DKLog("keydown "+DK_GetValue(event)+" \n");
		if(DK_GetValue(event) == "4"){ //ANDROID_BACK
			DK_Exit();
		}
	}
}