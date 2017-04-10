//TODO

///////////////////////
function DKFileMenu_Init()
{
	DKCreate("DKFileMenu/DKFileMenu.html");
}

///////////////////////
function DKFileMenu_End()
{
	DKClose("DKFileMenu.html");
}

///////////////////////////////
function DKFileMenu_OnEvent(event)
{
	DKLog("DKFileMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKINFO);
	
}
