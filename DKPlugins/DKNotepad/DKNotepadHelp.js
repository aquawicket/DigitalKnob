/////////////////////////////
function DKNotepadHelp_Init()
{
	DK_Create("DKNotepad/DKNotepadHelp.html,DKNotepad/DKNotepad.html");
	window.addEventListener("mousedown", DKNotepadHelp_OnEvent);
	byId("DKNotepadHelp_ViewHelp").addEventListener("click", DKNotepadHelp_OnEvent);
	byId("DKNotepadHelp_About").addEventListener("click", DKNotepadHelp_OnEvent);
}

////////////////////////////
function DKNotepadHelp_End()
{
	window.removeEventListener("mousedown", DKNotepadHelp_OnEvent);
	byId("DKNotepadHelp_ViewHelp").removeEventListener("click", DKNotepadHelp_OnEvent);
	byId("DKNotepadHelp_About").removeEventListener("click", DKNotepadHelp_OnEvent);
	DK_Close("DKNotepad/DKNotepadHelp.html");
}

/////////////////////////////////////
function DKNotepadHelp_OnEvent(event)
{
	if(event.currentTarget.id === "DKNotepadHelp_ViewHelp"){
		console.log("DKNotepadHelp_ViewHelpn");
	}
	if(event.currentTarget.id === "DKNotepadHelp_About"){
		console.log("DKNotepadHelp_About");
	}
	
	if(event.currentTarget === window){
		if(byId("DKNotepad/DKNotepadHelp.html").contains(DKWidget_GetHoverElement())){
			return;
		}
	}
	DK_Close("DKNotepad/DKNotepadHelp.js");
}