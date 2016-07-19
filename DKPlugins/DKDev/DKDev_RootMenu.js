
//////////////////////////////
function DKDev_RootMenu_Init()
{
	DKCreate("DKDev/DKDev_RootMenu.html");
	DKWidget_SetProperty("DKDev_RootMenu.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("DKDev_RootMenu.html","left",DKWindow_GetMouseX()+"px");
	DKAddEvent("GLOBAL", "mousedown", DKDev_RootMenu_OnEvent);
	DKAddEvent("DKDev_RootMenu_NewFrame", "click", DKDev_RootMenu_OnEvent);
	DKAddEvent("DKDev_RootMenu_OpenFile", "click", DKDev_RootMenu_OnEvent);
}

/////////////////////////////
function DKDev_RootMenu_End()
{
	DKClose("DKDev/DKDev_RootMenu.html");
}

//////////////////////////////////////
function DKDev_RootMenu_OnEvent(event)
{
	if(DK_Id(event, "DKDev_RootMenu_NewFrame")){
		DKDev_NewPage(stored_element);
		return;
	}
	if(DK_Id(event, "DKDev_RootMenu_OpenFile")){
		DKCreate("DKFile/DKFileDialog.js");
		DKFrame_Widget("DKFileDialog.html");
		DKSendEvent("DKFileDialog.html", "GetFile", "GLOBAL,OpenFile,/,relative"); // To -> DKFileDialog
		return;
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKDev_RootMenu.html")){
			return;
		}
	}
	DKClose("DKDev/DKDev_RootMenu.js");
}