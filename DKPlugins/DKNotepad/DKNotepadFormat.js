/////////////////////////////
function DKNotepadFormat_Init()
{
	DKCreate("DKNotepad/DKNotepadFormat.html,DKNotepad/DKNotepad.html");
	window.addEventListener("mousedown", DKNotepadFormat_OnEvent);
	byId("DKNotepadFormat_WordWrap").addEventListener("click", DKNotepadFormat_OnEvent);
	byId("DKNotepadFormat_Font").addEventListener("click", DKNotepadFormat_OnEvent);
}

//////////////////////////////
function DKNotepadFormat_End()
{
	window.removeEventListener("mousedown", DKNotepadFormat_OnEvent);
	byId("DKNotepadFormat_WordWrap").removeEventListener("click", DKNotepadFormat_OnEvent);
	byId("DKNotepadFormat_Font").removeEventListener("click", DKNotepadFormat_OnEvent);
	DKClose("DKNotepad/DKNotepadFormat.html");
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
	
	if(event.currentTarget === window){
		if(byId("DKNotepad/DKNotepadFormat.html").contains(DKWidget_GetHoverElement())){	
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadFormat.js");
}

///////////////////////////////////
function DKNotepadFormat_WordWrap()
{
	if(byId("DKNotepad_Text").style.whiteSpace === ""){
		byId("DKNotepad_Text").style.whiteSpace = "nowrap";
	}
	else{
		DKWidget_RemoveProperty("DKNotepad_Text","white-space");
	}
}