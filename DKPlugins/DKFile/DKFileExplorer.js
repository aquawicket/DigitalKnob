var event_type;
var event_id;
var event_data1;
var event_data2;
var aPath;
var rPath;

//////////////////////////////
function DKFileExplorer_Init()
{	
	DKCreate("DKFile/DKFileExplorer.html");
	//DKWidget_Hide("DKFileExplorer.html");
	DKAddEvent("DKFileExplorer.html", "GetFile", DKFileExplorer_OnEvent);
	DKAddEvent("DKFileExplorerUp", "click", DKFileExplorer_OnEvent);
	DKAddEvent("DKFileExplorerOK", "click", DKFileExplorer_OnEvent);
	DKAddEvent("DKFileExplorerClose", "click", DKFileExplorer_OnEvent);
	
	aPath = "";
	rPath = "";
	var drives = DKFile_GetDrives(); //TODO
	DKLog(drives+"\n");
}

/////////////////////////////
function DKFileExplorer_End()
{
	DKClose("DKFileExplorer.html");
}

////////////////////////////////////
function DKFileExplorer_OnEvent(event)
{	
	if(DK_Id(event, "DKFileExplorerClose")){
		//DKClose("DKWidget,DKFileExplorer.html");
		DKWidget_Hide("DKFileExplorer.html");
		return;
	}

	if(DK_IdLike(event, "DKFileExplorerDrive")){
		DKFileExplorer_OpenFolder(DKWidget_GetValue(event));
	}
	if(DK_IdLike(event, "DKFileExplorerFolder")){
		DKFileExplorer_OpenFolder(DKWidget_GetValue(event));
	}
	if(DK_IdLike(event, "DKFileExplorerFile")){
		DKFileExplorer_OpenFile(DKWidget_GetValue(event));
	}

	if(DK_Id(event, "DKFileExplorerUp")){
		var up = DKWidget_GetValue("DKFileExplorerPath")+"/..";
		DKLog(up+"\n");
		DKFileExplorer_OpenFolder(up);
	}
	
	if(DK_Id(event, "DKFileExplorerOK")){
		if(event_data2 == "relative"){
			DKSendEvent(event_id, event_type, rPath);
		}
		else if(event_data2 == "absolute"){
			DKSendEvent(event_id, event_type, aPath);
		}
		else{
			DKLog("DKFileExplorer::ProcessEvent(): return_path_type incorrect. \n");
		}
		DKWidget_Hide("DKFileExplorer.html");
		return;
	}
	
	if(DK_Type(event, "GetFile")){
		var params = DKWidget_GetValue(event).split(",");
		event_id = params[0];
		event_type = params[1];
		event_data1 = params[2];
		event_data2 = params[3];
		DKLog("event_type:"+event_type+"\n");
		DKLog("event_id:"+event_id+"\n");
		DKLog("event_data1:"+event_data1+"\n");
		DKLog("event_data2:"+event_data2+"\n");
	
		DKFileExplorer_UpdatePath(event_data1);
		DKWidget_Show("DKFileExplorer.html");
	}
}

//////////////////////////////////////
function DKFileExplorer_OpenFolder(path)
{
	if(DKFileExplorer_UpdatePath(path)){
		return true;
	}
	return false;
}

////////////////////////////////////
function DKFileExplorer_OpenFile(path)
{
	aPath = DKFile_GetAbsolutePath(path);
	//DKLog("aPath:"+aPath+"\n");
	var datapath = DKAssets_GetDataPath();
	//DKLog("datapath:"+datapath+"\n");
	rPath = DKFile_GetRelativePath(aPath, datapath);
	DKLog("rPath:"+rPath+"\n");
	DKWidget_SetValue("DKFileExplorerPath",aPath);
}

//////////////////////////////////////
function DKFileExplorer_UpdatePath(path)
{
	//if(!path){ return false; }
	DKLog("DKFileExplorer_UpdatePath("+path+") \n");
	aPath = DKFile_GetAbsolutePath(path);
	//DKLog("aPath:"+aPath+"\n");
	var datapath = DKAssets_GetDataPath();
	//DKLog("datapath:"+datapath+"\n");
	rPath = DKFile_GetRelativePath(aPath, datapath);
	//DKLog("rPath:"+rPath+"\n");
	
	var temp = DKFile_DirectoryContents(aPath);
	var files = temp.split(",");

	DKWidget_SetInnerHtml("DKFileExplorerMenu", ""); //Clear it
	DKWidget_SetInnerHtml("DKFileExplorerMenu2", ""); //Clear it

	for(var d=0; d<files.length; d++){
		if(DKFile_IsDirectory(aPath+"/"+files[d])){ //Folders
			var element2 = DKWidget_CreateElement("DKFileExplorerMenu", "option", "DKFileExplorerFolder");
			var value = aPath+"/"+files[d];
			DKWidget_SetAttribute(element2,"value", value);
			DKWidget_SetProperty(element2, "white-space", "nowrap");
			DKAddEvent(element2, "click", DKFileExplorer_OnEvent);
			DKWidget_SetProperty(element2, "padding-left", "17px");
			DKWidget_SetInnerHtml(element2,files[d]);
			DKWidget_SetProperty(element2, "background-image", "url(\"DKFile/folder.png\")");
			DKWidget_SetProperty(element2, "background-repeat", "no-repeat");
		}
	}

	for(var f=0; f<files.length; f++){
		if(!DKFile_IsDirectory(aPath+"/"+files[f])){ //Files
			var element3 = DKWidget_CreateElement("DKFileExplorerMenu", "option", "DKFileExplorerFile");
			var value = aPath+"/"+files[f];
			DKWidget_SetAttribute(element3, "value", value);
			DKWidget_SetProperty(element3, "white-space", "nowrap");
			DKWidget_SetProperty(element3, "padding-left", "17px");
			DKWidget_SetProperty(element3, "background-repeat", "no-repeat");
			DKWidget_SetInnerHtml(element3,files[f]);
			DKAddEvent(element3, "click", DKFileExplorer_OnEvent);

			var extension = DKFile_GetExtention(files[f]);
			if((extension == ".png") || (extension == ".jpeg") || (extension == ".jpg") || 
				(extension == ".bmp") || (extension == ".tiff") || (extension == ".tif") || 
				(extension == ".gif") || (extension == ".tga") || (extension == ".ico")
				){
				DKWidget_SetProperty(element3, "background-image", "url(\"DKFile/picture.png\")");
			}

			else if((extension == ".osg") || (extension == ".osgb") || (extension == ".osgt") ||
				(extension == ".3dm") || (extension == ".3ds") || (extension == ".ac") ||
				(extension == ".ascii") || (extension == ".blend")  || (extension == ".bvh") ||
				(extension == ".c4d") || (extension == ".dae") || (extension == ".dds") ||
				(extension == ".dgn") || (extension == ".dwg") || (extension == ".dxf") ||
				(extension == ".fbx") || (extension == ".lwo") || (extension == ".lws") ||
				(extension == ".ma") || (extension == ".max") || (extension == ".mb") ||
				(extension == ".mesh") || (extension == ".mtl") || (extension == ".obj") ||
				(extension == ".pov") || (extension == ".skp") || (extension == ".stl") ||
				(extension == ".ztl")
			){
				DKWidget_SetProperty(element3, "background-image", "url(\"DKFile/cube.png\")");
			}

			else if((extension == ".html") || (extension == ".htm")){
				DKWidget_SetProperty(element3, "background-image", "url(\"DKFile/html.png\")");
			}

			else{
				DKWidget_SetProperty(element3, "background-image", "url(\"DKFile/file.png\")");
			}
		}
	}
	
	DKWidget_SetValue("DKFileExplorerPath", aPath);
	return true;
}

