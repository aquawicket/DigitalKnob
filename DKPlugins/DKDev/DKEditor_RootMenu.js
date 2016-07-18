
////////////////////////////////
function DKEditor_RootMenu_Init()
{
	DKCreate("DKDev/DKEditor_RootMenu.html");
	DKAddEvent("DKEditor_RootMenu_NewFrame", "click", DKEditor_RootMenu_OnEvent);
	DKAddEvent("DKEditor_RootMenu_OpenFile", "click", DKEditor_RootMenu_OnEvent);
}

////////////////////////////////
function DKEditor_RootMenu_End()
{
	DKClose("DKDev/DKEditor_RootMenu.html");
}

////////////////////////////////////
function DKEditor_RootMenu_OnEvent()
{
	if(DK_Id(event, "DKEditor_RootMenu_NewFrame")){
		DKEditor_NewPage(stored_element);
		return;
	}
	if(DK_Id(event, "DKEditor_RootMenu_OpenFile")){
		DKCreate("DKFile/DKFileDialog.js");
		DKFrame_Widget("DKFileDialog.html");
		DKSendEvent("DKFileDialog.html", "GetFile", "GLOBAL,OpenFile,/,relative"); // To -> DKFileDialog
		return;
	}
}