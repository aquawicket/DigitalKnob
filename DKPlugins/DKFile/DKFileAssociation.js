/////////////////////////////////
function DKFileAssociation_Init()
{

}

////////////////////////////////
function DKFileAssociation_End()
{

}

/////////////////////////////////////////
function DKFileAssociation_OnEvent(event)
{
	console.debug("DKFileAssociation_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")");
}

/////////////////////////////////////
function DKFileAssociation_Open(file)
{
	if(file.indexOf(".") === -1 ){ return false; }
	if(file.indexOf(".js") !== -1 ){ DKFileAssociation_OpenJS(file); return true; }
	if(file.indexOf(".html") !== -1 ){ DKFileAssociation_OpenHtml(file); return true; }
	if(file.indexOf(".css") !== -1 ){ DKFileAssociation_OpenCss(file); return true; }
	if(file.indexOf(".png") !== -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".bmp") !== -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".gif") !== -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".jpeg") !== -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".jpg") !== -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".tiff") !== -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".tif") !== -1 ){ DKFileAssociation_OpenImage(file); return true; }
	if(file.indexOf(".osgt") !== -1 ){ DKFileAssociation_OpenModel(file); return true; }
	if(file.indexOf(".osg") !== -1 ){ DKFileAssociation_OpenModel(file); return true; }
	if(file.indexOf(".wav") !== -1 ){ DKFileAssociation_OpenAudio(file); return true; }
	if(file.indexOf(".mp3") !== -1 ){ DKFileAssociation_OpenAudio(file); return true; }
	if(file.indexOf(".avi") !== -1 ){ DKFileAssociation_OpenVideo(file); return true; }
	if(file.indexOf(".mkv") !== -1 ){ DKFileAssociation_OpenVideo(file); return true; }
	if(file.indexOf(".mp4") !== -1 ){ DKFileAssociation_OpenVideo(file); return true; }
	DKFileAssociation_OpenText(file); return true;
}


/////////////////////////////////////////
function DKFileAssociation_OpenHtml(path)
{
	//path = path.replace(absolutepath, "");
	
	var id = path.replace(CPP_DKAssets_LocalAssets(),"");
	//var id = DKFile_GetFilename(path);
	if(DK_Create(id)){
		//DKFileAssociation_AddDragHandles(id);
		DKFrame_Widget(id);
		//DKFileAssociation_SelectElement(id);
	};
	
	
	//FIXME
	return;
	
	//TODO - to use files outside of the data directory, we need to append the datapath
	//var the_path = path.replace(id, "");
	//console.log("DKWidget_AppendDataPath("+the_path+")");
	//AppendDataPath(the_path);

	var filedata = DKFile_FileToString(path);
	if(!filedata){ return false; }
	//if(!HtmlToRml(filedata)){ return false; }

	//Parse the sting into an element
	var temp = DKWidget_CreateElement(document.body, "temp", "temporary");
	byId(temp).innerHTML = filedata;

	//if(DKWidget_GetNumChildren(temp) === 0){
	//	console.error("Error loading path: "+id+": could not create node");
	//	return false;
	//}

	//Make sure there is only 1 child
	//if(DKWidget_GetNumChildren(temp) > 1){
	//	console.error("Error loading path: "+id+" has more than one root node");
	//	return false;
	//}

	console.log("temp: "+temp);
	var element = DKWidget_GetFirstChild(temp);
	console.log("element = "+element);
	//DKElement* element = temp->GetFirstChild();
	//byId(element).id = id;
	
	DKWidget_AppendChild("body", element);
	DKWidget_RemoveElement("temporary");
	//Show(id);
	//DKFileAssociation_AddDragHandles(id);
	//DKFileAssociation_SelectElement(id);
}

///////////////////////////////////////
function DKFileAssociation_OpenJS(path)
{
	//path = path.replace(absolutepath, "");
		
	var id = path.replace(DKAssets_LocalAssets(),"");
	DK_Create(id, function(rval){
		if(!rval){ return; }
		id = id.replace(".js",".html");
		DKFrame_Widget(id);
	});
}

////////////////////////////////////////
function DKFileAssociation_OpenCss(path)
{
	var id = path.replace(CPP_DKAssets_LocalAssets(),"");
	DK_Create(id, function(rval){
		if(!rval){ return; }
	});
}

/////////////////////////////////////////
function DKFileAssociation_OpenText(path)
{
	DKWidget_Toggle("DKNotepad.html");
	DK_Create("DKNotepad/DKNotepad.js", function(){
		DKFrame_Widget("DKNotepad/DKNotepad.html");
		DKNotepad_Open(path);
	});
}

//////////////////////////////////////////
function DKFileAssociation_OpenImage(path)
{
	DK_Create("DKPaint/DKPaint.js", function(){
		DKFrame_Widget("DKPaint/DKPaint.html");
		DKPaint_Open(path);
	});
}

//////////////////////////////////////////
function DKFileAssociation_OpenModel(path)
{
	DK_Create("DKOSGManipulator,,DKOSGWindow", function(){});
	DK_Create("DKOSGModel,,DKWindow,"+path, function(){});
}

//////////////////////////////////////////
function DKFileAssociation_OpenAudio(path)
{
	//var file = DKFile_GetFilename(path);
	DK_Create("DKAudio", function(){
		DKAudio_PlaySound(path);
	});
	
	//DK_Create("DKOSGAudio,"+file+",DKOSGWindow,"+path);
	//DKOSGAudio_Play("DKOSGAudio,"+file);
	
	//DK_Create("DKSDLAudio,"+file+",DKSDLWindow,"+path);
	//DKSDLAudio_Play("DKSDLAudio,"+file);
}

//////////////////////////////////////////
function DKFileAssociation_OpenVideo(path)
{
	//FIXME
	DKVideo_Play(path);
}