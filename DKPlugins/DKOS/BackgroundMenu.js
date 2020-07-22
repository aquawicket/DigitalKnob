//////////////////////////////
function BackgroundMenu_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKOS/BackgroundMenu.html");
	var file = DKWidget_GetAttribute("Background","src");
	//DKINFO("file="+file+"\n");
	DKWidget_SetAttribute("BackgroundMenu_Image","src",file);
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
