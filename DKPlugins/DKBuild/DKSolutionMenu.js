DKSolutionMenu_file = "";

//////////////////////////////
function DKSolutionMenu_Init()
{
	DKCreate("DKBuild/DKSolutionMenu.html");
	DKWidget_SetProperty("DKSolutionMenu.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("DKSolutionMenu.html","left",DKWindow_GetMouseX()+"px");
	DKAddEvent("GLOBAL", "mousedown", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_Rename", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_Delete", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_Copy", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_Cut", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_Paste", "click", DKSolutionMenu_OnEvent);
}

/////////////////////////////
function DKSolutionMenu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_Rename", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_Delete", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_Copy", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_Cut", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_Paste", "click", DKSolutionMenu_OnEvent);
	DKClose("DKSolutionMenu.html");
}

//////////////////////////////////////
function DKSolutionMenu_OnEvent(event)
{
	DKLog("DKSolutionMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event,"DKSolutionMenu_Rename")){
		DKSolutionMenu_Rename();
	}
	if(DK_Id(event,"DKSolutionMenu_Delete")){
		DKSolutionMenu_Delete();
	}
	if(DK_Id(event,"DKSolutionMenu_Copy")){
		DKSolutionMenu_Copy();
	}
	if(DK_Id(event,"DKSolutionMenu_Cut")){
		DKSolutionMenu_Cut();
	}
	if(DK_Id(event,"DKSolutionMenu_Paste")){
		DKSolutionMenu_Paste();
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKSolutionMenu.html")){
			return;
		}
	}
	DKClose("DKSolutionMenu.js");
}

/////////////////////////////////////
function DKSolutionMenu_SetFile(file)
{
	DKLog("DKSolutionMenu_SetFile("+file+")\n", DKINFO);
	DKSolutionMenu_file = file;
}

////////////////////////////////
function DKSolutionMenu_Rename()
{
	//TODO
	DKLog("DKSolutionMenu_Rename() \n", DKINFO);
}

////////////////////////////////
function DKSolutionMenu_Delete()
{
	//TODO
	DKLog("DKSolutionMenu_Delete() \n", DKINFO);
}

//////////////////////////////
function DKSolutionMenu_Copy()
{
	//TODO
	DKLog("DKSolutionMenu_Copy() \n", DKINFO);
}

/////////////////////////////
function DKSolutionMenu_Cut()
{
	//TODO
	DKLog("DKSolutionMenu_Cut() \n", DKINFO);
}

///////////////////////////////
function DKSolutionMenu_Paste()
{
	//TODO
	DKLog("DKSolutionMenu_Paste() \n", DKINFO);
}