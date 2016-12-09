/////////////////////////////////
function DKFileAssociation_Init()
{
	//DKCreate("DKFileAssociation/DKFileAssociation.html");
	//DKAddEvent("DKFileAssociation_item", "click", DKFileAssociation_OnEvent);
}

////////////////////////////////
function DKFileAssociation_End()
{
	//DKClose("DKFileAssociation/DKFileAssociation.html");
}

////////////////////////////////////////
function DKFileAssociation_OnEvent(event)
{
	DKLog("DKFileAssociation_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
}

/////////////////////////////////////
function DKFileAssociation_Open(file)
{
	var file2 = file;
	if(file.indexOf(".js") > -1){
		DKCreate(file, function(){
			file2 = file2.replace(".js",".html");
			file2 = DKFile_GetFilename(file2);
			DKFrame_Widget(file2);
		});
		return;
	}
	if(file.indexOf(".html") > -1){
		DKCreate(file);
		file = DKFile_GetFilename(file);
		DKFrame_Widget(file);
		return;
	}
	if(file.indexOf(".png") > -1 || file.indexOf(".jpeg") > -1 || file.indexOf(".tif") > -1 || file.indexOf(".gif") > -1 || file.indexOf(".jpg") > -1 || file.indexOf(".tiff") > -1 || file.indexOf(".bmp") > -1){
		DKCreate("DKPaint/DKPaint.js");
		DKFrame_Widget("DKPaint.html");
		var assets = DKAssets_LocalAssets();
		DKPaint_Open(assets+file);
		return;
	}
	if(file.indexOf(".wav") > -1 || file.indexOf(".mp3") > -1){
		DKCreate("DKRocketAudio/DKRocketAudio.js");
		DKFrame_Widget("DKRocketAudio.html");
		DKRocketAudio_Open(file);
		return;
	}
	else{
		DKCreate("DKNotepad/DKNotepad.js");
		DKFrame_Widget("DKNotepad.html");
		var assets = DKAssets_LocalAssets();
		DKNotepad_Open(assets+file);
		return;
	}
}