///////////////////////
function Desktop_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKOS/Desktop.html");
	DKAddEvent("Background", "contextmenu", Desktop_OnEvent);
}

//////////////////////
function Desktop_End()
{
	DKDEBUGFUNC();
	DKClose("DKOS/Desktop.html");
}

///////////////////////////////
function Desktop_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(event.currentTarget.id == "Background" && event.type == "contextmenu"){
		DKCreate("DKOS/DesktopMenu.js", function(){});
	}
}