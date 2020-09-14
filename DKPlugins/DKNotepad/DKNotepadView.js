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
	if(event.currentTarget.id == "DKNotepadView_StatusBar"){
		DKINFO(("DKNotepadView_StatusBar\n");
	}
	
	if(event.currentTarget == window){
		if(byId("DKNotepad/DKNotepadView.html").contains(byId(DKWidget_GetHoverElement()))){	
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadView.js");
}