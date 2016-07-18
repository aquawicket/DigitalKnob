
//////////////////////////////
function DKDev_RootMenu_Init()
{
	DKCreate("DKDev/DKDev_RootMenu.html");
	DKAddEvent("DKDev_RootMenu_NewFrame", "click", DKDev_RootMenu_OnEvent);
	DKAddEvent("DKDev_RootMenu_OpenFile", "click", DKDev_RootMenu_OnEvent);
}

/////////////////////////////
function DKDev_RootMenu_End()
{
	DKClose("DKDev/DKDev_RootMenu.html");
}

/////////////////////////////////
function DKDev_RootMenu_OnEvent()
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
}