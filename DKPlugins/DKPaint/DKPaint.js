var currentFile;

/////////////////////////
function DKPaint_Init()
{
	DKCreate("DKPaint/DKPaint.html");
	DKAddEvent("DKPaint_Save", "click", DKPaint_OnEvent);
	DKAddEvent("DKPaint_Text", "contextmenu", DKPaint_OnEvent);
	DKAddEvent("DKPaint_File", "click", DKPaint_OnEvent);
}

////////////////////////
function DKPaint_End()
{
	DKRemoveEvent("DKPaint_Save", "click", DKPaint_OnEvent);
	DKRemoveEvent("DKPaint_Text", "contextmenu", DKPaint_OnEvent);
	DKRemoveEvent("DKPaint_File", "click", DKPaint_OnEvent);
	DKClose("DKPaint.html");
}

///////////////////////////////
function DKPaint_OnEvent(event)
{
	DKLog("DKPaint_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event,"DKPaint_Save")){
		DKNotepad_Save();
	}
	if(DK_Type(event, "contextmenu")){
		DKCreate("DKPaint/DKPaintMenu.js", function(){});
	}
	if(DK_Id(event,"DKPaint_File")){
		DKCreate("DKPaint/DKPaintFile.js", function(){});
	}
}

/////////////////////////
function DKPaint_Save()
{
	var text = DKWidget_GetValue("DKPaint_Text");
	
	//TODO
	//DKCreate("DKMessage/DKMessage.js");
	//DKMessageBox_Message("File Saved");
}

/////////////////////////////
function DKPaint_Open(file)
{
	DKLog("DKPaint_Open("+file+") \n", DKINFO);
	currentFile = file;
	DKWidget_SetAttribute("DKPaint_Image", "src", file);
}
