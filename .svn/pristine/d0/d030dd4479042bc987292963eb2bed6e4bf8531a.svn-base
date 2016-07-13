///////////////////////
function Desktop_Init()
{
	DKCreate("DKOS/Desktop.html");
	DKAddEvent("Background", "contextmenu", Desktop_OnEvent);
}

//////////////////////
function Desktop_End()
{
	DKClose("DKOS/Desktop.html");
}

///////////////////////////////
function Desktop_OnEvent(event)
{
	if(DK_Id(event, "Background") && DK_Type(event, "contextmenu")){
		DKCreate("DKOS/DesktopMenu.js");
	}
}