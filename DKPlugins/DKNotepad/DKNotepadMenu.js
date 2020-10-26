/////////////////////////////
function DKNotepadMenu_Init()
{
	DK_Create("DKNotepad/DKNotepadMenu.html");
	document.addEventListener("mousedown", DKNotepadMenu_OnEvent);
	byId("DKNotepadMenu_Cut").addEventListener("mousedown", DKNotepadMenu_OnEvent);
	byId("DKNotepadMenu_Copy").addEventListener("mousedown", DKNotepadMenu_OnEvent);
	byId("DKNotepadMenu_Paste").addEventListener("mousedown", DKNotepadMenu_OnEvent);
}

////////////////////////////
function DKNotepadMenu_End()
{
    document.removeEventListener("mousedown", DKNotepadMenu_OnEvent);
	byId("DKNotepadMenu_Cut").removeEventListener("mousedown", DKNotepadMenu_OnEvent);
	byId("DKNotepadMenu_Copy").removeEventListener("mousedown", DKNotepadMenu_OnEvent);
	byId("DKNotepadMenu_Paste").removeEventListener("mousedown", DKNotepadMenu_OnEvent);
	DK_Close("DKNotepad/DKNotepadMenu.html");
}

/////////////////////////////////////
function DKNotepadMenu_OnEvent(event)
{
	if(event.currentTarget.id === "DKNotepadMenu_Cut"){
		DKNotepadMenu_Cut();
		PreventDefault(event);
	}
	if(event.currentTarget.id === "DKNotepadMenu_Copy"){
		DKNotepadMenu_Copy();
	}
	if(event.currentTarget.id === "DKNotepadMenu_Paste"){
		DKNotepadMenu_Paste();
	}
	
	if(event.currentTarget === document){
		if(byId("DKNotepad/DKNotepadMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	DK_Close("DKNotepad/DKNotepadMenu.js");
}

////////////////////////////
function DKNotepadMenu_Cut()
{
	DK_Cut("DKNotepad_Text");
}

/////////////////////////////
function DKNotepadMenu_Copy()
{
	DK_Copy("DKNotepad_Text");
}

//////////////////////////////
function DKNotepadMenu_Paste()
{
	DK_Paste("DKNotepad_Text");
}