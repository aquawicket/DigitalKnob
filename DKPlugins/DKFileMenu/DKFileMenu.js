//TODO

///////////////////////
function DKFileMenu_Init()
{
	DKLog("DKFileMenu_Init()",DKINFO);
	//DKCreate("DKFileMenu/DKFileMenu.html");
}

///////////////////////
function DKFileMenu_End()
{
	//DKClose("DKFileMenu.html");
}

///////////////////////////////
function DKFileMenu_OnEvent(event)
{
	DKLog("DKFileMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
}

////////////////////////////////
function DKFileMenu_Widget(id)
{
	var filemenu = DKWidget_CreateElement(id, "div", "DKFileMenu");
	DKWidget_SetProperty(filemenu, "position", "absolute");
	DKWidget_SetProperty(filemenu, "width", "100%");
	DKWidget_SetProperty(filemenu, "height", "20rem");
	DKWidget_SetProperty(filemenu, "background-color", "rgb(200,200,200)");
}
