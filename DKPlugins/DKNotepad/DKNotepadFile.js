/////////////////////////////
function DKNotepadFile_Init()
{
	DKCreate("DKNotepad/DKNotepadFile.html,DKNotepad.html");
	DKAddEvent("GLOBAL", "mousedown", DKNotepadFile_OnEvent);
	DKAddEvent("DKNotepadFile_Open", "click", DKNotepadFile_OnEvent);
	DKAddEvent("DKNotepadFile_Save", "click", DKNotepadFile_OnEvent);
	DKAddEvent("DKNotepadFile_Save As", "click", DKNotepadFile_OnEvent);
}

////////////////////////////
function DKNotepadFile_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKNotepadFile_OnEvent);
	DKClose("DKNotepad/DKNotepadFile.html");
}

/////////////////////////////////////
function DKNotepadFile_OnEvent(event)
{
	if(DK_Id(event,"DKNotepadFile_Open")){
		DKNotepadFile_Open();
	}
	if(DK_Id(event,"DKNotepadFile_Save")){
		DKNotepadFile_Save();
	}
	if(DK_Id(event,"DKNotepadFile_Save As")){
		DKNotepadFile_SaveAs();
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepadFile.html")){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadFile.js");
}

/////////////////////////////
function DKNotepadFile_Open()
{
	DKLog("DKNotepadFile_Open \n", DKDEBUG);
	DKCreate("DKFile/DKFileDialog.js");
	DKFrame_Widget("DKFileDialog.html");
	DKSendEvent("DKFileDialog.html", "GetFile", "GLOBAL,OpenFile,/,relative"); // To -> DKFileDialog
}

/////////////////////////////
function DKNotepadFile_Save()
{
	DKLog("DKNotepadFile_Save \n", DKDEBUG);
	var text = DKWidget_GetValue("DKNotepad_Text");
	//var assets = DKAssets_LocalAssets();
	DKFile_StringToFile(text, currentFile);
	DKCreate("DKMessage/DKMessage.js", function(){
		DKFrame_Widget("DKMessage.html");
		DKMessageBox("", "ShowMessage", "Saved File");
	});
}

//////////////////////////////
function DKNotepadFile_SaveAs()
{
	DKLog("DKNotepadFile_SaveAs \n", DKDEBUG);
}