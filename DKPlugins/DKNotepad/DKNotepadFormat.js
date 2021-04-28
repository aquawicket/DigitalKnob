/////////////////////////////
function DKNotepadFormat_Init()
{
	dk.create("DKNotepad/DKNotepadFormat.html,DKNotepad/DKNotepad.html");
	document.addEventListener("mousedown", DKNotepadFormat_onevent);
	byId("DKNotepadFormat_WordWrap").addEventListener("click", DKNotepadFormat_onevent);
	byId("DKNotepadFormat_Font").addEventListener("click", DKNotepadFormat_onevent);
}

//////////////////////////////
function DKNotepadFormat_End()
{
	document.removeEventListener("mousedown", DKNotepadFormat_onevent);
	byId("DKNotepadFormat_WordWrap").removeEventListener("click", DKNotepadFormat_onevent);
	byId("DKNotepadFormat_Font").removeEventListener("click", DKNotepadFormat_onevent);
	dk.close("DKNotepad/DKNotepadFormat.html");
}

///////////////////////////////////////
function DKNotepadFormat_OnEvent(event)
{
	if(event.currentTarget.id === "DKNotepadFormat_WordWrap"){
		DKNotepadFormat_WordWrap();
	}
	if(event.currentTarget.id === "DKNotepadFormat_Font"){
		console.log("DKNotepadFormat_Fontn");
	}
	
	if(event.currentTarget === document){
		if(byId("DKNotepad/DKNotepadFormat.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){	
			return;
		}
	}
	dk.close("DKNotepad/DKNotepadFormat.js");
}

///////////////////////////////////
function DKNotepadFormat_WordWrap()
{
	if(byId("DKNotepad_Text").style.whiteSpace === ""){
		byId("DKNotepad_Text").style.whiteSpace = "nowrap";
	}
	else{
		byId("DKNotepad_Text").style.removeProperty("white-space");
	}
}