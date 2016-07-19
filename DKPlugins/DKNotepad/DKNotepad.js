var currentFile;

/////////////////////////
function DKNotepad_Init()
{
	DKCreate("DKNotepad/DKNotepad.html");
	DKAddEvent("DKNotepad.html", "SetFile", DKNotepad_OnEvent);
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
	if(DK_Type(event,"SetFile")){
		DKNotepad_LoadFile(DKWidget_GetValue(event));
	}
	if(DK_Id(event,"DKNotepad_File")){
		DKCreate("DKNotepad/DKNotepadFile.js");
	}
}

/////////////////////////
function DKNotepad_Save()
{
	var text = DKWidget_GetValue("DKNotepad_Text");
	//var local_assets = DKAssets_GetDataPath();
	DKFile_StringToFile(text, currentFile);
	DKCreate("DKMessage/DKMessage.js");
	DKMessageBox("", "ShowMessage", "Saved File");
}

/////////////////////////////////
function DKNotepad_LoadFile(file)
{
	DKLog("DKNotepad_LoadFile("+file+") \n");
	//TODO - only open files under 5mb
	currentFile = file;
	//var loacl_assets = DKAssets_GetDataPath();
	var text = DKFile_FileToString(file);
	DKLog("DKNotepad_LoadFile("+file+"): text="+text+" \n");
	DKWidget_SetAttribute("DKNotepad_Text", "value", text);
}
