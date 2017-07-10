function DKDevTools_Init()
{
	DKLog("DKDevTools_Init()\n");
	
	DKAddEvent("GLOBAL", "keydown", DKDevTools_OnEvent);
}

function DKDevTools_End()
{
	//DKLog("DKDevTools_End()\n");
	
	DKRemoveEvents(DKDevTools_OnEvent);
}

function DKDevTools_OnEvent(event)
{
	//DKLog("DKDevTools_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");

	if(DK_Type(event, "keydown") && DK_GetValue(event) == 123){ //F12
		DKCef_ShowDevTools("Cef", 0);
	}
}