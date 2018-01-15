//////////////////////
function DKHook_Init()
{
	DKCreate("DKHook");

	DKAddEvent("GLOBAL", "GLOBAL_mousemove", DKHook_OnEvent);
	DKAddEvent("GLOBAL", "GLOBAL_mousedown", DKHook_OnEvent);
	DKAddEvent("GLOBAL", "GLOBAL_mouseup", DKHook_OnEvent);
	DKAddEvent("GLOBAL", "GLOBAL_keypress", DKHook_OnEvent);
	DKAddEvent("GLOBAL", "GLOBAL_keydown", DKHook_OnEvent);
	DKAddEvent("GLOBAL", "GLOBAL_keyup", DKHook_OnEvent);
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