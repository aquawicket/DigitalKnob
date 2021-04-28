//////////////////////
function DKHook_init()
{
	dk.create("DKHook");
	window.addEventListener("mousemove", DKHook_onevent);
	window.addEventListener("mousedown", DKHook_onevent);
	window.addEventListener("mouseup", DKHook_onevent);
	window.addEventListener("keypress", DKHook_onevent);
	window.addEventListener("keydown", DKHook_onevent);
	window.addEventListener("keyup", DKHook_onevent);
}

/////////////////////
function DKHook_end()
{
	window.removeEventListener("mousemove", DKHook_onevent);
	window.removeEventListener("mousedown", DKHook_onevent);
	window.removeEventListener("mouseup", DKHook_onevent);
	window.removeEventListener("keypress", DKHook_onevent);
	window.removeEventListener("keydown", DKHook_onevent);
	window.removeEventListener("keyup", DKHook_onevent);
}

//////////////////////////////
function DKHook_OnEvent(event)
{

}