/////////////////////////////
function DKNotepadEdit_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKNotepad/DKNotepadEdit.html,DKNotepad/DKNotepad.html");
	DKAddEvent("window", "mousedown", DKNotepadEdit_OnEvent);
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
	DKDEBUGFUNC();
	DKRemoveEvents(DKNotepadEdit_OnEvent);
	DKClose("DKNotepad/DKNotepadEdit.html");
}

/////////////////////////////////////
function DKNotepadEdit_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(DK_Id(event,"DKNotepadEdit_Undo")){
		DKINFO(("DKNotepadEdit_Undo\n");
	}
	if(DK_Id(event,"DKNotepadEdit_Cut")){
		DKINFO(("DKNotepadEdit_Cut\n");
	}
	if(DK_Id(event,"DKNotepadEdit_Copy")){
		DKINFO(("DKNotepadEdit_Copy\n");
	}
	if(DK_Id(event,"DKNotepadEdit_Paste")){
		DKINFO(("DKNotepadEdit_Paste\n");
	}
	if(DK_Id(event,"DKNotepadEdit_Delete")){
		DKINFO(("DKNotepadEdit_Delete\n");
	}
	if(DK_Id(event,"DKNotepadEdit_Find")){
		DKINFO(("DKNotepadEdit_Find\n");
	}
	
	if(DK_Id(event, "window")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepad/DKNotepadEdit.html")){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadEdit.js");
}