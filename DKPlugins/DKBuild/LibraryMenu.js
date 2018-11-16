///////////////////////////
function LibraryMenu_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKBuild/LibraryMenu.html");
	DKAddEvent("window", "mousedown", LibraryMenu_OnEvent);
	DKAddEvent("Build Libraries", "click", LibraryMenu_OnEvent);
}

//////////////////////////
function LibraryMenu_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(LibraryMenu_OnEvent);
	DKClose("DKBuild/LibraryMenu.html");
}

///////////////////////////////////
function LibraryMenu_OnEvent(event)
{
	DKDEBUGFUNC();
	DKDEBUG("LibraryMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "Build Libraries")){
		DKINFO("Clicked Build Libraries\n");
	}
	
	if(DK_Id(event, "window")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKBuild/LibraryMenu.html")){
			return;
		}
	}
	DKClose("DKBuild/LibraryMenu.js");
}