var currentFile;

///////////////////////
function DKPaint_Init()
{
	//DKLog("DKPaint_Init()\n");
	
	DKCreate("DKPaint/DKPaint.css");
	DKCreate("DKPaint/DKPaint.html");
	//DKAddEvent("DKPaint_Save", "click", DKPaint_OnEvent);
	DKAddEvent("DKPaint/DKPaint.html", "contextmenu", DKPaint_OnEvent);
	DKAddEvent("DKPaint_File", "click", DKPaint_OnEvent);
	DKAddEvent("GLOBAL", "OpenFile", DKPaint_OnEvent);
}

//////////////////////
function DKPaint_End()
{
	//DKLog("DKPaint_End()\n");
	
	DKRemoveEvents(DKPaint_OnEvent);
	DKClose("DKPaint/DKPaint.html");
	DKClose("DKPaint/DKPaint.css");
}

///////////////////////////////
function DKPaint_OnEvent(event)
{
	//DKLog("DKPaint_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event,"DKPaint_Save")){
		//DKNotepad_Save();
	}
	if(DK_Type(event, "contextmenu")){
		DKCreate("DKPaint/DKPaintMenu.js", function(){});
	}
	if(DK_Id(event,"DKPaint_File")){
		DKCreate("DKPaint/DKPaintFile.js", function(){});
	}
	if(DK_Type(event, "OpenFile")){
		var file = DK_GetValue(event);
		DKLog("OpenFile: "+file+" \n");
		DKPaint_Open(file)
	}
}

///////////////////////
function DKPaint_Save()
{
	var text = DKWidget_GetValue("DKPaint_Text");
	
	//TODO
	//DKCreate("DKMessage/DKMessage.js");
	//DKMessageBox_Message("File Saved");
}

///////////////////////////
function DKPaint_Open(file)
{
	DKLog("DKPaint_Open("+file+") \n");
	currentFile = file;
	if(file.includes(".pdf") || file.includes(".PDF")){
		DKWidget_SetAttribute("DKPaint_Image", "src", "");
		DKWidget_SetAttribute("DKPaint_Embed", "src", file);
		DKWidget_SetAttribute("DKPaint_Embed", "type", "application/pdf");
	}
	else if(file.includes(".tif")){
		DKWidget_SetAttribute("DKPaint_Image", "src", "");
		DKWidget_SetAttribute("DKPaint_Embed", "src", file);
		DKWidget_SetAttribute("DKPaint_Embed", "type", "image/tiff");
	}
	else{
		DKWidget_SetAttribute("DKPaint_Image", "src", file);
		DKWidget_SetAttribute("DKPaint_Embed", "src", "");
	}
}
