//////////////////////
function DKHook_Init()
{
	DK_Create("DKHook");
	window.addEventListener("mousemove", DKHook_OnEvent);
	window.addEventListener("mousedown", DKHook_OnEvent);
	window.addEventListener("mouseup", DKHook_OnEvent);
	window.addEventListener("keypress", DKHook_OnEvent);
	window.addEventListener("keydown", DKHook_OnEvent);
	window.addEventListener("keyup", DKHook_OnEvent);
}

/////////////////////
function DKHook_End()
{
	window.removeEventListener("mousemove", DKHook_OnEvent);
	window.removeEventListener("mousedown", DKHook_OnEvent);
	window.removeEventListener("mouseup", DKHook_OnEvent);
	window.removeEventListener("keypress", DKHook_OnEvent);
	window.removeEventListener("keydown", DKHook_OnEvent);
	window.removeEventListener("keyup", DKHook_OnEvent);
}

//////////////////////////////
function DKHook_OnEvent(event)
{

}