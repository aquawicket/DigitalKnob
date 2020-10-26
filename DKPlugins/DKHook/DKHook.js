//////////////////////
function DKHook_Init()
{
	DK_Create("DKHook");
	window.addEventListener("GLOBAL_mousemove", DKHook_OnEvent);
	window.addEventListener("GLOBAL_mousedown", DKHook_OnEvent);
	window.addEventListener("GLOBAL_mouseup", DKHook_OnEvent);
	window.addEventListener("GLOBAL_keypress", DKHook_OnEvent);
	window.addEventListener("GLOBAL_keydown", DKHook_OnEvent);
	window.addEventListener("GLOBAL_keyup", DKHook_OnEvent);
}

/////////////////////
function DKHook_End()
{
	window.removeEventListener("GLOBAL_mousemove", DKHook_OnEvent);
	window.removeEventListener("GLOBAL_mousedown", DKHook_OnEvent);
	window.removeEventListener("GLOBAL_mouseup", DKHook_OnEvent);
	window.removeEventListener("GLOBAL_keypress", DKHook_OnEvent);
	window.removeEventListener("GLOBAL_keydown", DKHook_OnEvent);
	window.removeEventListener("GLOBAL_keyup", DKHook_OnEvent);
}

//////////////////////////////
function DKHook_OnEvent(event)
{

}