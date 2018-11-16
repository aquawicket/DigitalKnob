/////////////////////////////
function DKNotepadView_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKNotepad/DKNotepadView.html,DKNotepad/DKNotepad.html");
	DKAddEvent("window", "mousedown", DKNotepadView_OnEvent);
	DKAddEvent("DKNotepadView_StatusBar", "click", DKNotepadView_OnEvent);
}

////////////////////////////
function DKNotepadView_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKNotepadView_OnEvent);
	DKClose("DKNotepad/DKNotepadView.html");
}

/////////////////////////////////////
function DKNotepadView_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(DK_Id(event,"DKNotepadView_StatusBar")){
		DKINFO(("DKNotepadView_StatusBar\n");
	}
	
	if(DK_Id(event, "window")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepad/DKNotepadView.html")){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadView.js");
}