/////////////////////////////
function DKNotepadEdit_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKNotepad/DKNotepadEdit.html,DKNotepad/DKNotepad.html");
	//DKAddEvent("window", "mousedown", DKNotepadEdit_OnEvent);
	window.addEventListener("mousedown", DKNotepadEdit_OnEvent);
	//DKAddEvent("DKNotepadEdit_Undo", "click", DKNotepadEdit_OnEvent);
	byId("DKNotepadEdit_Undo").addEventListener("click", DKNotepadEdit_OnEvent);
	//DKAddEvent("DKNotepadEdit_Cut", "click", DKNotepadEdit_OnEvent);
	byId("DKNotepadEdit_Cut").addEventListener("click", DKNotepadEdit_OnEvent);
	//DKAddEvent("DKNotepadEdit_Copy", "click", DKNotepadEdit_OnEvent);
	byId("DKNotepadEdit_Copy").addEventListener("click", DKNotepadEdit_OnEvent);
	//DKAddEvent("DKNotepadEdit_Paste", "click", DKNotepadEdit_OnEvent);
	byId("DKNotepadEdit_Paste").addEventListener("click", DKNotepadEdit_OnEvent);
	//DKAddEvent("DKNotepadEdit_Delete", "click", DKNotepadEdit_OnEvent);
	byId("DKNotepadEdit_Delete").addEventListener("click", DKNotepadEdit_OnEvent);
	//DKAddEvent("DKNotepadEdit_Find", "click", DKNotepadEdit_OnEvent);
	byId("DKNotepadEdit_Find").addEventListener("click", DKNotepadEdit_OnEvent);
}

////////////////////////////
function DKNotepadEdit_End()
{
	DKDEBUGFUNC();
	//DKRemoveEvents(DKNotepadEdit_OnEvent);
	DKClose("DKNotepad/DKNotepadEdit.html");
}

/////////////////////////////////////
function DKNotepadEdit_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(event.currentTarget.id == "DKNotepadEdit_Undo"){
		console.log("DKNotepadEdit_Undo\n");
	}
	if(event.currentTarget.id == "DKNotepadEdit_Cut"){
		console.log("DKNotepadEdit_Cut\n");
	}
	if(event.currentTarget.id == "DKNotepadEdit_Copy"){
		console.log("DKNotepadEdit_Copy\n");
	}
	if(event.currentTarget.id == "DKNotepadEdit_Paste"){
		console.log("DKNotepadEdit_Paste\n");
	}
	if(event.currentTarget.id == "DKNotepadEdit_Delete"){
		console.log("DKNotepadEdit_Delete\n");
	}
	if(event.currentTarget.id == "DKNotepadEdit_Find"){
		console.log("DKNotepadEdit_Find\n");
	}
	
	if(event.currentTarget == window){
		if(byId("DKNotepad/DKNotepadEdit.html").contains(DKWidget_GetHoverElement())){	
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadEdit.js");
}