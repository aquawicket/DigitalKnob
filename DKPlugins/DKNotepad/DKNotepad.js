var currentFile;

/////////////////////////
function DKNotepad_Init()
{
	DKCreate("DKNotepad/DKNotepad.html");
	//DKAddEvent("DKNotepad.html", "SetFile", DKNotepad_OnEvent);
	DKAddEvent("DKNotepad_Save", "click", DKNotepad_OnEvent);
	DKAddEvent("DKNotepad_Text", "contextmenu", DKNotepad_OnEvent);
	DKAddEvent("DKNotepad_File", "click", DKNotepad_OnEvent);
}

////////////////////////
function DKNotepad_End()
{
	DKClose("DKNotepad/DKNotepad.html");
}

///////////////////////////////
function DKNotepad_OnEvent(event)
{
	if(DK_Id(event,"DKNotepad_Save")){
		DKNotepad_Save();
	}
	if(DK_Type(event, "contextmenu")){
		DKCreate("DKNotepad/DKNotepadMenu.js");
	}
	//if(DK_Type(event,"SetFile")){
	//	DKNotepad_Open(DKWidget_GetValue(event));
	//}
	if(DK_Id(event,"DKNotepad_File")){
		DKCreate("DKNotepad/DKNotepadFile.js");
	}
}

/////////////////////////
function DKNotepad_Save()
{
	var text = DKWidget_GetValue("DKNotepad_Text");
	var assets = DKAssets_LocalAssets();
	DKFile_StringToFile(text, assets+currentFile);
	DKCreate("DKMessage/DKMessage.js");
	DKMessageBox("", "ShowMessage", "Saved File");
}

/////////////////////////////
function DKNotepad_Open(file)
{
	//TODO - only open files under 5mb
	
	//DKLog("DKNotepad_Open("+file+") \n");
	
	currentFile = file;
	var assets = DKAssets_LocalAssets();
	var text = DKFile_FileToString(assets+file);
	//DKLog("DKNotepad_Open("+file+"): text="+text+" \n");
	DKWidget_SetAttribute("DKNotepad_Text", "value", text);
}
