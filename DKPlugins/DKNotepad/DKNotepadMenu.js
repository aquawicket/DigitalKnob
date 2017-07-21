/////////////////////////////
function DKNotepadMenu_Init()
{
	//DKLog("DKNotepadMenu_Init()\n");
	
	DKCreate("DKNotepad/DKNotepadMenu.html");
	DKAddEvent("GLOBAL", "mousedown", DKNotepadMenu_OnEvent);
	DKAddEvent("DKNotepadMenu_Cut", "mousedown", DKNotepadMenu_OnEvent);
	DKAddEvent("DKNotepadMenu_Copy", "mousedown", DKNotepadMenu_OnEvent);
	DKAddEvent("DKNotepadMenu_Paste", "mousedown", DKNotepadMenu_OnEvent);
}

////////////////////////////
function DKNotepadMenu_End()
{
	//DKLog("DKNotepadMenu_End()\n");
	
	DKRemoveEvents(DKNotepadMenu_OnEvent);
	DKClose("DKNotepad/DKNotepadMenu.html");
}

/////////////////////////////////////
function DKNotepadMenu_OnEvent(event)
{
	DKLog("DKNotepadMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event,"DKNotepadMenu_Cut")){
		DKNotepadMenu_Cut();
		//PreventDefault(event);
	}
	if(DK_Id(event,"DKNotepadMenu_Copy")){
		DKNotepadMenu_Copy();
	}
	if(DK_Id(event,"DKNotepadMenu_Paste")){
		DKNotepadMenu_Paste();
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepad/DKNotepadMenu.html")){
			return;
		}
	}
	DKClose("DKNotepad/DKNotepadMenu.js");
}

////////////////////////////
function DKNotepadMenu_Cut()
{
	//DKLog("DKNotepadMenu_Cut()\n");
	
	DKWidget_Cut("DKNotepad_Text");
}

/////////////////////////////
function DKNotepadMenu_Copy()
{
	//DKLog("DKNotepadMenu_Copy()\n");
	
	DKWidget_Copy("DKNotepad_Text");
}

//////////////////////////////
function DKNotepadMenu_Paste()
{
	//DKLog("DKNotepadMenu_Paste()\n");
	
	DKWidget_Paste("DKNotepad_Text");
}