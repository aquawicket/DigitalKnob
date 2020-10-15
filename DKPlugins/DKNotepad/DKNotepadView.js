/////////////////////////////
function DKNotepadView_Init()
{
	DK_Create("DKNotepad/DKNotepadView.html,DKNotepad/DKNotepad.html");
	document.addEventListener("mousedown", DKNotepadView_OnEvent);
	byId("DKNotepadView_StatusBar").addEventListener("click", DKNotepadView_OnEvent);
}

////////////////////////////
function DKNotepadView_End()
{
	document.removeEventListener("mousedown", DKNotepadView_OnEvent);
	byId("DKNotepadView_StatusBar").removeEventListener("click", DKNotepadView_OnEvent);
	DK_Close("DKNotepad/DKNotepadView.html");
}

/////////////////////////////////////
function DKNotepadView_OnEvent(event)
{
	if(event.currentTarget.id === "DKNotepadView_StatusBar"){
		console.log("DKNotepadView_StatusBar\n");
	}
	
	if(event.currentTarget === document){
		if(byId("DKNotepad/DKNotepadView.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	DK_Close("DKNotepad/DKNotepadView.js");
}