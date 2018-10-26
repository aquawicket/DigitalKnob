///////////////////////
function Desktop_Init()
{
	DKDEBUGFUNC();
	//DKCreate("DKGui/Desktop.html,DKGui/DKOS.html");
	DKCreate("DKGui/Desktop.html");
	DKAddEvent("Background", "contextmenu", Desktop_OnEvent);
}

//////////////////////
function Desktop_End()
{
	DKDEBUGFUNC();
	DKClose("DKGui/Desktop.html");
}

///////////////////////////////
function Desktop_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(DK_Id(event, "Background") && DK_Type(event, "contextmenu")){
		DKCreate("DKGui/DesktopMenu.js", function(){});
	}
}