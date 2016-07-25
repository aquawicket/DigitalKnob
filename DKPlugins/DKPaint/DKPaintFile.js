/////////////////////////////
function DKPaintFile_Init()
{
	DKCreate("DKPaint/DKPaintFile.html,DKPaint.html");
	DKAddEvent("GLOBAL", "mousedown", DKPaintFile_OnEvent);
	DKAddEvent("DKPaintFile_Open", "click", DKPaintFile_OnEvent);
	DKAddEvent("DKPaintFile_Save", "click", DKPaintFile_OnEvent);
	DKAddEvent("DKPaintFile_Save As", "click", DKPaintFile_OnEvent);
}

//////////////////////////
function DKPaintFile_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKPaintFile_OnEvent);
	DKClose("DKPaint/DKPaintFile.html");
}

///////////////////////////////////
function DKPaintFile_OnEvent(event)
{
	if(DK_Id(event,"DKPaintFile_Open")){
		DKPaintFile_Open();
	}
	if(DK_Id(event,"DKPaintFile_Save")){
		DKPaintFile_Save();
	}
	if(DK_Id(event,"DKPaintFile_Save As")){
		DKPaintFile_SaveAs();
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKPaintFile.html")){
			return;
		}
	}
	DKClose("DKPaint/DKPaintFile.js");
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