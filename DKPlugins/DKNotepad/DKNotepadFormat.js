/////////////////////////////
function DKNotepadFormat_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKNotepad/DKNotepadFormat.html,DKNotepad/DKNotepad.html");
	//DKAddEvent("window", "mousedown", DKNotepadFormat_OnEvent);
	window.addEventListener("mousedown", DKNotepadFormat_OnEvent);
	//DKAddEvent("DKNotepadFormat_WordWrap", "click", DKNotepadFormat_OnEvent);
	byId("DKNotepadFormat_WordWrap").addEventListener("click", DKNotepadFormat_OnEvent);
	//DKAddEvent("DKNotepadFormat_Font", "click", DKNotepadFormat_OnEvent);
	byId("DKNotepadFormat_Font").addEventListener("click", DKNotepadFormat_OnEvent);
}

//////////////////////////////
function DKNotepadFormat_End()
{
	DKDEBUGFUNC();
	//DKRemoveEvents(DKNotepadFormat_OnEvent);
	window.removeEventListener("mousedown", DKNotepadFormat_OnEvent);
	byId("DKNotepadFormat_WordWrap").removeEventListener("click", DKNotepadFormat_OnEvent);
	byId("DKNotepadFormat_Font").removeEventListener("click", DKNotepadFormat_OnEvent);
	DKClose("DKNotepad/DKNotepadFormat.html");
}

///////////////////////////////////////
function DKNotepadFormat_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(event.currentTarget.id == "DKNotepadFormat_WordWrap"){
		DKNotepadFormat_WordWrap();
	}
	if(event.currentTarget.id == "DKNotepadFormat_Font"){
		console.log("DKNotepadFormat_Fontn");
	}
	
	if(event.currentTarget == window){
		if(byId("DKNotepad/DKNotepadFormat.html").contains(DKWidget_GetHoverElement())){	
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadFormat.js");
}

///////////////////////////////////
function DKNotepadFormat_WordWrap()
{
	DKDEBUGFUNC();
	if(DKWidget_GetProperty("DKNotepad_Text","white-space") == ""){
		DKWidget_SetProperty("DKNotepad_Text","white-space","nowrap");
	}
	else{
		DKWidget_RemoveProperty("DKNotepad_Text","white-space");
	}
}