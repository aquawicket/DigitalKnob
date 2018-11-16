/////////////////////////////
function DKNotepadFormat_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKNotepad/DKNotepadFormat.html,DKNotepad/DKNotepad.html");
	DKAddEvent("window", "mousedown", DKNotepadFormat_OnEvent);
	DKAddEvent("DKNotepadFormat_WordWrap", "click", DKNotepadFormat_OnEvent);
	DKAddEvent("DKNotepadFormat_Font", "click", DKNotepadFormat_OnEvent);
}

//////////////////////////////
function DKNotepadFormat_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKNotepadFormat_OnEvent);
	DKClose("DKNotepad/DKNotepadFormat.html");
}

///////////////////////////////////////
function DKNotepadFormat_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(DK_Id(event,"DKNotepadFormat_WordWrap")){
		DKNotepadFormat_WordWrap();
	}
	if(DK_Id(event,"DKNotepadFormat_Font")){
		DKINFO(("DKNotepadFormat_Font\n");
	}
	
	if(DK_Id(event, "window")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepad/DKNotepadFormat.html")){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadFormat.js");
}

///////////////////////////////////
function DKNotepadFormat_WordWrap()
{
	DKDEBUGFUNC();
	if(DKWidget_GetProperty("DKNotepad_Text","white-space") == ""){
		DKWidget_SetProperty("DKNotepad_Text","white-space","nowrap");
	}
	else{
		DKWidget_RemoveProperty("DKNotepad_Text","white-space");
	}
}