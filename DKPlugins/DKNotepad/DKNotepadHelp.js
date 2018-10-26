/////////////////////////////
function DKNotepadHelp_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKNotepad/DKNotepadHelp.html,DKNotepad/DKNotepad.html");
	DKAddEvent("GLOBAL", "mousedown", DKNotepadHelp_OnEvent);
	DKAddEvent("DKNotepadHelp_ViewHelp", "click", DKNotepadHelp_OnEvent);
	DKAddEvent("DKNotepadHelp_About", "click", DKNotepadHelp_OnEvent);
}

////////////////////////////
function DKNotepadHelp_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKNotepadHelp_OnEvent);
	DKClose("DKNotepad/DKNotepadHelp.html");
}

/////////////////////////////////////
function DKNotepadHelp_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(DK_Id(event,"DKNotepadHelp_ViewHelp")){
		DKINFO(("DKNotepadHelp_ViewHelp\n");
	}
	if(DK_Id(event,"DKNotepadHelp_About")){
		DKINFO(("DKNotepadHelp_About\n");
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepad/DKNotepadHelp.html")){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadHelp.js");
}