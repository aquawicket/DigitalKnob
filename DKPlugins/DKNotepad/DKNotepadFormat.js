/////////////////////////////
function DKNotepadFormat_Init()
{
	//DKLog("DKNotepadFormat_Init()\n");
	
	DKCreate("DKNotepad/DKNotepadFormat.html,DKNotepad/DKNotepad.html");
	DKAddEvent("GLOBAL", "mousedown", DKNotepadFormat_OnEvent);
	DKAddEvent("DKNotepadFormat_WordWrap", "click", DKNotepadFormat_OnEvent);
	DKAddEvent("DKNotepadFormat_Font", "click", DKNotepadFormat_OnEvent);
}

////////////////////////////
function DKNotepadFormat_End()
{
	//DKLog("DKNotepadFormat_End()\n");
	
	DKRemoveEvents(DKNotepadFormat_OnEvent);
	DKClose("DKNotepad/DKNotepadFormat.html");
}

/////////////////////////////////////
function DKNotepadFormat_OnEvent(event)
{
	//DKLog("DKNotepadFormat_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event,"DKNotepadFormat_WordWrap")){
		DKLog("DKNotepadFormat_WordWrap\n");
	}
	if(DK_Id(event,"DKNotepadFormat_Font")){
		DKLog("DKNotepadFormat_Font\n");
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepad/DKNotepadFormat.html")){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadFormat.js");
}