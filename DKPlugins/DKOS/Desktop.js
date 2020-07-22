///////////////////////
function Desktop_Init()
{
	DKDEBUGFUNC();
	//DKCreate("DKOS/Desktop.html,DKOS/DKOS.html");
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
	//DKDEBUGFUNC(event);
	console.log("Desktop_OnEvent("+event+")");
	if(DK_Id(event, "Background") && DK_Type(event, "contextmenu")){
		DKCreate("DKOS/DesktopMenu.js", function(){});
	}
}