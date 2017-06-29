/////////////////////////////
function DKNotepadHelp_Init()
{
	//DKLog("DKNotepadHelp_Init()\n");
	
	DKCreate("DKNotepad/DKNotepadHelp.html,DKNotepad/DKNotepad.html");
	DKAddEvent("GLOBAL", "mousedown", DKNotepadHelp_OnEvent);
	DKAddEvent("DKNotepadHelp_ViewHelp", "click", DKNotepadHelp_OnEvent);
	DKAddEvent("DKNotepadHelp_About", "click", DKNotepadHelp_OnEvent);
}

////////////////////////////
function DKNotepadHelp_End()
{
	//DKLog("DKNotepadHelp_End()\n");
	
	DKRemoveEvents(DKNotepadHelp_OnEvent);
	DKClose("DKNotepad/DKNotepadHelp.html");
}

/////////////////////////////////////
function DKNotepadHelp_OnEvent(event)
{
	//DKLog("DKNotepadHelp_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event,"DKNotepadHelp_ViewHelp")){
		DKLog("DKNotepadHelp_ViewHelp\n");
	}
	if(DK_Id(event,"DKNotepadHelp_About")){
		DKLog("DKNotepadHelp_About\n");
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepad/DKNotepadHelp.html")){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadHelp.js");
}