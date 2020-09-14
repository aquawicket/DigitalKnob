///////////////////////
function SvnMenu_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKBuild/SvnMenu.html");
	byId("SvnMenu.html").style.top = DKWindow_GetMouseY()+"px";
	byId("SvnMenu.html").style.left = DKWindow_GetMouseX()+"px";
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
	DKDEBUG("SvnMenu_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id == "Svn Update"){
		DKThread_DKQueue("SvnUpdate","DKBuild_SvnUpdate();");
	}
	if(event.currentTarget.id == "Svn Commit"){
		DKThread_DKQueue("SvnCommit","DKBuild_SvnCommit();");
	}
	
	if(event.currentTarget == window){
		if(byId("SvnMenu.html").contains(DKWidget_GetHoverElement())){	
			return;
		}
	}
	DKClose("DKBuild/SvnMenu.js");
}