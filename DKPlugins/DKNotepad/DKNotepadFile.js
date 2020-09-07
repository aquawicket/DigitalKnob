/////////////////////////////
function DKNotepadFile_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKNotepad/DKNotepadFile.html,DKNotepad/DKNotepad.html");
	DKAddEvent("window", "mousedown", DKNotepadFile_OnEvent);
	DKAddEvent("DKNotepadFile_New", "click", DKNotepadFile_OnEvent);
	DKAddEvent("DKNotepadFile_Open", "click", DKNotepadFile_OnEvent);
	DKAddEvent("DKNotepadFile_Save", "click", DKNotepadFile_OnEvent);
	DKAddEvent("DKNotepadFile_SaveAs", "click", DKNotepadFile_OnEvent);
	DKAddEvent("DKNotepadFile_Print", "click", DKNotepadFile_OnEvent);
	DKAddEvent("DKNotepadFile_Exit", "click", DKNotepadFile_OnEvent);
}

////////////////////////////
function DKNotepadFile_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKNotepadFile_OnEvent);
	DKClose("DKNotepad/DKNotepadFile.html");
}

/////////////////////////////////////
function DKNotepadFile_OnEvent(event)
{
	DKDEBUGFUNC(event);
	DKWARN("DKNotepadFile_OnEvent(event)");
	if(DK_Id(event,"DKNotepadFile_New")){
		DKNotepadFile_New();
	}
	if(DK_Id(event,"DKNotepadFile_Open")){
		DKNotepadFile_Open();
	}
	if(DK_Id(event,"DKNotepadFile_Save")){
		DKNotepadFile_Save();
	}
	if(DK_Id(event,"DKNotepadFile_SaveAs")){
		DKNotepadFile_SaveAs();
	}
	if(DK_Id(event,"DKNotepadFile_Print")){
		DKNotepadFile_Print();
	}
	if(DK_Id(event,"DKNotepadFile_Exit")){
		DKClose("DKNotepad/DKNotepadFile.js");
		DKFrame_Close("DKNotepad/DKNotepad.html");
	}
	
	if(DK_Id(event, "window")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepad/DKNotepadFile.html")){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadFile.js");
}

/////////////////////////////
function DKNotepadFile_New()
{
	DKDEBUGFUNC();
	document.getElementById("DKNotepad_Text").value = "";
	currentFile = "";
}

/////////////////////////////
function DKNotepadFile_Open()
{
	DKDEBUGFUNC();
	DKCreate("DKFile/DKOpenFile.js", function(){
		DKFrame_Widget("DKFile/DKOpenFile.html");
		DKSendEvent("DKFile/DKOpenFile.html", "GetFile", "DKNotepad/DKNotepad.html,OpenFile,/,absolute"); // To -> DKOpenFile
	});
}

/////////////////////////////
function DKNotepadFile_Save()
{
	DKDEBUGFUNC();
	if(!currentFile){
		DKNotepadFile_SaveAs();
		return;
	}
	var text = DKWidget_GetValue("DKNotepad_Text");
	//var assets = DKAssets_LocalAssets();
	console.log("DKNotepadFile_Save(): text = "+text);
	DKFile_StringToFile(text, currentFile);
	DKCreate("DKMessage/DKMessage.js", function(){
		DKFrame_Widget("DKMessage/DKMessage.html");
		DKMessageBox_Message("File Saved");
	});
}

///////////////////////////////
function DKNotepadFile_SaveAs()
{
	DKDEBUGFUNC();
	DKCreate("DKFile/DKSaveFile.js", function(){
		DKFrame_Widget("DKFile/DKSaveFile.html");
		DKSendEvent("DKFile/DKSaveFile.html", "SetFile", "DKNotepad/DKNotepad.html,SaveFile,/,absolute"); // To -> DKFileDialog
	});
}

//////////////////////////////
function DKNotepadFile_Print()
{
	DKDEBUGFUNC();
	DKCef_Print(0);
}

/////////////////////////////////////
function DKNotepadFile_CheckForSave()
{
	DKDEBUGFUNC();
	DKINFO("TODO\n");
}