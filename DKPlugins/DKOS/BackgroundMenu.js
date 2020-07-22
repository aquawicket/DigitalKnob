//////////////////////////////
function BackgroundMenu_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKOS/BackgroundMenu.html");
	var file = document.getElementById("Background").getAttribute("src");
	//DKINFO("file="+file+"\n");
	document.getElementById("BackgroundMenu_Image").setAttribute("src", file);
}

/////////////////////////////
function BackgroundMenu_End()
{
	DKDEBUGFUNC();
	DKClose("DKOS/BackgroundMenu.html");
}

//////////////////////////////////////
function BackgroundMenu_OnEvent(event)
{
	DKDEBUGFUNC(event);
}
