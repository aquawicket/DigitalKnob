//////////////////////
function DKHook_Init()
{
	DKCreate("DKHook");

	DKAddEvent("GLOBAL", "mousemove", DKHook_OnEvent);
	DKAddEvent("GLOBAL", "mousedown", DKHook_OnEvent);
	DKAddEvent("GLOBAL", "mouseup", DKHook_OnEvent);
	DKAddEvent("GLOBAL", "keypress", DKHook_OnEvent);
	DKAddEvent("GLOBAL", "keydown", DKHook_OnEvent);
	DKAddEvent("GLOBAL", "keyup", DKHook_OnEvent);
}

/////////////////////
function DKHook_End()
{
	DKRemoveEvents(DKHook_OnEvent);
}

//////////////////////////////
function DKHook_OnEvent(event)
{
	DKLog("DKHook_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
}