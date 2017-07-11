/////////////////////////////
function DKNotepadFile_Init()
{
	//DKLog("DKNotepadFile_Init()\n");
	
	DKCreate("DKNotepad/DKNotepadFile.html,DKNotepad/DKNotepad.html");
	DKAddEvent("GLOBAL", "mousedown", DKNotepadFile_OnEvent);
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
	//DKLog("DKNotepadFile_End()\n");
	
	DKRemoveEvents(DKNotepadFile_OnEvent);
	DKClose("DKNotepad/DKNotepadFile.html");
}

/////////////////////////////////////
function DKNotepadFile_OnEvent(event)
{
	//DKLog("DKNotepadFile_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
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
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepad/DKNotepadFile.html")){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadFile.js");
}

/////////////////////////////
function DKNotepadFile_New()
{
	//DKLog("DKNotepadFile_New()\n");
	
	DKWidget_SetAttribute("DKNotepad_Text", "value", "");
	currentFile = "";
}

/////////////////////////////
function DKNotepadFile_Open()
{
	//DKLog("DKNotepadFile_Open()\n");
	
	DKCreate("DKFile/DKOpenFile.js", function(){
		DKFrame_Widget("DKFile/DKOpenFile.html");
		DKSendEvent("DKFile/DKOpenFile.html", "GetFile", "GLOBAL,OpenFile,/,relative"); // To -> DKOpenFile
	});
}

/////////////////////////////
function DKNotepadFile_Save()
{
	//DKLog("DKNotepadFile_Save()\n");
	
	if(!currentFile){
		DKNotepadFile_SaveAs();
		return;
	}
	var text = DKWidget_GetValue("DKNotepad_Text");
	//var assets = DKAssets_LocalAssets();
	DKFile_StringToFile(text, currentFile);
	DKCreate("DKMessage/DKMessage.js", function(){
		DKFrame_Widget("DKMessage/DKMessage.html");
		DKMessageBox_Message("File Saved");
	});
}

///////////////////////////////
function DKNotepadFile_SaveAs()
{
	//DKLog("DKNotepadFile_SaveAs()\n");
	
	DKCreate("DKFile/DKFileDialog.js", function(){
		DKFrame_Widget("DKFile/DKFileDialog.html");
		DKSendEvent("DKFile/DKFileDialog.html", "GetFile", "GLOBAL,SaveFile,/,relative"); // To -> DKFileDialog
	});
}

//////////////////////////////
function DKNotepadFile_Print()
{
	DKLog("DKNotepadFile_Print()\n");
	
	DKLog("TODO\n");
}

/////////////////////////////////////
function DKNotepadFile_CheckForSave()
{
	DKLog("DKNotepadFile_CheckForSave()\n");
	
	DKLog("TODO\n");
}