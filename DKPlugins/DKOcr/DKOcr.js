/////////////////////
function DKOcr_Init()
{
	DKLog("DKOcr_Init()\n");
	
	DKCreate("DKOcr");
	DKCreate("DKOcr/DKOcr.html");
	DKCreate("DKNotepad/DKNotepad.js", function(){
		DKWidget_AppendChild("DKOcr/DKOcr.html", "DKNotepad/DKNotepad.html");
		DKRemoveEvent("DKNotepad/DKNotepad.html", "OpenFile", DKNotepad_OnEvent);
		DKAddEvent("DKNotepad/DKNotepad.html", "OpenFile", DKOcr_OnEvent);
	});
}

////////////////////
function DKOcr_End()
{
	DKLog("DKOcr_End()\n");
	
	DKClose("DKNotepad/DKNotepad.js");
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
		if(file.includes(".pdf") || file.includes(".PDF")){
			DKLog("DKOcr_OnEvent(): file is a pdf\n", DKINFO);
			var assets = DKAssets_LocalAssets();
			var temp_file = assets+"temp.png";
			DKLog("temp_file = "+temp_file+"\n", DKINFO);
			
			DKFile_Delete(assets+"/temp.png");
			for(var i=0; i<1000; i++){
				if(DKFile_Exists(assets+"/temp-"+i+".png")){
					DKFile_Delete(assets+"/temp-"+i+".png");
				}
				else{
					i=1000;
					continue;
				}
			}
			
			DK_System(assets+"/DKImageMagick/magick.exe convert -verbose -density 300 -trim \""+file+"\" -colorspace Gray -quality 100 \""+temp_file+"\"");
			file = assets+"/temp.png";
			
			var pages = "";
			for(var i=0; i<1000; i++){
				if(DKFile_Exists(assets+"/temp-"+i+".png")){
					pages += DKOcr_ImageToText(assets+"/temp-"+i+".png");
					DKWidget_SetAttribute("DKNotepad_Text", "value", pages);
				}
				else{
					i=1000;
					continue;
				}
			}
			if(DKFile_Exists(assets+"/temp-0.png")){ return ; }
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