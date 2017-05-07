///////////////////////////
function LibraryMenu_Init()
{
	DKCreate("DKBuild/LibraryMenu.html");
	DKWidget_SetProperty("LibraryMenu.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("LibraryMenu.html","left",DKWindow_GetMouseX()+"px");
	DKAddEvent("GLOBAL", "mousedown", LibraryMenu_OnEvent);
	DKAddEvent("Build Libraries", "click", LibraryMenu_OnEvent);
}

//////////////////////////
function LibraryMenu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", LibraryMenu_OnEvent);
	DKClose("DKBuild/LibraryMenu.html");
}

///////////////////////////////////
function LibraryMenu_OnEvent(event)
{
	DKLog("LibraryMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event, "Build Libraries")){
		DKLog("Clicked Build Libraries\n", DKDEBUG);
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "LibraryMenu.html")){
			return;
		}
	}
	DKClose("DKBuild/LibraryMenu.js");
}