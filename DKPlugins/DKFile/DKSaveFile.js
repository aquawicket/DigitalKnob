var event_type;
var event_id;
var event_data1;
var event_data2;
var aPath;
var rPath;

//var DKSaveFile_callback;

////////////////////////////
function DKSaveFile_Init()
{	
	//DKLog("DKSaveFile_Init()\n");

	DKCreate("DKFile/DKSaveFile.css");
	DKCreate("DKFile/DKSaveFile.html");
	DKAddEvent("DKFile/DKSaveFile.html", "SetFile", DKSaveFile_OnEvent);
	DKAddEvent("DKSaveFileCancel", "click", DKSaveFile_OnEvent);
	DKAddEvent("DKSaveFileOK", "click", DKSaveFile_OnEvent);
	DKAddEvent("DKSaveFileUp", "click", DKSaveFile_OnEvent);
	DKAddEvent("DKSaveFilePath", "input", DKSaveFile_OnEvent);
	
	aPath = "";
	rPath = "";
	var drives = DKFile_GetDrives(); //TODO
	DKLog(drives+"\n");
}

///////////////////////////
function DKSaveFile_End()
{
	//DKLog("DKSaveFile_End()\n");
	
	DKRemoveEvents(DKSaveFile_OnEvent);
	DKClose("DKFile/DKSaveFile.html");
	DKClose("DKFile/DKSaveFile.css");
}

////////////////////////////////////
function DKSaveFile_OnEvent(event)
{	
	//DKLog("DKSaveFile_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");

	if(DK_IdLike(event, "DKSaveFileDrive")){
		DKSaveFile_OpenFolder(DK_GetValue(event));
	}
	if(DK_IdLike(event, "DKSaveFileFolder")){
		//DKLog("DKSaveFileFolder");
		DKSaveFile_OpenFolder(DK_GetValue(event));
	}
	if(DK_IdLike(event, "DKSaveFileFile")){
		DKSaveFile_OpenFile(DK_GetValue(event));
	}

	if(DK_Id(event, "DKSaveFileUp")){
		var up = DKWidget_GetValue("DKSaveFilePath")+"/..";
		//DKLog(up+"\n");
		DKSaveFile_OpenFolder(up);
	}
	
	if(DK_Id(event, "DKSaveFileOK")){
		if(rPath && event_data2 == "relative"){
			if(DKFile_IsDirectory(rPath)){
				rPath = rPath+"/"+DKWidget_GetValue("DKSaveFileName");
			}
			DKLog("DKSendEvent("+event_id+","+event_type+","+rPath+")\n");
			DKSendEvent(event_id, event_type, rPath);
		}
		else if(aPath && event_data2 == "absolute"){
			if(DKFile_IsDirectory(aPath)){
				aPath = aPath+"/"+DKWidget_GetValue("DKSaveFileName");
			}
			DKLog("DKSendEvent("+event_id+","+event_type+","+aPath+")\n");
			DKSendEvent(event_id, event_type, aPath);
		}
		else{
			//DKLog("DKSaveFile::ProcessEvent(): return_path_type incorrect. \n", DKERROR);
		}
		
		DKFrame_Close("DKFile/DKSaveFile.html");
		return;
	}
	
	if(DK_Id(event, "DKSaveFileCancel")){
		DKFrame_Close("DKFile/DKSaveFile.html");
		return;
	}
	
	if(DK_Type(event, "SetFile")){
		var params = DK_GetValue(event).split(",");
		event_id = params[0];
		event_type = params[1];
		event_data1 = params[2];
		event_data2 = params[3];
		DKLog("event_type:"+event_type+"\n");
		DKLog("event_id:"+event_id+"\n");
		DKLog("event_data1:"+event_data1+"\n");
		DKLog("event_data2:"+event_data2+"\n");
	
		DKSaveFile_UpdatePath(event_data1);
	}
	
	if(DK_Id(event, "DKSaveFilePath")){
		DKLog("DKSaveFilePath\n");
		//var path = DKWidget_GetAttribute("DKSaveFilePath", "value");
		//DKSaveFile_UpdatePath(path);
	}
}

/*
//////////////////////////////////////
function DKSaveFile_GetFIle(callback)
{
		DKSaveFile_callback = callback;
}
*/

//////////////////////////////////////
function DKSaveFile_OpenFolder(path)
{
	//DKLog("DKSaveFile_OpenFolder("+path+")\n");
	
	if(DKSaveFile_UpdatePath(path)){
		return true;
	}
	return false;
}

////////////////////////////////////
function DKSaveFile_OpenFile(path)
{
	//DKLog("DKSaveFile_OpenFile("+path+")\n");
	
	if(DK_GetOS() == "Android"){
		aPath = path;
	}
	else{
		aPath = DKFile_GetAbsolutePath(path);
	}
	DKLog("aPath:"+aPath+"\n");
	var assets = DKAssets_LocalAssets();
	//DKLog("assets:"+assets+"\n");
	rPath = DKFile_GetRelativePath(aPath, assets);
	DKLog("rPath:"+rPath+"\n");
	DKWidget_SetValue("DKSaveFilePath",aPath);
}

//////////////////////////////////////
function DKSaveFile_UpdatePath(path)
{
	//DKLog("DKSaveFile_UpdatePath("+path+")\n");
	
	//if(!path){ return false; }
	DKLog("DKSaveFile_UpdatePath("+path+") \n");
	if(DK_GetOS() == "Android"){
		aPath = path;
	}
	else{
		aPath = DKFile_GetAbsolutePath(path);
	}
	DKLog("aPath:"+aPath+"\n");
	//var assets = DKAssets_LocalAssets();
	//DKLog("assets:"+assets+"\n");
	rPath = DKFile_GetRelativePath(aPath, path);
	DKLog("rPath:"+rPath+"\n");
	
	var temp = DKFile_DirectoryContents(aPath);
	var files = temp.split(",");

	DKWidget_SetInnerHtml("DKSaveFileMenu", ""); //Clear it
	DKWidget_SetInnerHtml("DKSaveFileMenu2", ""); //Clear it

	for(var d=0; d<files.length; d++){
		if(DKFile_IsDirectory(aPath+"/"+files[d])){ //Folders
			var element2 = DKWidget_CreateElement("DKSaveFileMenu2", "option", "DKSaveFileFolder");
			var value = aPath+"/"+files[d];
			DKWidget_SetAttribute(element2,"value", value);
			DKWidget_SetProperty(element2, "white-space", "nowrap");
			DKAddEvent(element2, "click", DKSaveFile_OnEvent);
			DKWidget_SetProperty(element2, "padding-left", "17px");
			DKWidget_SetInnerHtml(element2,files[d]);
			DKWidget_SetProperty(element2, "background-image", "url(\"DKFile/folder.png\")");
			DKWidget_SetProperty(element2, "background-repeat", "no-repeat");
		}
	}

	for(var f=0; f<files.length; f++){
		if(!DKFile_IsDirectory(aPath+"/"+files[f])){ //Files
			var element3 = DKWidget_CreateElement("DKSaveFileMenu2", "option", "DKSaveFileFile");
			var value = aPath+"/"+files[f];
			DKWidget_SetAttribute(element3, "value", value);
			DKWidget_SetProperty(element3, "white-space", "nowrap");
			DKWidget_SetProperty(element3, "padding-left", "17px");
			DKWidget_SetProperty(element3, "background-repeat", "no-repeat");
			DKWidget_SetInnerHtml(element3,files[f]);
			DKAddEvent(element3, "click", DKSaveFile_OnEvent);

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
	
	DKWidget_SetValue("DKSaveFilePath", aPath);
	return true;
}