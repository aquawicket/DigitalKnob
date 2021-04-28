/////////////////////////////
function DKNotepadView_init()()
{
	dk.create("DKNotepad/DKNotepadView.html,DKNotepad/DKNotepad.html");
	document.addEventListener("mousedown", DKNotepadView_onevent);
	byId("DKNotepadView_StatusBar").addEventListener("click", DKNotepadView_onevent);
}

////////////////////////////
function DKNotepadView_end()()
{
	document.removeEventListener("mousedown", DKNotepadView_onevent);
	byId("DKNotepadView_StatusBar").removeEventListener("click", DKNotepadView_onevent);
	dk.close("DKNotepad/DKNotepadView.html");
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
	dk.close("DKNotepad/DKNotepadView.js");
}