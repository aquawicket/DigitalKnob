///////////////////////
function SvnMenu_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKBuild/SvnMenu.html");
	document.getElementById("SvnMenu.html").style.top = DKWindow_GetMouseY()+"px";
	document.getElementById("SvnMenu.html").style.left = DKWindow_GetMouseX()+"px";
	DKAddEvent("window", "mousedown", SvnMenu_OnEvent);
	DKAddEvent("Svn Update", "click", SvnMenu_OnEvent);
	DKAddEvent("Svn Commit", "click", SvnMenu_OnEvent);
}

//////////////////////
function SvnMenu_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(SvnMenu_OnEvent);
	DKClose("DKBuild/SvnMenu.html");
}

///////////////////////////////
function SvnMenu_OnEvent(event)
{
	DKDEBUGFUNC(event);
	DKDEBUG("SvnMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	if(DK_Id(event,"Svn Update")){
		DKThread_DKQueue("SvnUpdate","DKBuild_SvnUpdate();");
	}
	if(DK_Id(event,"Svn Commit")){
		DKThread_DKQueue("SvnCommit","DKBuild_SvnCommit();");
	}
	
	if(DK_Id(event, "window")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "SvnMenu.html")){
			return;
		}
	}
	DKClose("DKBuild/SvnMenu.js");
}