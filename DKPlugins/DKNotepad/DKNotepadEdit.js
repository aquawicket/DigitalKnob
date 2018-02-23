/////////////////////////////
function DKNotepadEdit_Init()
{
	//DKLog("DKNotepadEdit_Init()\n");
	
	DKCreate("DKNotepad/DKNotepadEdit.html");
	DKWidget_AppendChild("DKNotepad/DKNotepad.html", "DKNotepad/DKNotepadEdit.html");
	DKAddEvent("GLOBAL", "mousedown", DKNotepadEdit_OnEvent);
	DKAddEvent("DKNotepadEdit_Undo", "click", DKNotepadEdit_OnEvent);
	DKAddEvent("DKNotepadEdit_Cut", "click", DKNotepadEdit_OnEvent);
	DKAddEvent("DKNotepadEdit_Copy", "click", DKNotepadEdit_OnEvent);
	DKAddEvent("DKNotepadEdit_Paste", "click", DKNotepadEdit_OnEvent);
	DKAddEvent("DKNotepadEdit_Delete", "click", DKNotepadEdit_OnEvent);
	DKAddEvent("DKNotepadEdit_Find", "click", DKNotepadEdit_OnEvent);
}

////////////////////////////
function DKNotepadEdit_End()
{
	//DKLog("DKNotepadEdit_End()\n");
	
	DKRemoveEvents(DKNotepadEdit_OnEvent);
	DKClose("DKNotepad/DKNotepadEdit.html");
}

/////////////////////////////////////
function DKNotepadEdit_OnEvent(event)
{
	//DKLog("DKNotepadEdit_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event,"DKNotepadEdit_Undo")){
		DKLog("DKNotepadEdit_Undo\n");
	}
	if(DK_Id(event,"DKNotepadEdit_Cut")){
		DKLog("DKNotepadEdit_Cut\n");
	}
	if(DK_Id(event,"DKNotepadEdit_Copy")){
		DKLog("DKNotepadEdit_Copy\n");
	}
	if(DK_Id(event,"DKNotepadEdit_Paste")){
		DKLog("DKNotepadEdit_Paste\n");
	}
	if(DK_Id(event,"DKNotepadEdit_Delete")){
		DKLog("DKNotepadEdit_Delete\n");
	}
	if(DK_Id(event,"DKNotepadEdit_Find")){
		DKLog("DKNotepadEdit_Find\n");
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepad/DKNotepadEdit.html")){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadEdit.js");
}