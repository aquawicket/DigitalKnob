/////////////////////
function DKOcr_Init()
{
	DKLog("DKOcr_Init()\n");
	
	DKCreate("DKOcr");
	DKCreate("DKOcr/DKOcr.html");
	DKCreate("DKNotePad/DKNotepad.js", function(){
		DKWidget_AppendChild("DKOcr/DKOcr.html", "DKNotepad/DKNotepad.html");
	});
	
	DKAddEvent("GLOBAL", "OpenFile", DKOcr_OnEvent);
}

////////////////////
function DKOcr_End()
{
	DKLog("DKOcr_End()\n");
	
	DKRemoveEvents(DKOcr_OnEvent);
}

/////////////////////////////
function DKOcr_OnEvent(event)
{
	DKLog("DKOcr_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "OpenFile")){
		var file = DK_GetValue(event);
		DKLog("OpenFile: "+file+" \n");
		var text;
		if(text = DKOcr_ImageToText(file)){
			DKWidget_SetAttribute("DKNotepad_Text", "value", text);
		}
		else{
			DKNotepad_Open(file);
		}
	}
}