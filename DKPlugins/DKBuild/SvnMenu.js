///////////////////////
function SvnMenu_Init()
{
	DK_Create("DKBuild/SvnMenu.html");
	byId("SvnMenu.html").style.top = DKWindow_GetMouseY()+"px";
	byId("SvnMenu.html").style.left = DKWindow_GetMouseX()+"px";
	window.addEventListener("mousedown", SvnMenu_OnEvent);
	byId("Svn Update").addEventListener("click", SvnMenu_OnEvent);
	byId("Svn Commit").addEventListener("click", SvnMenu_OnEvent);
}

//////////////////////
function SvnMenu_End()
{
	window.addEventListener("mousedown", SvnMenu_OnEvent);
	byId("Svn Update").addEventListener("click", SvnMenu_OnEvent);
	byId("Svn Commit").addEventListener("click", SvnMenu_OnEvent);
	DK_Close("DKBuild/SvnMenu.html");
}

///////////////////////////////
function SvnMenu_OnEvent(event)
{
	DKDEBUG("SvnMenu_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id === "Svn Update"){
		DKThread_DKQueue("SvnUpdate","DKBuild_SvnUpdate();");
	}
	if(event.currentTarget.id === "Svn Commit"){
		DKThread_DKQueue("SvnCommit","DKBuild_SvnCommit();");
	}
	
	if(event.currentTarget === window){
		if(byId("SvnMenu.html").contains(DKWidget_GetHoverElement())){	
			return;
		}
	}
	DK_Close("DKBuild/SvnMenu.js");
}