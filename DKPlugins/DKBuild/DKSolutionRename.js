DKSolutionRename_id = "";
DKSolutionRename_file = "";

//////////////////////////////
function DKSolutionRename_Init()
{
	DKCreate("DKBuild/DKSolutionRename.html");
	DKWidget_SetProperty("DKSolutionRename.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("DKSolutionRename.html","left",DKWindow_GetMouseX()+"px");
	DKAddEvent("GLOBAL", "mousedown", DKSolutionRename_OnEvent);
}

/////////////////////////////
function DKSolutionRename_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKSolutionRename_OnEvent);
	DKClose("DKSolutionRename.html");
}

//////////////////////////////////////
function DKSolutionRename_OnEvent(event)
{
	DKLog("DKSolutionRename_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKSolutionRename.html")){
			return;
		}
	}
	DKClose("DKSolutionRename.js");
}

/////////////////////////////////
function DKSolutionRename_SetId(id)
{
	DKLog("DKSolutionRename_SetId("+id+")\n", DKINFO);
	DKSolutionRename_id = id;
}

/////////////////////////////////////
function DKSolutionRename_SetFile(file)
{
	DKLog("DKSolutionRename_SetFile("+file+")\n", DKINFO);
	DKSolutionRename_file = file;
}
