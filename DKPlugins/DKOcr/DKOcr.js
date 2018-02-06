/////////////////////
function DKOcr_Init()
{
	DKLog("DKOcr_Init()\n");
	
	DKCreate("DKOcr");
	DKCreate("DKOcr/DKOcr.html");
	DKCreate("DKNotepad/DKNotepad.js", function(){
		DKWidget_AppendChild("DKOcr/DKOcr.html", "DKNotepad/DKNotepad.html");
	});
	
	DKAddEvent("GLOBAL", "OpenFile", DKOcr_OnEvent);
}

////////////////////
function DKOcr_End()
{
	DKLog("DKOcr_End()\n");
	
	DKClose("DKNotePad/DKNotepad.js");
	DKRemoveEvents(DKOcr_OnEvent);
}

/////////////////////////////
function DKOcr_OnEvent(event)
{
	DKLog("DKOcr_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "OpenFile")){
		var file = DK_GetValue(event);
		DKLog("OpenFile: "+file+" \n");
		
		//if file is pdf, convert it to png
		if(file.includes(".pdf")){
			DKLog("DKOcr_OnEvent(): file is a pdf\n", DKINFO);
			var assets = DKAssets_LocalAssets();
			DK_System(assets+"/DKImageMagick/magick.exe convert "+file+" "+assets+"/temp.png");
			file = assets+"/temp.png";
		}
		
		var text;
		if(text = DKOcr_ImageToText(file)){
			DKWidget_SetAttribute("DKNotepad_Text", "value", text);
		}
		else{
			DKNotepad_Open(file);
		}
	}
}