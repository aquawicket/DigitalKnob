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
	DKDEBUGFUNC();
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
	console.log(drives);
}

///////////////////////////
function DKSaveFile_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKSaveFile_OnEvent);
	DKClose("DKFile/DKSaveFile.html");
	DKClose("DKFile/DKSaveFile.css");
}

////////////////////////////////////
function DKSaveFile_OnEvent(event)
{	
	DKDEBUGFUNC(event);
	console.debug("DKSaveFile_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")");
	if(DK_IdLike(event, "DKSaveFileDrive")){
		DKSaveFile_OpenFolder(DK_GetValue(event));
	}
	if(DK_IdLike(event, "DKSaveFileFolder")){
		//console.log("DKSaveFileFolder");
		DKSaveFile_OpenFolder(DK_GetValue(event));
	}
	if(DK_IdLike(event, "DKSaveFileFile")){
		DKSaveFile_OpenFile(DK_GetValue(event));
	}

	if(DK_Id(event, "DKSaveFileUp")){
		var up = DKWidget_GetValue("DKSaveFilePath")+"/..";
		//console.log(up);
		DKSaveFile_OpenFolder(up);
	}
	if(DK_Id(event, "DKSaveFileOK")){
	//if(event.currentTarget.id == "DKSaveFileOK"){
		if(rPath && event_data2 == "relative"){
			if(DKFile_IsDirectory(rPath)){
				rPath = rPath+"/"+DKWidget_GetValue("DKSaveFileName");
			}
			console.log("DKSendEvent("+event_id+","+event_type+","+rPath+")");
			DKSendEvent(event_id, event_type, rPath);
		}
		else if(aPath && event_data2 == "absolute"){
			if(DKFile_IsDirectory(aPath)){
				aPath = aPath+"/"+DKWidget_GetValue("DKSaveFileName");
			}
			console.log("DKSendEvent("+event_id+","+event_type+","+aPath+")");
			DKSendEvent(event_id, event_type, aPath);
		}
		else{
			//console.error("DKSaveFile::ProcessEvent(): return_path_type incorrect");
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
		console.log("event_type:"+event_type);
		console.log("event_id:"+event_id);
		console.log("event_data1:"+event_data1);
		console.log("event_data2:"+event_data2);
	
		DKSaveFile_UpdatePath(event_data1);
	}
	
	if(DK_Id(event, "DKSaveFilePath")){
		console.log("DKSaveFilePath");
		//var path = DKWidget_GetAttribute("DKSaveFilePath", "value");
		//DKSaveFile_UpdatePath(path);
	}
}

/*
//////////////////////////////////////
function DKSaveFile_GetFIle(callback)
{
	DKDEBUGFUNC(callback);
	DKSaveFile_callback = callback;
}
*/

//////////////////////////////////////
function DKSaveFile_OpenFolder(path)
{
	DKDEBUGFUNC(path);
	if(DKSaveFile_UpdatePath(path)){
		return true;
	}
	return false;
}

////////////////////////////////////
function DKSaveFile_OpenFile(path)
{
	DKDEBUGFUNC(path);
	if(DK_GetOS() == "Android"){
		aPath = path;
	}
	else{
		aPath = DKFile_GetAbsolutePath(path);
	}
	console.log("aPath:"+aPath);
	var assets = DKAssets_LocalAssets();
	//console.log("assets:"+assets);
	rPath = DKFile_GetRelativePath(aPath, assets);
	console.log("rPath:"+rPath);
	DKWidget_SetValue("DKSaveFilePath",aPath);
}

//////////////////////////////////////
function DKSaveFile_UpdatePath(path)
{
	DKDEBUGFUNC(path);
	//if(!path){ return false; }
	console.log("DKSaveFile_UpdatePath("+path+")");
	if(DK_GetOS() == "Android"){
		aPath = path;
	}
	else{
		aPath = DKFile_GetAbsolutePath(path);
	}
	console.log("aPath:"+aPath);
	//var assets = DKAssets_LocalAssets();
	//console.log("assets:"+assets);
	rPath = DKFile_GetRelativePath(aPath, path);
	console.log("rPath:"+rPath);
	
	var temp = DKFile_DirectoryContents(aPath);
	var files = temp.split(",");

	document.getElementById("DKSaveFileMenu").innerHTML = "";
	document.getElementById("DKSaveFileMenu2").innerHTML = "";

	for(var d=0; d<files.length; d++){
		if(DKFile_IsDirectory(aPath+"/"+files[d])){ //Folders
			var element2 = DKWidget_CreateElement("DKSaveFileMenu2", "option", "DKSaveFileFolder");
			var value = aPath+"/"+files[d];
			document.getElementById(element2).value = value;
			document.getElementById(element2).style.whiteSpace = "nowrap";
			DKAddEvent(element2, "click", DKSaveFile_OnEvent);
			document.getElementById(element2).style.paddingLeft = "17px";
			document.getElementById(element2).innerHTML = files[d];
			document.getElementById(element2).style.backgroundImage = "url(\"DKFile/folder.png\")";
			document.getElementById(element2).style.backgroundRepeat = "no-repeat";
		}
	}

	for(var f=0; f<files.length; f++){
		if(!DKFile_IsDirectory(aPath+"/"+files[f])){ //Files
			var element3 = DKWidget_CreateElement("DKSaveFileMenu2", "option", "DKSaveFileFile");
			var value = aPath+"/"+files[f];
			document.getElementById(element3).value = value;
			document.getElementById(element3).style.whiteSpace = "nowrap";
			document.getElementById(element3).style.paddingLeft = "17px";
			document.getElementById(element3).style.backgroundRepeat = "no-repeat";
			document.getElementById(element3).innerHTML = files[f];
			DKAddEvent(element3, "click", DKSaveFile_OnEvent);

			var extension = DKFile_GetExtention(files[f]);
			if((extension == "png") || (extension == "jpeg") || (extension == "jpg") || 
				(extension == "bmp") || (extension == "tiff") || (extension == "tif") || 
				(extension == "gif") || (extension == "tga") || (extension == "ico")
				){
				document.getElementById(element3).style.backgroundImage = "url(\"DKFile/picture.png\")";
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
				document.getElementById(element3).style.backgroundImage = "url(\"DKFile/cube.png\")";
			}

			else if((extension == "html") || (extension == "htm")){
				document.getElementById(element3).style.backgroundImage = "url(\"DKFile/html.png\")";
			}

			else{
				document.getElementById(element3).style.backgroundImage = "url(\"DKFile/file.png\")";
			}
		}
	}
	
	document.getElementById("DKSaveFilePath").value = aPath;
	return true;
}