var currentFile;

/////////////////////////
function DKNotepad_Init()
{
	DKCreate("DKNotepad/DKNotepad.html");
	//DKAddEvent("DKNotepad.html", "SetFile", DKNotepad_OnEvent);
	DKAddEvent("DKNotepad_Text", "contextmenu", DKNotepad_OnEvent);
	DKAddEvent("DKNotepad_File", "click", DKNotepad_OnEvent);
}

////////////////////////
function DKNotepad_End()
{
	DKLog("DKNotepad_End() \n");
	
	DKRemoveEvents(DKNotepad_OnEvent);
	DKClose("DKNotepad/DKNotepad.html");
}

/////////////////////////////////
function DKNotepad_OnEvent(event)
{
	DKLog("DKNotepad_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "contextmenu")){
		DKCreate("DKNotepad/DKNotepadMenu.js", function(){
			DKCreate("DKFrame/DKMenu.js", function(){
				DKMenu_ValidatePosition("DKNotepad/DKNotepadMenu.html");
			});
		});
	}
	//if(DK_Type(event,"SetFile")){
	//	DKNotepad_Open(DK_GetValue(event));
	//}
	if(DK_Id(event,"DKNotepad_File")){
		DKCreate("DKNotepad/DKNotepadFile.js", function(){});
	}
}

/////////////////////////////
function DKNotepad_Open(file)
{
	//TODO - only open files under 5mb
	
	//DKLog("DKNotepad_Open("+file+") \n");
	
	currentFile = file;
	//var assets = DKAssets_LocalAssets();
	var text = DKFile_FileToString(file);
	//DKLog("DKNotepad_Open("+file+"): text="+text+" \n");
	DKWidget_SetAttribute("DKNotepad_Text", "value", text);
}
