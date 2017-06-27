///////////////////////////
function LibraryMenu_Init()
{
	//DKLog("LibraryMenu_Init()");
	
	DKCreate("DKBuild/LibraryMenu.html");
	DKAddEvent("GLOBAL", "mousedown", LibraryMenu_OnEvent);
	DKAddEvent("Build Libraries", "click", LibraryMenu_OnEvent);
}

//////////////////////////
function LibraryMenu_End()
{
	//DKLog("LibraryMenu_End()");
	
	DKRemoveEvents(LibraryMenu_OnEvent);
	DKClose("DKBuild/LibraryMenu.html");
}

///////////////////////////////////
function LibraryMenu_OnEvent(event)
{
	//DKLog("LibraryMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "Build Libraries")){
		DKLog("Clicked Build Libraries\n");
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKBuild/LibraryMenu.html")){
			return;
		}
	}
	DKClose("DKBuild/LibraryMenu.js");
}