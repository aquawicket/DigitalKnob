/////////////////////////////
function DKNotepadHelp_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKNotepad/DKNotepadHelp.html,DKNotepad/DKNotepad.html");
	DKAddEvent("window", "mousedown", DKNotepadHelp_OnEvent);
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
	if(event.currentTarget.id == "DKNotepadHelp_ViewHelp"){
		console.log("DKNotepadHelp_ViewHelpn");
	}
	if(event.currentTarget.id == "DKNotepadHelp_About"){
		console.log("DKNotepadHelp_About");
	}
	
	if(event.currentTarget == window){
		if(byId("DKNotepad/DKNotepadHelp.html").contains()){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadHelp.js");
}