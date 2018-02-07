/////////////////////////////
function DKPaintFile_Init()
{
	DKCreate("DKPaint/DKPaintFile.html,DKPaint/DKPaint.html");
	DKAddEvent("GLOBAL", "mousedown", DKPaintFile_OnEvent);
	DKAddEvent("DKPaintFile_Open", "click", DKPaintFile_OnEvent);
	DKAddEvent("DKPaintFile_Save", "click", DKPaintFile_OnEvent);
	DKAddEvent("DKPaintFile_Save As", "click", DKPaintFile_OnEvent);
	DKAddEvent("DKPaintFile_Exit", "click", DKPaintFile_OnEvent);
}

//////////////////////////
function DKPaintFile_End()
{
	DKRemoveEvents(DKPaintFile_OnEvent);
	DKClose("DKPaint/DKPaintFile.html");
}

///////////////////////////////////
function DKPaintFile_OnEvent(event)
{
	//DKLog("DKPaintFile_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
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
		DKClose("DKPaint/DKPaintFile.js");
		DKFrame_Close("DKPaint/DKPaint.html");
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKPaint/DKPaintFile.html")){
			return;
		}
	}
	DKClose("DKPaint/DKPaintFile.js");
}

///////////////////////////
function DKPaintFile_Open()
{
	//DKLog("DKPaintFile_Open()\n");
	
	DKCreate("DKFile/DKOpenFile.js", function(){
		DKFrame_Widget("DKFile/DKOpenFile.html");
		DKSendEvent("DKFile/DKOpenFile.html", "GetFile", "DKPaint/DKPaint.html,OpenFile,/,absolute"); // To -> DKOpenFile
	});
}

///////////////////////////
function DKPaintFile_Save()
{
	DKLog("DKPaintFile_Save \n");
}

/////////////////////////////
function DKPaintFile_SaveAs()
{
	DKLog("DKPaintFile_SaveAs \n");
}