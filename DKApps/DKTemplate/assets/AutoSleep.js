var timeSinceActivity = 0;

/////////////////////////
function AutoSleep_Init()
{
	DKCreate("DKHook");

	DKAddEvent("GLOBAL", "second", AutoSleep_OnEvent);
	DKAddEvent("GLOBAL", "GLOBAL_mousemove", AutoSleep_OnEvent);
	DKAddEvent("GLOBAL", "GLOBAL_mousedown", AutoSleep_OnEvent);
	DKAddEvent("GLOBAL", "GLOBAL_mouseup", AutoSleep_OnEvent);
	DKAddEvent("GLOBAL", "GLOBAL_keypress", AutoSleep_OnEvent);
	DKAddEvent("GLOBAL", "GLOBAL_keydown", AutoSleep_OnEvent);
	DKAddEvent("GLOBAL", "GLOBAL_keyup", AutoSleep_OnEvent);
}

////////////////////////
function AutoSleep_End()
{
	DKRemoveEvents(AutoSleep_OnEvent);
}

/////////////////////////////////
function AutoSleep_OnEvent(event)
{
	//DKLog("AutoSleep_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "second")){
		timeSinceActivity++;
	}
	else{
		timeSinceActivity = 0;
	}
	
	//DKLog("timeSinceActivity = "+timeSinceActivity+"\n", DKINFO);
	if(timeSinceActivity == 300){
		DKLog("Turn Off Monitor");
		DK_TurnOffMonitor();
	}
}