/////////////////////////////
function DKNotepadFile_Init()
{
	DKCreate("DKNotepad/DKNotepadFile.html,DKNotepad.html");
	DKAddEvent("GLOBAL", "mousedown", DKNotepadFile_OnEvent);
	DKAddEvent("GLOBAL", "OpenFile", DKNotepadFile_OnEvent);
	DKAddEvent("DKNotepadFile_Open", "click", DKNotepadFile_OnEvent);
	DKAddEvent("DKNotepadFile_Save", "click", DKNotepadFile_OnEvent);
	DKAddEvent("DKNotepadFile_Save As", "click", DKNotepadFile_OnEvent);
	DKAddEvent("DKNotepadFile_Exit", "click", DKNotepadFile_OnEvent);
}

////////////////////////////
function DKNotepadFile_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKNotepadFile_OnEvent);
	DKRemoveEvent("GLOBAL", "OpenFile", DKNotepadFile_OnEvent);
	DKRemoveEvent("DKNotepadFile_Open", "click", DKNotepadFile_OnEvent);
	DKRemoveEvent("DKNotepadFile_Save", "click", DKNotepadFile_OnEvent);
	DKRemoveEvent("DKNotepadFile_Save As", "click", DKNotepadFile_OnEvent);
	DKRemoveEvent("DKNotepadFile_Exit", "click", DKNotepadFile_OnEvent);
	DKClose("DKNotepadFile.html");
}

/////////////////////////////////////
function DKNotepadFile_OnEvent(event)
{
	DKLog("DKNotepadFile_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event,"DKNotepadFile_Open")){
		DKNotepadFile_Open();
	}
	if(DK_Type(event, "OpenFile")){
		var file = DKWidget_GetValue(event);
		DKLog("OpenFile: "+file+" \n", DKDEBUG)
		DKNotepad_Open(file)
	}
	if(DK_Id(event,"DKNotepadFile_Save")){
		DKNotepadFile_Save();
	}
	if(DK_Id(event,"DKNotepadFile_Save As")){
		DKNotepadFile_SaveAs();
	}
	if(DK_Id(event,"DKNotepadFile_Exit")){
		DKFrame_Close("DKNotepad.html");
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepadFile.html")){
			return;
		}
	}
	DKClose("DKNotepadFile.js");
}

/////////////////////////////
function DKNotepadFile_Open()
{
	DKLog("DKNotepadFile_Open \n", DKDEBUG);
	DKCreate("DKFile/DKFileDialog.js", function(){
		DKFrame_Widget("DKFileDialog.html");
		DKSendEvent("DKFileDialog.html", "GetFile", "GLOBAL,OpenFile,/,relative"); // To -> DKFileDialog
	});
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
	DKCreate("DKFile/DKFileDialog.js", function(){
		DKFrame_Widget("DKFileDialog.html");
		//DKSendEvent("DKFileDialog.html", "SetFile", "GLOBAL,OpenFile,/,relative"); // To -> DKFileDialog
	});
}