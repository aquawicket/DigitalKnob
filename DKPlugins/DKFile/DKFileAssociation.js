/////////////////////////////////
function DKFileAssociation_Init()
{
	//DKLog("DKFileAssociation_Init()\n");
}

////////////////////////////////
function DKFileAssociation_End()
{
	//DKLog("DKFileAssociation_End()\n");
}

/////////////////////////////////////////
function DKFileAssociation_OnEvent(event)
{
	//DKLog("DKFileAssociation_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
}

/////////////////////////////////////
function DKFileAssociation_Open(file)
{
	//DKLog("DKFileAssociation_Open("+file+")\n");
	
	if(file.indexOf(".") == -1 ){ return false; }
	if(file.indexOf(".js") != -1 ){ DKFileAssociation_OpenJS(file); return true; }
	if(file.indexOf(".html") != -1 ){ DKFileAssociation_OpenHtml(file); return true; }
	if(file.indexOf(".css") != -1 ){ DKFileAssociation_OpenCss(file); return true; }
	if(file.indexOf(".png") != -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".bmp") != -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".gif") != -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".jpeg") != -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".jpg") != -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".tiff") != -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".tif") != -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".osgt") != -1 ){ DKFileAssociation_OpenModel(file); return true; }
	if(file.indexOf(".osg") != -1 ){ DKFileAssociation_OpenModel(file); return true; }
	if(file.indexOf(".wav") != -1 ){ DKFileAssociation_OpenAudio(file); return true; }
	if(file.indexOf(".mp3") != -1 ){ DKFileAssociation_OpenAudio(file); return true; }
	if(file.indexOf(".avi") != -1 ){ DKFileAssociation_OpenVideo(file); return true; }
	if(file.indexOf(".mkv") != -1 ){ DKFileAssociation_OpenVideo(file); return true; }
	if(file.indexOf(".mp4") != -1 ){ DKFileAssociation_OpenVideo(file); return true; }
	DKFileAssociation_OpenText(file); return true;
}


/////////////////////////////////////////
function DKFileAssociation_OpenHtml(path)
{
	DKLog("DKFileAssociation_OpenHtml("+path+")\n");
	
	var id = path.replace(DKAssets_LocalAssets(),"");
	//var id = DKFile_GetFilename(path);
	if(DKCreate(id)){
		//DKFileAssociation_AddDragHandles(id);
		DKFrame_Widget(id);
		//DKFileAssociation_SelectElement(id);
	};
	
	
	//FIXME
	return;
	
	//TODO - to use files outside of the data directory, we need to append the datapath
	//var the_path = path.replace(id, "");
	//DKLog("DKWidget_AppendDataPath("+the_path+") \n");
	//AppendDataPath(the_path);

	var filedata = DKFile_FileToString(path);
	if(!filedata){ return false; }
	//if(!HtmlToRml(filedata)){ return false; }

	//Parse the sting into an element
	var temp = DKWidget_CreateElement("body", "temp", "temporary");
	DKWidget_SetInnerHtml(temp, filedata);

	//if(DKWidget_GetNumChildren(temp) == 0){
	//	DKLog("Error loading path: "+id+": could not create node. \n", DKERROR);
	//	return false;
	//}

	//Make sure there is only 1 child
	//if(DKWidget_GetNumChildren(temp) > 1){
	//	DKLog("Error loading path: "+id+" has more than one root node.\n", DKERROR);
	//	return false;
	//}

	DKLog("temp: "+temp+"\n");
	var element = DKWidget_GetFirstChild(temp);
	DKLog("element = "+element+"\n");
	//DKElement* element = temp->GetFirstChild();
	//DKWidget_SetAttribute(element, "id", id);
	
	DKWidget_AppendChild("body", element);
	DKWidget_RemoveElement("temporary");
	//Show(id);
	//DKFileAssociation_AddDragHandles(id);
	//DKFileAssociation_SelectElement(id);
}

///////////////////////////////////////
function DKFileAssociation_OpenJS(path)
{
	//DKLog("DKFileAssociation_OpenJS("+path+")\n");
	
	path = path.replace(absolutepath, "");
		
	var id = path.replace(DKAssets_LocalAssets(),"");
	DKCreate(id, function(rval){
		if(!rval){ return; }
		id = id.replace(".js",".html");
		DKFrame_Widget(id);
	});
}

////////////////////////////////////////
function DKFileAssociation_OpenCss(path)
{
	//DKLog("DKFileAssociation_OpenCss("+path+")\n");
	
	var id = path.replace(DKAssets_LocalAssets(),"");
	DKCreate(id, function(rval){
		if(!rval){ return; }
	});
}

/////////////////////////////////////////
function DKFileAssociation_OpenText(path)
{
	//DKLog("DKFileAssociation_OpenText("+path+")\n");
	
	DKWidget_Toggle("DKNotepad.html");
	DKCreate("DKNotepad/DKNotepad.js", function(){
		DKFrame_Widget("DKNotepad/DKNotepad.html");
		DKNotepad_Open(path);
	});
}

//////////////////////////////////////////
function DKFileAssociation_OpenImage(path)
{
	//DKLog("DKFileAssociation_OpenImage("+path+")\n");
	
	DKCreate("DKPaint/DKPaint.js", function(){
		DKFrame_Widget("DKPaint/DKPaint.html");
		DKPaint_Open(path);
	});
}

//////////////////////////////////////////
function DKFileAssociation_OpenModel(path)
{
	//DKLog("DKFileAssociation_OpenModel("+path+")\n");
	
	DKCreate("DKOSGManipulator,,DKOSGWindow", function(){});
	DKCreate("DKOSGModel,,DKWindow,"+path, function(){});
}

//////////////////////////////////////////
function DKFileAssociation_OpenAudio(path)
{
	//DKLog("DKFileAssociation_OpenAudio("+path+")\n");
	
	//var file = DKFile_GetFilename(path);
	DKCreate("DKAudio", function(){
		DKAudio_PlaySound(path);
	});
	
	//DKCreate("DKOSGAudio,"+file+",DKOSGWindow,"+path);
	//DKOSGAudio_Play("DKOSGAudio,"+file);
	
	//DKCreate("DKSDLAudio,"+file+",DKSDLWindow,"+path);
	//DKSDLAudio_Play("DKSDLAudio,"+file);
}

//////////////////////////////////////////
function DKFileAssociation_OpenVideo(path)
{
	DKLog("DKFileAssociation_OpenVideo("+path+")\n");
	
	//FIXME
	DKVideo_Play(path);
}