//////////////////////
function DKHook_Init()
{
	DKCreate("DKHook");

	DKAddEvent("window", "mousemove", DKHook_OnEvent);
	DKAddEvent("window", "mousedown", DKHook_OnEvent);
	DKAddEvent("window", "mouseup", DKHook_OnEvent);
	DKAddEvent("window", "keypress", DKHook_OnEvent);
	DKAddEvent("window", "keydown", DKHook_OnEvent);
	DKAddEvent("window", "keyup", DKHook_OnEvent);
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