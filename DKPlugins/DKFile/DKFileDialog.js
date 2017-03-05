var event_type;
var event_id;
var event_data1;
var event_data2;
var aPath;
var rPath;

//var DKFileDialog_callback;

////////////////////////////
function DKFileDialog_Init()
{	
	DKCreate("DKFile/DKFileDialog.html");
	DKAddEvent("DKFileDialog.html", "GetFile", DKFileDialog_OnEvent);
	DKAddEvent("DKFileDialogCancel", "click", DKFileDialog_OnEvent);
	DKAddEvent("DKFileDialogOK", "click", DKFileDialog_OnEvent);
	DKAddEvent("DKFileDialogUp", "click", DKFileDialog_OnEvent);
	
	aPath = "";
	rPath = "";
	var drives = DKFile_GetDrives(); //TODO
	DKLog(drives+"\n", DKDEBUG);
}

///////////////////////////
function DKFileDialog_End()
{
	DKRemoveEvent("DKFileDialog.html", "GetFile", DKFileDialog_OnEvent);
	DKRemoveEvent("DKFileDialogCancel", "click", DKFileDialog_OnEvent);
	DKRemoveEvent("DKFileDialogOK", "click", DKFileDialog_OnEvent);
	DKRemoveEvent("DKFileDialogUp", "click", DKFileDialog_OnEvent);
	DKClose("DKFileDialog.html");
}

////////////////////////////////////
function DKFileDialog_OnEvent(event)
{	
	DKLog("DKFileDialog_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);

	if(DK_IdLike(event, "DKFileDialogDrive")){
		DKFileDialog_OpenFolder(DKWidget_GetValue(event));
	}
	if(DK_IdLike(event, "DKFileDialogFolder")){
		DKLog("DKFileDialogFolder", DKINFO);
		DKFileDialog_OpenFolder(DKWidget_GetValue(event));
	}
	if(DK_IdLike(event, "DKFileDialogFile")){
		DKFileDialog_OpenFile(DKWidget_GetValue(event));
	}

	if(DK_Id(event, "DKFileDialogUp")){
		var up = DKWidget_GetValue("DKFileDialogPath")+"/..";
		DKLog(up+"\n", DKDEBUG);
		DKFileDialog_OpenFolder(up);
	}
	
	if(DK_Id(event, "DKFileDialogOK")){
		if(rPath && event_data2 == "relative"){
			DKSendEvent(event_id, event_type, rPath);
		}
		else if(aPath && event_data2 == "absolute"){
			DKSendEvent(event_id, event_type, aPath);
		}
		else{
			//DKLog("DKFileDialog::ProcessEvent(): return_path_type incorrect. \n", DKERROR);
		}
		
		DKFrame_Close("DKFileDialog.html");
		return;
	}
	
	if(DK_Id(event, "DKFileDialogCancel")){
		DKFrame_Close("DKFileDialog.html");
		return;
	}
	
	if(DK_Type(event, "GetFile")){
		var params = DKWidget_GetValue(event).split(",");
		event_id = params[0];
		event_type = params[1];
		event_data1 = params[2];
		event_data2 = params[3];
		DKLog("event_type:"+event_type+"\n", DKINFO);
		DKLog("event_id:"+event_id+"\n", DKINFO);
		DKLog("event_data1:"+event_data1+"\n", DKINFO);
		DKLog("event_data2:"+event_data2+"\n", DKINFO);
	
		DKFileDialog_UpdatePath(event_data1);
	}
}

/*
//////////////////////////////////////
function DKFileDialog_GetFIle(callback)
{
		DKFileDialog_callback = callback;
}
*/

//////////////////////////////////////
function DKFileDialog_OpenFolder(path)
{
	DKLog("DKFileDialog_OpenFolder("+path+") \n", DKINFO);
	if(DKFileDialog_UpdatePath(path)){
		return true;
	}
	return false;
}

////////////////////////////////////
function DKFileDialog_OpenFile(path)
{
	DKLog("DKFileDialog_OpenFile("+path+") \n", DKDEBUG);
	if(DK_GetOS() == "Android"){
		aPath = path;
	}
	else{
		aPath = DKFile_GetAbsolutePath(path);
	}
	DKLog("aPath:"+aPath+"\n", DKDEBUG);
	var assets = DKAssets_LocalAssets();
	//DKLog("assets:"+assets+"\n", DKDEBUG);
	rPath = DKFile_GetRelativePath(aPath, assets);
	DKLog("rPath:"+rPath+"\n", DKDEBUG);
	DKWidget_SetValue("DKFileDialogPath",aPath);
}

//////////////////////////////////////
function DKFileDialog_UpdatePath(path)
{
	//if(!path){ return false; }
	DKLog("DKFileDialog_UpdatePath("+path+") \n", DKDEBUG);
	if(DK_GetOS() == "Android"){
		aPath = path;
	}
	else{
		aPath = DKFile_GetAbsolutePath(path);
	}
	DKLog("aPath:"+aPath+"\n", DKDEBUG);
	//var assets = DKAssets_LocalAssets();
	//DKLog("assets:"+assets+"\n", DKDEBUG);
	rPath = DKFile_GetRelativePath(aPath, path);
	DKLog("rPath:"+rPath+"\n", DKDEBUG);
	
	var temp = DKFile_DirectoryContents(aPath);
	var files = temp.split(",");

	DKWidget_SetInnerHtml("DKFileDialogMenu", ""); //Clear it
	DKWidget_SetInnerHtml("DKFileDialogMenu2", ""); //Clear it

	for(var d=0; d<files.length; d++){
		if(DKFile_IsDirectory(aPath+"/"+files[d])){ //Folders
			var element2 = DKWidget_CreateElement("DKFileDialogMenu2", "option", "DKFileDialogFolder");
			var value = aPath+"/"+files[d];
			DKWidget_SetAttribute(element2,"value", value);
			DKWidget_SetProperty(element2, "white-space", "nowrap");
			DKAddEvent(element2, "click", DKFileDialog_OnEvent);
			DKWidget_SetProperty(element2, "padding-left", "17px");
			DKWidget_SetInnerHtml(element2,files[d]);
			DKWidget_SetProperty(element2, "background-image", "url(\"DKFile/folder.png\")");
			DKWidget_SetProperty(element2, "background-repeat", "no-repeat");
		}
	}

	for(var f=0; f<files.length; f++){
		if(!DKFile_IsDirectory(aPath+"/"+files[f])){ //Files
			var element3 = DKWidget_CreateElement("DKFileDialogMenu2", "option", "DKFileDialogFile");
			var value = aPath+"/"+files[f];
			DKWidget_SetAttribute(element3, "value", value);
			DKWidget_SetProperty(element3, "white-space", "nowrap");
			DKWidget_SetProperty(element3, "padding-left", "17px");
			DKWidget_SetProperty(element3, "background-repeat", "no-repeat");
			DKWidget_SetInnerHtml(element3,files[f]);
			DKAddEvent(element3, "click", DKFileDialog_OnEvent);

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
	
	DKWidget_SetValue("DKFileDialogPath", aPath);
	return true;
}

