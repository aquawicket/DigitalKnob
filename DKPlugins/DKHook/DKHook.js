//////////////////////
function DKHook_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKHook");
	DKAddEvent("window", "GLOBAL_mousemove", DKHook_OnEvent);
	DKAddEvent("window", "GLOBAL_mousedown", DKHook_OnEvent);
	DKAddEvent("window", "GLOBAL_mouseup", DKHook_OnEvent);
	DKAddEvent("window", "GLOBAL_keypress", DKHook_OnEvent);
	DKAddEvent("window", "GLOBAL_keydown", DKHook_OnEvent);
	DKAddEvent("window", "GLOBAL_keyup", DKHook_OnEvent);
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