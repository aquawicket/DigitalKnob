/////////////////////////////
function DKNotepadFile_Init()
{
	DKCreate("DKNotepad/DKNotepadFile.html,DKNotepad/DKNotepad.html");
	document.addEventListener("mousedown", DKNotepadFile_OnEvent);
	byId("DKNotepadFile_New").addEventListener("click", DKNotepadFile_OnEvent);
	byId("DKNotepadFile_Open").addEventListener("click", DKNotepadFile_OnEvent);
	byId("DKNotepadFile_Save").addEventListener("click", DKNotepadFile_OnEvent);
	byId("DKNotepadFile_SaveAs").addEventListener("click", DKNotepadFile_OnEvent);
	byId("DKNotepadFile_Print").addEventListener("click", DKNotepadFile_OnEvent);
	byId("DKNotepadFile_Exit").addEventListener("click", DKNotepadFile_OnEvent);
}

////////////////////////////
function DKNotepadFile_End()
{
	document.removeEventListener("mousedown", DKNotepadFile_OnEvent);
	byId("DKNotepadFile_New").removeEventListener("click", DKNotepadFile_OnEvent); //FIXME:   DKNotepadFile_New undefined
	byId("DKNotepadFile_Open").removeEventListener("click", DKNotepadFile_OnEvent);
	byId("DKNotepadFile_Save").removeEventListener("click", DKNotepadFile_OnEvent);
	byId("DKNotepadFile_SaveAs").removeEventListener("click", DKNotepadFile_OnEvent);
	byId("DKNotepadFile_Print").removeEventListener("click", DKNotepadFile_OnEvent);
	byId("DKNotepadFile_Exit").removeEventListener("click", DKNotepadFile_OnEvent);
	DKClose("DKNotepad/DKNotepadFile.html");
}

/////////////////////////////////////
function DKNotepadFile_OnEvent(event)
{
	//console.warn("DKNotepadFile_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")");
	if(event.currentTarget.id === "DKNotepadFile_New"){
		DKNotepadFile_New();
	}
	if(event.currentTarget.id === "DKNotepadFile_Open"){
		DKNotepadFile_Open();
	}
	if(event.currentTarget.id === "DKNotepadFile_Save"){
		DKNotepadFile_Save();
	}
	if(event.currentTarget.id === "DKNotepadFile_SaveAs"){
		DKNotepadFile_SaveAs();
	}
	if(event.currentTarget.id === "DKNotepadFile_Print"){
		DKNotepadFile_Print();
	}
	if(event.currentTarget.id === "DKNotepadFile_Exit"){
		DKClose("DKNotepad/DKNotepadFile.js");
		DKFrame_Close("DKNotepad/DKNotepad.html");
	}
	
	//FIXME
	if(event.currentTarget === document){
		if(byId("DKNotepad/DKNotepadFile.html").contains(DKWidget_GetHoverElement())){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadFile.js");
}

/////////////////////////////
function DKNotepadFile_New()
{
	byId("DKNotepad_Text").value = "";
	currentFile = "";
}

/////////////////////////////
function DKNotepadFile_Open()
{
	DKCreate("DKFile/DKOpenFile.js", function(){
		DKFrame_Widget("DKFile/DKOpenFile.html");
		DKOpenFile_UpdatePath("/");
		//DKSendEvent("DKFile/DKOpenFile.html", "GetFile", "DKNotepad/DKNotepad.html,OpenFile,/,absolute"); // To -> DKOpenFile
	});
}

/////////////////////////////
function DKNotepadFile_Save()
{
	if(!currentFile){
		DKNotepadFile_SaveAs();
		return;
	}
	var text = DKWidget_GetValue("DKNotepad_Text");
	//var assets = DKAssets_LocalAssets();
	//console.log("DKNotepadFile_Save(): text = "+text);
	DKFile_StringToFile(text, currentFile);
	DKCreate("DKMessage/DKMessage.js", function(){
		DKFrame_Widget("DKMessage/DKMessage.html");
		DKMessage_Message("File Saved");
	});
}

///////////////////////////////
function DKNotepadFile_SaveAs()
{
	DKCreate("DKFile/DKSaveFile.js", function(){
		DKFrame_Widget("DKFile/DKSaveFile.html");
		
		var event = new Object("SetFile");
		//var event = new Event("SetFile"); //FIXME
		event.currentTarget = byId("DKFile/DKSaveFile.html");
		event.type = "SetFile";
		event.value = "DKNotepad/DKNotepad.html,SaveFile,/,absolute";
		window.addEventListener("SetFile", function(){ console.log("Creating events is working!") }, false);
		window.dispatchEvent(event);
		byId("DKFile/DKSaveFile.html").dispatchEvent(event);
		
		//DKSendEvent("DKFile/DKSaveFile.html", "SetFile", "DKNotepad/DKNotepad.html,SaveFile,/,absolute"); // To -> DKFileDialog
	});
}

//////////////////////////////
function DKNotepadFile_Print()
{
	DKCPP_DKCef_Print(0);
}

/////////////////////////////////////
function DKNotepadFile_CheckForSave()
{
	console.log("TODO\n");
}