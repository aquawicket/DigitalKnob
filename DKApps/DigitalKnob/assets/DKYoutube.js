////////////////////////
function DKYoutube_Init()
{
	DKCreate("DKYoutube.html,Panel0_content");
	//DKAddEvent("GLOBAL", "mousedown", DKYoutube_OnEvent);
}

///////////////////////
function DKYoutube_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKYoutube_OnEvent);
	DKClose("DKYoutube.html");
}

////////////////////////////////
function DKYoutube_OnEvent(event)
{
	
}