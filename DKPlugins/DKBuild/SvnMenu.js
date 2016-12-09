///////////////////////
function SvnMenu_Init()
{
	DKCreate("DKBuild/SvnMenu.html");
	DKWidget_SetProperty("SvnMenu.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("SvnMenu.html","left",DKWindow_GetMouseX()+"px");
	DKAddEvent("GLOBAL", "mousedown", SvnMenu_OnEvent);
	DKAddEvent("Svn Update", "click", SvnMenu_OnEvent);
	DKAddEvent("Svn Commit", "click", SvnMenu_OnEvent);
}

//////////////////////
function SvnMenu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", SvnMenu_OnEvent);
	DKClose("DKBuild/SvnMenu.html");
}

///////////////////////////////
function SvnMenu_OnEvent(event)
{
	DKLog("SvnMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event,"Svn Update")){
		DKThread_DKQueue("SvnUpdate","DKBuild_SvnUpdate();");
	}
	if(DK_Id(event,"Svn Commit")){
		DKThread_DKQueue("SvnCommit","DKBuild_SvnCommit();");
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "SvnMenu.html")){
			return;
		}
	}
	DKClose("DKBuild/SvnMenu.js");
}