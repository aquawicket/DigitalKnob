////////////////////////
function AppsMenu_Init()
{
	DKCreate("AppsMenu.html");
	DKAddEvent("GLOBAL", "mousedown", AppsMenu_OnEvent);
}

///////////////////////
function AppsMenu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", AppsMenu_OnEvent);
	DKClose("AppsMenu.html");
}

////////////////////////////////
function AppsMenu_OnEvent(event)
{
	//Process selection here
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "AppsMenu.html")){
			return;
		}
	}
	DKClose("DKOS/AppsMenu.js");
}