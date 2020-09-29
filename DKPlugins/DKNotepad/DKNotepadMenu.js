/////////////////////////////
function DKNotepadMenu_Init()
{
	DKCreate("DKNotepad/DKNotepadMenu.html");
	window.addEventListener("mousedown", DKNotepadMenu_OnEvent);
	byId("DKNotepadMenu_Cut").addEventListener("mousedown", DKNotepadMenu_OnEvent);
	byId("DKNotepadMenu_Copy").addEventListener("mousedown", DKNotepadMenu_OnEvent);
	byId("DKNotepadMenu_Paste").addEventListener("mousedown", DKNotepadMenu_OnEvent);
}

////////////////////////////
function DKNotepadMenu_End()
{
	window.removeEventListener("mousedown", DKNotepadMenu_OnEvent);
	byId("DKNotepadMenu_Cut").removeEventListener("mousedown", DKNotepadMenu_OnEvent);
	byId("DKNotepadMenu_Copy").removeEventListener("mousedown", DKNotepadMenu_OnEvent);
	byId("DKNotepadMenu_Paste").removeEventListener("mousedown", DKNotepadMenu_OnEvent);
	DKClose("DKNotepad/DKNotepadMenu.html");
}

/////////////////////////////////////
function DKNotepadMenu_OnEvent(event)
{
	if(event.currentTarget.id == "DKNotepadMenu_Cut"){
		DKNotepadMenu_Cut();
		PreventDefault(event);
	}
	if(event.currentTarget.id == "DKNotepadMenu_Copy"){
		DKNotepadMenu_Copy();
	}
	if(event.currentTarget.id == "DKNotepadMenu_Paste"){
		DKNotepadMenu_Paste();
	}
	
	if(event.currentTarget == window){
		if(byId("DKNotepad/DKNotepadMenu.html").contains(DKWidget_GetHoverElement())){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadMenu.js");
}

////////////////////////////
function DKNotepadMenu_Cut()
{
	DKWidget_Cut("DKNotepad_Text");
}

/////////////////////////////
function DKNotepadMenu_Copy()
{
	DKWidget_Copy("DKNotepad_Text");
}

//////////////////////////////
function DKNotepadMenu_Paste()
{
	DKWidget_Paste("DKNotepad_Text");
}