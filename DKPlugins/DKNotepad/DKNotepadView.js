/////////////////////////////
function DKNotepadView_Init()
{
	DKLog("DKNotepadView_Init()\n", DKDEBUG);
	DKCreate("DKNotepad/DKNotepadView.html,DKNotepad/DKNotepad.html");
	DKAddEvent("GLOBAL", "mousedown", DKNotepadView_OnEvent);
	DKAddEvent("DKNotepadView_StatusBar", "click", DKNotepadView_OnEvent);
}

////////////////////////////
function DKNotepadView_End()
{
	DKLog("DKNotepadView_End()\n", DKDEBUG);
	DKRemoveEvents(DKNotepadView_OnEvent);
	DKClose("DKNotepad/DKNotepadView.html");
}

/////////////////////////////////////
function DKNotepadView_OnEvent(event)
{
	DKLog("DKNotepadView_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	if(DK_Id(event,"DKNotepadView_StatusBar")){
		DKLog("DKNotepadView_StatusBar\n");
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepad/DKNotepadView.html")){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadView.js");
}