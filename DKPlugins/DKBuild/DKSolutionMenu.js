//////////////////////////////
function DKSolutionMenu_Init()
{
	DKCreate("DKBuild/DKSolutionMenu.html");
	DKWidget_SetProperty("DKSolutionMenu.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("DKSolutionMenu.html","left",DKWindow_GetMouseX()+"px");
	DKAddEvent("GLOBAL", "mousedown", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_1", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_2", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_3", "click", DKSolutionMenu_OnEvent);
}

/////////////////////////////
function DKSolutionMenu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_1", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_2", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_3", "click", DKSolutionMenu_OnEvent);
	DKClose("DKSolutionMenu.html");
}

//////////////////////////////////////
function DKSolutionMenu_OnEvent(event)
{
	DKLog("DKSolutionMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event,"DKSolutionMenu_1")){
		DKSolutionMenu_1();
	}
	if(DK_Id(event,"DKSolutionMenu_2")){
		DKSolutionMenu_2();
	}
	if(DK_Id(event,"DKSolutionMenu_3")){
		DKSolutionMenu_3();
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKSolutionMenu.html")){
			return;
		}
	}
	DKClose("DKSolutionMenu.js");
}

///////////////////////////
function DKSolutionMenu_1()
{
	//TODO
	DKLog("DKSolutionMenu_1() \n", DKINFO);
}

///////////////////////////
function DKSolutionMenu_2()
{
	//TODO
	DKLog("DKSolutionMenu_2() \n", DKINFO);
}

///////////////////////////
function DKSolutionMenu_3()
{
	//TODO
	DKLog("DKSolutionMenu_3() \n", DKINFO);
}