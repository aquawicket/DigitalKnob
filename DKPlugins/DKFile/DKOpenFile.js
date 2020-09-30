var event_type;
var event_id;
var event_data1;
var event_data2;
var aPath;
var rPath;

//////////////////////////
function DKOpenFile_Init()
{	
	DKCreate("DKFile/DKOpenFile.css");
	DKCreate("DKFile/DKOpenFile.html");
	byId("DKFile/DKOpenFile.html").addEventListener("GetFile", DKOpenFile_OnEvent);
	byId("DKFile/DKOpenFile.html").addEventListener("GetFile", DKOpenFile_OnEvent);
	byId("DKOpenFileCancel").addEventListener("click", DKOpenFile_OnEvent);
	byId("DKOpenFileOK").addEventListener("click", DKOpenFile_OnEvent);
	byId("DKOpenFileUp").addEventListener("click", DKOpenFile_OnEvent);
	byId("DKOpenFilePath").addEventListener("change", DKOpenFile_OnEvent);
	
	aPath = "";
	rPath = "";
	
	//TODO
	//var drives = DKFile_GetDrives();
	//console.log(drives);
}

/////////////////////////
function DKOpenFile_End()
{
	byId("DKFile/DKOpenFile.html").removeEventListener("GetFile", DKOpenFile_OnEvent);
	byId("DKFile/DKOpenFile.html").removeEventListener("GetFile", DKOpenFile_OnEvent);
	byId("DKOpenFileCancel").removeEventListener("click", DKOpenFile_OnEvent);
	byId("DKOpenFileOK").removeEventListener("click", DKOpenFile_OnEvent);
	byId("DKOpenFileUp").removeEventListener("click", DKOpenFile_OnEvent);
	byId("DKOpenFilePath").removeEventListener("change", DKOpenFile_OnEvent);
	DKClose("DKFile/DKOpenFile.html");
	DKClose("DKFile/DKOpenFile.css");
}

//////////////////////////////////
function DKOpenFile_OnEvent(event)
{	
	if(!event.currentTarget){ return; }
	if(event.currentTarget.id.includes("DKOpenFileDrive")){
		DKOpenFile_OpenFolder(DK_GetValue(event));
	}
	if(event.currentTarget.id.includes("DKOpenFileFolder")){
		DKOpenFile_OpenFolder(DKWidget_GetValue(event));
	}
	if(event.currentTarget.id && event.currentTarget.id.includes("DKOpenFileFile")){
		DKOpenFile_OpenFile(DKWidget_GetValue(event));
	}

	if(event.currentTarget.id === "DKOpenFileUp"){
		var up = DKWidget_GetValue("DKOpenFilePath")+"/..";
		//console.log(up);
		DKOpenFile_OpenFolder(up);
	}
	
	if(event.currentTarget.id === "DKOpenFileOK"){
		if(rPath && event_data2 === "relative"){
			//console.log("DKSendEvent("+event_id+","+event_type+","+rPath+")");
			DKSendEvent(event_id, event_type, rPath);
		}
		else if(aPath && event_data2 === "absolute"){
			//console.log("DKSendEvent("+event_id+","+event_type+","+aPath+")");
			DKSendEvent(event_id, event_type, aPath);
		}
		else{
			//console.error("DKOpenFile::ProcessEvent(): return_path_type incorrect");
		}
		
		DKFrame_Close("DKFile/DKOpenFile.html");
		return;
	}
	
	if(event.currentTarget.id === "DKOpenFileCancel"){
		DKFrame_Close("DKFile/DKOpenFile.html");
		return;
	}
	
	if(event.currentTarget.id === "GetFile"){
		console.log("GetFile was called");
		var params = event.value.split(",");
		event_id = params[0];
		event_type = params[1];
		event_data1 = params[2];
		event_data2 = params[3];
		//console.log("event_type:"+event_type);
		//console.log("event_id:"+event_id);
		//console.log("event_data1:"+event_data1);
		//console.log("event_data2:"+event_data2);
	
		DKOpenFile_UpdatePath(event_data1);
	}
	
	if(event.currentTarget.id === "DKOpenFilePath"){
		console.log("DKOpenFilePath");
		//var path = byId("DKOpenFilePath").value;
		//DKOpenFile_UpdatePath(path);
	}
}

///////////////////////////////////////////
function DKOpenFile_GetFile(path, callback)
{
	//TODO
	//DKOpenFile_UpdatePath(path);
	//DKOpenFile_callback = callback;
}

////////////////////////////////////
function DKOpenFile_OpenFolder(path)
{
	if(DKOpenFile_UpdatePath(path)){
		return true;
	}
	return false;
}

//////////////////////////////////
function DKOpenFile_OpenFile(path)
{
	if(DK_GetOS() === "Android"){
		aPath = path;
	}
	else{
		aPath = DKFile_GetAbsolutePath(path);
	}
	//console.log("aPath:"+aPath);
	var assets = DKAssets_LocalAssets();
	//console.log("assets:"+assets);
	rPath = DKFile_GetRelativePath(aPath, assets);
	//console.log("rPath:"+rPath);
	DKWidget_SetValue("DKOpenFilePath",aPath);
}

////////////////////////////////////
function DKOpenFile_UpdatePath(path)
{
	//if(!path){ return false; }
	//console.log("DKOpenFile_UpdatePath("+path+")");
	if(DK_GetOS() === "Android"){
		aPath = path;
	}
	else{
		aPath = DKFile_GetAbsolutePath(path);
	}
	//console.log("aPath:"+aPath);
	//var assets = DKAssets_LocalAssets();
	//console.log("assets:"+assets);
	rPath = DKFile_GetRelativePath(aPath, path);
	//console.log("rPath:"+rPath);
	
	var temp = DKFile_DirectoryContents(aPath);
	var files = temp.split(",");

	byId("DKOpenFileMenu").innerHTML = ""; //Clear it
	byId("DKOpenFileMenu2").innerHTML = ""; //Clear it

	for(var d=0; d<files.length; d++){
		if(DKFile_IsDirectory(aPath+"/"+files[d])){ //Folders
			var element2 = DKWidget_CreateElement(byId("DKOpenFileMenu2"), "option", "DKOpenFileFolder");
			var value = aPath+"/"+files[d];
			byId(element2).value = value;
			byId(element2).style.whiteSpace = "nowrap";
			byId(element2).addEventListener("click", DKOpenFile_OnEvent);
			byId(element2).style.paddingLeft = "17px";
			byId(element2).innerHTML = files[d];
			byId(element2).style.backgroundImage = "url(\"DKFile/folder.png\")";
			byId(element2).style.backgroundRepeat = "no-repeat";
		}
	}

	for(var f=0; f<files.length; f++){
		if(!DKFile_IsDirectory(aPath+"/"+files[f])){ //Files
			var element3 = DKWidget_CreateElement(byId("DKOpenFileMenu2"), "option", "DKOpenFileFile");
			var value = aPath+"/"+files[f];
			byId(element3).value = value;
			byId(element3).style.whiteSpace = "nowrap";
			byId(element3).style.paddingLeft = "17px";
			byId(element3).style.backgroundRepeat = "no-repeat";
			byId(element3).innerHTML = files[f];
			byId(element3).addEventListener("click", DKOpenFile_OnEvent);

			var extension = DKFile_GetExtention(files[f]);
			if((extension === "png") || (extension === "jpeg") || (extension === "jpg") || 
				(extension === "bmp") || (extension === "tiff") || (extension === "tif") || 
				(extension === "gif") || (extension === "tga") || (extension === "ico")
				){
				byId(element3).style.backgroundImage = "url(\"DKFile/picture.png\")";
			}

			else if((extension === "osg") || (extension === "osgb") || (extension === "osgt") ||
				(extension === "3dm") || (extension === "3ds") || (extension === "ac") ||
				(extension === "ascii") || (extension === "blend")  || (extension === "bvh") ||
				(extension === "c4d") || (extension === "dae") || (extension === "dds") ||
				(extension === "dgn") || (extension === "dwg") || (extension === "dxf") ||
				(extension === "fbx") || (extension === "lwo") || (extension === "lws") ||
				(extension === "ma") || (extension === "max") || (extension === "mb") ||
				(extension === "mesh") || (extension === "mtl") || (extension === "obj") ||
				(extension === "pov") || (extension === "skp") || (extension === "stl") ||
				(extension === "ztl")
			){
				byId(element3).style.backgroundImage = "url(\"DKFile/cube.png\")";
			}

			else if((extension === "html") || (extension === "htm")){
				byId(element3).style.backgroundImage = "url(\"DKFile/html.png\")";
			}

			else{
				byId(element3).style.backgroundImage = "url(\"DKFile/file.png\")";
			}
		}
	}
	
	DKWidget_SetValue("DKOpenFilePath", aPath);
	return true;
}