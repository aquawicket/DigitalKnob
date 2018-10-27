var event_type;
var event_id;
var event_data1;
var event_data2;
var aPath;
var rPath;

//////////////////////////
function DKOpenFile_Init()
{	
	DKDEBUGFUNC();
	DKCreate("DKFile/DKOpenFile.css");
	DKCreate("DKFile/DKOpenFile.html");
	DKAddEvent("DKFile/DKOpenFile.html", "GetFile", DKOpenFile_OnEvent);
	DKAddEvent("DKOpenFileCancel", "click", DKOpenFile_OnEvent);
	DKAddEvent("DKOpenFileOK", "click", DKOpenFile_OnEvent);
	DKAddEvent("DKOpenFileUp", "click", DKOpenFile_OnEvent);
	DKAddEvent("DKOpenFilePath", "change", DKOpenFile_OnEvent);
	
	aPath = "";
	rPath = "";
	
	//TODO
	//var drives = DKFile_GetDrives();
	//DKINFO(drives+"\n");
}

/////////////////////////
function DKOpenFile_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKOpenFile_OnEvent);
	DKClose("DKFile/DKOpenFile.html");
	DKClose("DKFile/DKOpenFile.css");
}

//////////////////////////////////
function DKOpenFile_OnEvent(event)
{	
	DKDEBUGFUNC(event);
	if(DK_IdLike(event, "DKOpenFileDrive")){
		DKOpenFile_OpenFolder(DK_GetValue(event));
	}
	if(DK_IdLike(event, "DKOpenFileFolder")){
		//DKINFO("DKOpenFileFolder\n");
		DKOpenFile_OpenFolder(DK_GetValue(event));
	}
	if(DK_IdLike(event, "DKOpenFileFile")){
		DKOpenFile_OpenFile(DK_GetValue(event));
	}

	if(DK_Id(event, "DKOpenFileUp")){
		var up = DKWidget_GetValue("DKOpenFilePath")+"/..";
		//DKINFO(up+"\n");
		DKOpenFile_OpenFolder(up);
	}
	
	if(DK_Id(event, "DKOpenFileOK")){
		if(rPath && event_data2 == "relative"){
			//DKINFO("DKSendEvent("+event_id+","+event_type+","+rPath+")\n");
			DKSendEvent(event_id, event_type, rPath);
		}
		else if(aPath && event_data2 == "absolute"){
			//DKINFO("DKSendEvent("+event_id+","+event_type+","+aPath+")\n");
			DKSendEvent(event_id, event_type, aPath);
		}
		else{
			//DKERROR("DKOpenFile::ProcessEvent(): return_path_type incorrect\n");
		}
		
		DKFrame_Close("DKFile/DKOpenFile.html");
		return;
	}
	
	if(DK_Id(event, "DKOpenFileCancel")){
		DKFrame_Close("DKFile/DKOpenFile.html");
		return;
	}
	
	if(DK_Type(event, "GetFile")){
		var params = DKWidget_GetValue(event).split(",");
		event_id = params[0];
		event_type = params[1];
		event_data1 = params[2];
		event_data2 = params[3];
		//DKINFO("event_type:"+event_type+"\n");
		//DKINFO("event_id:"+event_id+"\n");
		//DKINFO("event_data1:"+event_data1+"\n");
		//DKINFO("event_data2:"+event_data2+"\n");
	
		DKOpenFile_UpdatePath(event_data1);
	}
	
	if(DK_Id(event, "DKOpenFilePath")){
		DKINFO("DKOpenFilePath\n");
		//var path = DKWidget_GetAttribute("DKOpenFilePath", "value");
		//DKOpenFile_UpdatePath(path);
	}
}

////////////////////////////////////
function DKOpenFile_OpenFolder(path)
{
	DKDEBUGFUNC(path);
	if(DKOpenFile_UpdatePath(path)){
		return true;
	}
	return false;
}

//////////////////////////////////
function DKOpenFile_OpenFile(path)
{
	DKDEBUGFUNC(path);
	if(DK_GetOS() == "Android"){
		aPath = path;
	}
	else{
		aPath = DKFile_GetAbsolutePath(path);
	}
	//DKINFO("aPath:"+aPath+"\n");
	var assets = DKAssets_LocalAssets();
	//DKINFO("assets:"+assets+"\n");
	rPath = DKFile_GetRelativePath(aPath, assets);
	//DKINFO("rPath:"+rPath+"\n");
	DKWidget_SetValue("DKOpenFilePath",aPath);
}

////////////////////////////////////
function DKOpenFile_UpdatePath(path)
{
	DKDEBUGFUNC(path);
	//if(!path){ return false; }
	//DKINFO("DKOpenFile_UpdatePath("+path+")\n");
	if(DK_GetOS() == "Android"){
		aPath = path;
	}
	else{
		aPath = DKFile_GetAbsolutePath(path);
	}
	//DKINFO("aPath:"+aPath+"\n");
	//var assets = DKAssets_LocalAssets();
	//DKINFO("assets:"+assets+"\n");
	rPath = DKFile_GetRelativePath(aPath, path);
	//DKINFO("rPath:"+rPath+"\n");
	
	var temp = DKFile_DirectoryContents(aPath);
	var files = temp.split(",");

	DKWidget_SetInnerHtml("DKOpenFileMenu", ""); //Clear it
	DKWidget_SetInnerHtml("DKOpenFileMenu2", ""); //Clear it

	for(var d=0; d<files.length; d++){
		if(DKFile_IsDirectory(aPath+"/"+files[d])){ //Folders
			var element2 = DKWidget_CreateElement("DKOpenFileMenu2", "option", "DKOpenFileFolder");
			var value = aPath+"/"+files[d];
			DKWidget_SetAttribute(element2,"value", value);
			DKWidget_SetProperty(element2, "white-space", "nowrap");
			DKAddEvent(element2, "click", DKOpenFile_OnEvent);
			DKWidget_SetProperty(element2, "padding-left", "17px");
			DKWidget_SetInnerHtml(element2,files[d]);
			DKWidget_SetProperty(element2, "background-image", "url(\"DKFile/folder.png\")");
			DKWidget_SetProperty(element2, "background-repeat", "no-repeat");
		}
	}

	for(var f=0; f<files.length; f++){
		if(!DKFile_IsDirectory(aPath+"/"+files[f])){ //Files
			var element3 = DKWidget_CreateElement("DKOpenFileMenu2", "option", "DKOpenFileFile");
			var value = aPath+"/"+files[f];
			DKWidget_SetAttribute(element3, "value", value);
			DKWidget_SetProperty(element3, "white-space", "nowrap");
			DKWidget_SetProperty(element3, "padding-left", "17px");
			DKWidget_SetProperty(element3, "background-repeat", "no-repeat");
			DKWidget_SetInnerHtml(element3,files[f]);
			DKAddEvent(element3, "click", DKOpenFile_OnEvent);

			var extension = DKFile_GetExtention(files[f]);
			if((extension == "png") || (extension == "jpeg") || (extension == "jpg") || 
				(extension == "bmp") || (extension == "tiff") || (extension == "tif") || 
				(extension == "gif") || (extension == "tga") || (extension == "ico")
				){
				DKWidget_SetProperty(element3, "background-image", "url(\"DKFile/picture.png\")");
			}

			else if((extension == "osg") || (extension == "osgb") || (extension == "osgt") ||
				(extension == "3dm") || (extension == "3ds") || (extension == "ac") ||
				(extension == "ascii") || (extension == "blend")  || (extension == "bvh") ||
				(extension == "c4d") || (extension == "dae") || (extension == "dds") ||
				(extension == "dgn") || (extension == "dwg") || (extension == "dxf") ||
				(extension == "fbx") || (extension == "lwo") || (extension == "lws") ||
				(extension == "ma") || (extension == "max") || (extension == "mb") ||
				(extension == "mesh") || (extension == "mtl") || (extension == "obj") ||
				(extension == "pov") || (extension == "skp") || (extension == "stl") ||
				(extension == "ztl")
			){
				DKWidget_SetProperty(element3, "background-image", "url(\"DKFile/cube.png\")");
			}

			else if((extension == "html") || (extension == "htm")){
				DKWidget_SetProperty(element3, "background-image", "url(\"DKFile/html.png\")");
			}

			else{
				DKWidget_SetProperty(element3, "background-image", "url(\"DKFile/file.png\")");
			}
		}
	}
	
	DKWidget_SetValue("DKOpenFilePath", aPath);
	return true;
}