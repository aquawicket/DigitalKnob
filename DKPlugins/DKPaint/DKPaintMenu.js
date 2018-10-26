///////////////////////////
function DKPaintMenu_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKPaint/DKPaintMenu.html");
	DKAddEvent("GLOBAL", "mousedown", DKPaintMenu_OnEvent);
	DKAddEvent("DKPaintMenu_Cut", "click", DKPaintMenu_OnEvent);
	DKAddEvent("DKPaintMenu_Copy", "click", DKPaintMenu_OnEvent);
	DKAddEvent("DKPaintMenu_Paste", "click", DKPaintMenu_OnEvent);
}

//////////////////////////
function DKPaintMenu_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKPaintMenu_OnEvent);
	DKClose("DKPaint/DKPaintMenu.html");
}

///////////////////////////////////
function DKPaintMenu_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(DK_Id(event,"DKPaintMenu_Cut")){
		DKPaintMenu_Cut();
	}
	if(DK_Id(event,"DKPaintMenu_Copy")){
		DKPaintMenu_Copy();
	}
	if(DK_Id(event,"DKPaintMenu_Paste")){
		DKPaintMenu_Paste();
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKPaint/DKPaintMenu.html")){
			return;
		}
	}
	DKClose("DKPaintMenu.js");
}

//////////////////////////
function DKPaintMenu_Cut()
{
	DKDEBUGFUNC();
}

///////////////////////////
function DKPaintMenu_Copy()
{
	DKDEBUGFUNC();
}

////////////////////////////
function DKPaintMenu_Paste()
{
	DKDEBUGFUNC();
}