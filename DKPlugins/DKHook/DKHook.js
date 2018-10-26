//////////////////////
function DKHook_Init()
{
	DKDEBUGFUNC();
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
	DKDEBUGFUNC();
	DKRemoveEvents(DKHook_OnEvent);
}

//////////////////////////////
function DKHook_OnEvent(event)
{
	DKDEBUGFUNC(event);
}