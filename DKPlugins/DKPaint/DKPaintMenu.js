///////////////////////////
function DKPaintMenu_Init()
{
	DKCreate("DKPaint/DKPaintMenu.html");
	DKWidget_SetProperty("DKPaintMenu.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("DKPaintMenu.html","left",DKWindow_GetMouseX()+"px");
	DKAddEvent("GLOBAL", "mousedown", DKPaintMenu_OnEvent);
	DKAddEvent("DKPaintMenu_Cut", "click", DKPaintMenu_OnEvent);
	DKAddEvent("DKPaintMenu_Copy", "click", DKPaintMenu_OnEvent);
	DKAddEvent("DKPaintMenu_Paste", "click", DKPaintMenu_OnEvent);
}

//////////////////////////
function DKPaintMenu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKPaintMenu_OnEvent);
	DKClose("DKPaint/DKPaintMenu.html");
}

///////////////////////////////////
function DKPaintMenu_OnEvent(event)
{
	DKLog("DKPaintMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
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
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKPaintMenu.html")){
			return;
		}
	}
	DKClose("DKPaint/DKPaintMenu.js");
}

//////////////////////////
function DKPaintMenu_Cut()
{
	//TODO
}

///////////////////////////
function DKPaintMenu_Copy()
{
	//TODO
}

////////////////////////////
function DKPaintMenu_Paste()
{
	//TODO
}