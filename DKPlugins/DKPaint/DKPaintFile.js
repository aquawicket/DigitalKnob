/////////////////////////////
function DKPaintFile_Init()
{
	DKCreate("DKPaint/DKPaintFile.html,DKPaint.html");
	DKAddEvent("GLOBAL", "mousedown", DKPaintFile_OnEvent);
	DKAddEvent("DKPaintFile_Open", "click", DKPaintFile_OnEvent);
	DKAddEvent("DKPaintFile_Save", "click", DKPaintFile_OnEvent);
	DKAddEvent("DKPaintFile_Save As", "click", DKPaintFile_OnEvent);
	DKAddEvent("DKPaintFile_Exit", "click", DKPaintFile_OnEvent);
}

//////////////////////////
function DKPaintFile_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKPaintFile_OnEvent);
	DKRemoveEvent("DKPaintFile_Open", "click", DKPaintFile_OnEvent);
	DKRemoveEvent("DKPaintFile_Save", "click", DKPaintFile_OnEvent);
	DKRemoveEvent("DKPaintFile_Save As", "click", DKPaintFile_OnEvent);
	DKRemoveEvent("DKPaintFile_Exit", "click", DKPaintFile_OnEvent);
	DKClose("DKPaintFile.html");
}

///////////////////////////////////
function DKPaintFile_OnEvent(event)
{
	DKLog("DKPaintFile_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event,"DKPaintFile_Open")){
		DKPaintFile_Open();
	}
	if(DK_Id(event,"DKPaintFile_Save")){
		DKPaintFile_Save();
	}
	if(DK_Id(event,"DKPaintFile_Save As")){
		DKPaintFile_SaveAs();
	}
	if(DK_Id(event,"DKPaintFile_Exit")){
		DKFrame_Close("DKPaint.html");
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKPaintFile.html")){
			return;
		}
	}
	DKClose("DKPaintFile.js");
}

///////////////////////////
function DKPaintFile_Open()
{
	DKLog("DKPaintFile_Open \n", DKDEBUG);
}

///////////////////////////
function DKPaintFile_Save()
{
	DKLog("DKPaintFile_Save \n", DKDEBUG);
}

/////////////////////////////
function DKPaintFile_SaveAs()
{
	DKLog("DKPaintFile_SaveAs \n", DKDEBUG);
}