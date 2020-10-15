/////////////////////////////
function DKNotepadHelp_Init()
{
	DK_Create("DKNotepad/DKNotepadHelp.html,DKNotepad/DKNotepad.html");
	document.addEventListener("mousedown", DKNotepadHelp_OnEvent);
	byId("DKNotepadHelp_ViewHelp").addEventListener("click", DKNotepadHelp_OnEvent);
	byId("DKNotepadHelp_About").addEventListener("click", DKNotepadHelp_OnEvent);
}

////////////////////////////
function DKNotepadHelp_End()
{
	document.removeEventListener("mousedown", DKNotepadHelp_OnEvent);
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
	
	if(event.currentTarget === document){
		if(byId("DKNotepad/DKNotepadHelp.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	DK_Close("DKNotepad/DKNotepadHelp.js");
}