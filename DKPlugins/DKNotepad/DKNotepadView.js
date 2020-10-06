/////////////////////////////
function DKNotepadView_Init()
{
	DK_Create("DKNotepad/DKNotepadView.html,DKNotepad/DKNotepad.html");
	window.addEventListener("mousedown", DKNotepadView_OnEvent);
	byId("DKNotepadView_StatusBar").addEventListener("click", DKNotepadView_OnEvent);
}

////////////////////////////
function DKNotepadView_End()
{
	window.removeEventListener("mousedown", DKNotepadView_OnEvent);
	byId("DKNotepadView_StatusBar").removeEventListener("click", DKNotepadView_OnEvent);
	DK_Close("DKNotepad/DKNotepadView.html");
}

/////////////////////////////////////
function DKNotepadView_OnEvent(event)
{
	if(event.currentTarget.id === "DKNotepadView_StatusBar"){
		console.log("DKNotepadView_StatusBar\n");
	}
	
	if(event.currentTarget === window){
		if(byId("DKNotepad/DKNotepadView.html").contains(DKWidget_GetHoverElement())){
			return;
		}
	}
	DK_Close("DKNotepad/DKNotepadView.js");
}