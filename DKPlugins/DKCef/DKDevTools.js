function DKDevTools_Init()
{
	DKAddEvent("GLOBAL", "keydown", DKDevTools_OnEvent);
}

function DKDevTools_End()
{

}

function DKDevTools_OnEvent(event)
{
	//DKLog("DKDevTools_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKINFO);

	if(DK_Type(event, "keydown") && DK_GetValue(event) == 123){ //F12
		DKCef_ShowDevTools("Cef", 0);
	}
}