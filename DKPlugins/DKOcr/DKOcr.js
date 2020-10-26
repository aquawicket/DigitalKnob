/////////////////////
function DKOcr_Init()
{
	DK_Create("DKOcr");
	DK_Create("DKOcr/DKOcr.html");
	DK_Create("DKNotepad/DKNotepad.js", function(){
		DK_AppendChild("DKOcr/DKOcr.html", "DKNotepad/DKNotepad.html");
		byId("DKNotepad/DKNotepad.html").removeEventListener("OpenFile", DKNotepad_OnEvent);
		byId("DKNotepad/DKNotepad.html").addEventListener("OpenFile", DKOcr_OnEvent);
	});
}

////////////////////
function DKOcr_End()
{
	byId("DKNotepad/DKNotepad.html").removeEventListener("OpenFile", DKOcr_OnEvent);
	DK_Close("DKNotepad/DKNotepad.js");
}

/////////////////////////////
function DKOcr_OnEvent(event)
{
	if(event.type === "OpenFile"){
		var file = DK_GetValue(event);
		console.log("OpenFile: "+file+"\n");
		
		//if file is pdf, convert it to png
		if(file.includes(".pdf") || file.includes(".PDF")){
			console.log("DKOcr_OnEvent(): file is a pdf\n");
			var assets = DKAssets_LocalAssets();
			var temp_file = assets+"temp.png";
			console.log("temp_file = "+temp_file+"\n");
			
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
					byId("DKNotepad_Text").value = pages;
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
			byId("DKNotepad_Text").value = text;
		}
		else{
			DKNotepad_Open(file);
		}
	}
}