////////////////////////
function DKFacebook_Init()
{
	DKCreate("DKFacebook.html,Panel0_content");
	//DKAddEvent("GLOBAL", "mousedown", DKFacebook_OnEvent);
}

///////////////////////
function DKFacebook_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKFacebook_OnEvent);
	DKClose("DKFacebook.html");
}

////////////////////////////////
function DKFacebook_OnEvent(event)
{
	
}