var currentFile;

/////////////////////////
function DKNotepad_Init()
{
	//DKWARN("DKNotepad_Init()");
	DKDEBUGFUNC();
	DKCreate("DKNotepad/DKNotepad.css");
	DKCreate("DKNotepad/DKNotepad.html");
	//DKAddEvent("DKNotepad.html", "SetFile", DKNotepad_OnEvent);
	//DKAddEvent("DKNotepad/DKNotepad.html", "OpenFile", DKNotepad_OnEvent);
	byId("DKNotepad/DKNotepad.html").addEventListener("OpenFile", DKNotepad_OnEvent);
	//DKAddEvent("DKNotepad/DKNotepad.html", "SaveFile", DKNotepad_OnEvent);
	byId("DKNotepad/DKNotepad.html").addEventListener("SaveFile", DKNotepad_OnEvent);
	//DKAddEvent("DKNotepad_Text", "contextmenu", DKNotepad_OnEvent);
	byId("DKNotepad_Text").addEventListener("contextmenu", DKNotepad_OnEvent);
	//DKAddEvent("DKNotepad_File", "click", DKNotepad_OnEvent);
	byId("DKNotepad_File").addEventListener("click", DKNotepad_OnEvent);
	//DKAddEvent("DKNotepad_Edit", "click", DKNotepad_OnEvent);
	byId("DKNotepad_Edit").addEventListener("click", DKNotepad_OnEvent);
	//DKAddEvent("DKNotepad_Format", "click", DKNotepad_OnEvent);
	byId("DKNotepad_Format").addEventListener("click", DKNotepad_OnEvent);
	//DKAddEvent("DKNotepad_View", "click", DKNotepad_OnEvent);
	byId("DKNotepad_View").addEventListener("click", DKNotepad_OnEvent);
	//DKAddEvent("DKNotepad_Help", "click", DKNotepad_OnEvent);
	byId("DKNotepad_Help").addEventListener("click", DKNotepad_OnEvent);
}

////////////////////////
function DKNotepad_End()
{
	DKDEBUGFUNC();
	//DKRemoveEvents(DKNotepad_OnEvent);
	DKClose("DKNotepad/DKNotepad.html");
	DKClose("DKNotepad/DKNotepad.css");
}

/////////////////////////////////
function DKNotepad_OnEvent(event)
{
	DKDEBUGFUNC(event);
	//DKWARN("DKNotepad_OnEvent("+event.type+","+event.currentTarget.id+")");
	
	if(event.type == "contextmenu"){
		DKCreate("DKNotepad/DKNotepadMenu.js", function(){
			DKMenu_ValidatePosition("DKNotepad/DKNotepadMenu.html");
		});
	}
	if(event.type == "OpenFile"){
		var file = DK_GetValue(event);
		//console.log("OpenFile: "+file);
		DKNotepad_Open(file)
	}
	if(event.type == "SaveFile"){
		var file = event.value;//DK_GetValue(event);
		//DKINFO(("SaveFile: "+file+"\n");
		DKNotepad_Save(file)
	}
	//if(event.type == "SetFile"){
	//	DKNotepad_Open(DK_GetValue(event));
	//}
	if(!event.currentTarget){ return; }
	if(event.currentTarget.id == "DKNotepad_File"){
		DKCreate("DKNotepad/DKNotepadFile.js", function(){});
	}
	if(event.currentTarget.id == "DKNotepad_Edit"){
		DKCreate("DKNotepad/DKNotepadEdit.js", function(){});
	}
	if(event.currentTarget.id == "DKNotepad_Format"){
		DKCreate("DKNotepad/DKNotepadFormat.js", function(){});
	}
	if(event.currentTarget.id == "DKNotepad_View"){
		DKCreate("DKNotepad/DKNotepadView.js", function(){});
	}
	if(event.currentTarget.id == "DKNotepad_Help"){
		DKCreate("DKNotepad/DKNotepadHelp.js", function(){});
	}
}

/////////////////////////////
function DKNotepad_Open(file)
{
	DKDEBUGFUNC(file);
	//console.log("DKNotepad_Open("+file+")");
	//TODO - only open files under 5mb
	//TODO - set the frame title with the filename
	currentFile = file;
	var text = DKFile_FileToString(file);
	//console.log("DKNotepad_Open(file): = "+text);
	//DKWidget_SetAttribute("DKNotepad_Text", "value", text);
	byId("DKNotepad_Text").value = text;
}

/////////////////////////////
function DKNotepad_Save(file)
{
	DKDEBUGFUNC(file);
	var text = byId("DKNotepad_Text").value;
	//console.log(("DKNotepad_Save("+file+"): text = "+text+"\n");
	DKFile_StringToFile(text, file);
}