///////////////////////
function Desktop_Init()
{
	DKDEBUGFUNC();
	//DKCreate("DKOS/Desktop.html,DKOS/DKOS.html");
	DKCreate("DKOS/Desktop.html");
	//DKAddEvent("Background", "contextmenu", Desktop_OnEvent)"
	byId("Background").addEventListener("contextmenu", Desktop_OnEvent);
}

//////////////////////
function Desktop_End()
{
	DKDEBUGFUNC();
	byId("Background").removeEventListener("contextmenu", Desktop_OnEvent);
	DKClose("DKOS/Desktop.html");
}

///////////////////////////////
function Desktop_OnEvent(event)
{
	//DKDEBUGFUNC(event);
	//console.log("Desktop_OnEvent("+event+")");
	if(event.currentTarget.id == "Background" && event.type == "contextmenu"){
		DKCreate("DKOS/DesktopMenu.js", function(){});
	}
}