var currentFile;

/////////////////////////
function DKNotepad_Init()
{
	//DKLog("DKNotepad_Init() \n");
	
	DKCreate("DKNotepad/DKNotepad.css");
	DKCreate("DKNotepad/DKNotepad.html");
	//DKAddEvent("DKNotepad.html", "SetFile", DKNotepad_OnEvent);
	DKAddEvent("GLOBAL", "OpenFile", DKNotepad_OnEvent);
	DKAddEvent("DKNotepad_Text", "contextmenu", DKNotepad_OnEvent);
	DKAddEvent("DKNotepad_File", "click", DKNotepad_OnEvent);
	DKAddEvent("DKNotepad_Edit", "click", DKNotepad_OnEvent);
	DKAddEvent("DKNotepad_Format", "click", DKNotepad_OnEvent);
	DKAddEvent("DKNotepad_View", "click", DKNotepad_OnEvent);
	DKAddEvent("DKNotepad_Help", "click", DKNotepad_OnEvent);
}

////////////////////////
function DKNotepad_End()
{
	//DKLog("DKNotepad_End() \n");
	
	DKRemoveEvents(DKNotepad_OnEvent);
	DKClose("DKNotepad/DKNotepad.html");
	DKClose("DKNotepad/DKNotepad.css");
}

/////////////////////////////////
function DKNotepad_OnEvent(event)
{
	//DKLog("DKNotepad_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "contextmenu")){
		DKCreate("DKNotepad/DKNotepadMenu.js", function(){
			DKMenu_ValidatePosition("DKNotepad/DKNotepadMenu.html");
		});
	}
	//if(DK_Type(event,"SetFile")){
	//	DKNotepad_Open(DK_GetValue(event));
	//}
	if(DK_Id(event,"DKNotepad_File")){
		DKCreate("DKNotepad/DKNotepadFile.js", function(){});
	}
	if(DK_Id(event,"DKNotepad_Edit")){
		DKCreate("DKNotepad/DKNotepadEdit.js", function(){});
	}
	if(DK_Id(event,"DKNotepad_Format")){
		DKCreate("DKNotepad/DKNotepadFormat.js", function(){});
	}
	if(DK_Id(event,"DKNotepad_View")){
		DKCreate("DKNotepad/DKNotepadView.js", function(){});
	}
	if(DK_Id(event,"DKNotepad_Help")){
		DKCreate("DKNotepad/DKNotepadHelp.js", function(){});
	}
	if(DK_Type(event, "OpenFile")){
		var file = DK_GetValue(event);
		DKLog("OpenFile: "+file+" \n", DKDEBUG)
		DKNotepad_Open(file)
	}
}

/////////////////////////////
function DKNotepad_Open(file)
{
	//DKLog("DKNotepad_Open("+file+")\n");
	
	//TODO - only open files under 5mb
	//TODO - set the frame title with the filename
	currentFile = file;
	var text = DKFile_FileToString(file);
	DKWidget_SetAttribute("DKNotepad_Text", "value", text);
}