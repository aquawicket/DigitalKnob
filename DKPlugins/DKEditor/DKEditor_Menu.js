
//////////////////////////
function DKEditor_Menu_Init()
{
	DKCreate("DKEditor/DKEditor_Menu.html");
	DKWidget_SetProperty("DKEditor_Menu.html","top",DKWindow_GetMouseY()+"rem");
	DKWidget_SetProperty("DKEditor_Menu.html","left",DKWindow_GetMouseX()+"rem");
	DKAddEvent("GLOBAL", "mousedown", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Item1", "click", DKEditor_Menu_OnEvent);
}

/////////////////////////
function DKEditor_Menu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKEditor_Menu_OnEvent);
	DKRemoveEvent("DKEditor_Menu_Item11", "click", DKEditor_Menu_OnEvent);
	DKClose("DKEditor/DKEditor_Menu.html");
}

//////////////////////////////////
function DKEditor_Menu_OnEvent(event)
{
	DKLog("DKEditor_Menu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKINFO);
	

	DKClose("DKEditor/DKEditor_Menu.js");
}