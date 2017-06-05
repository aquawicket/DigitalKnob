/////////////////////////////
function DKNotepadMenu_Init()
{
	DKCreate("DKNotepad/DKNotepadMenu.html");
	DKWidget_SetProperty("DKNotepadMenu.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("DKNotepadMenu.html","left",DKWindow_GetMouseX()+"px");
	DKAddEvent("GLOBAL", "mousedown", DKNotepadMenu_OnEvent);
	DKAddEvent("DKNotepadMenu_Cut", "click", DKNotepadMenu_OnEvent);
	DKAddEvent("DKNotepadMenu_Copy", "click", DKNotepadMenu_OnEvent);
	DKAddEvent("DKNotepadMenu_Paste", "click", DKNotepadMenu_OnEvent);
}

////////////////////////////
function DKNotepadMenu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKNotepadMenu_OnEvent);
	DKRemoveEvent("DKNotepadMenu_Cut", "click", DKNotepadMenu_OnEvent);
	DKRemoveEvent("DKNotepadMenu_Copy", "click", DKNotepadMenu_OnEvent);
	DKRemoveEvent("DKNotepadMenu_Paste", "click", DKNotepadMenu_OnEvent);
	DKClose("DKNotepadMenu.html");
}

/////////////////////////////////////
function DKNotepadMenu_OnEvent(event)
{
	DKLog("DKNotepadMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event,"DKNotepadMenu_Cut")){
		DKNotepadMenu_Cut();
	}
	if(DK_Id(event,"DKNotepadMenu_Copy")){
		DKNotepadMenu_Copy();
	}
	if(DK_Id(event,"DKNotepadMenu_Paste")){
		DKNotepadMenu_Paste();
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKNotepadMenu.html")){
			return;
		}
	}
	DKClose("DKNotepadMenu.js");
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