var event_type;
var event_id;
var event_data1;
var event_data2;
var aPath;
var rPath;

//////////////////////////
function DKSolution_Init()
{	
	DKCreate("DKBuild/DKSolution.html");
	DKAddEvent("DKSolutionUp", "click", DKSolution_OnEvent);
	DKAddEvent("DKSolution.html", "contextmenu", DKSolution_OnEvent);
	
	aPath = "";
	rPath = "";
	
	DKSolution_UpdatePath(DKPATH); //DKPATH from DKBuild.js
}

/////////////////////////
function DKSolution_End()
{
	DKRemoveEvent("DKSolutionUp", "click", DKSolution_OnEvent);
	DKClose("DKSolution.html");
}

//////////////////////////////////
function DKSolution_OnEvent(event)
{	
	//DKLog("DKSolution_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKINFO);
	
	if(DK_IdLike(event, "DKSolutionFolder") || DK_IdLike(event, "DKSolutionFiles")){
		//DKWidget_SetProperty(DK_GetId(event), "background-color", "rgb(123,157,212)");
		//DKWidget_SetProperty(DK_GetId(event), "color", "rgb(255,255,255)");
	}
		
	if(DK_Type(event, "contextmenu")){
		//DKLog("DKSolution_OnEvent() contextmenu\n", DKINFO);	
		StopPropagation(event);
		DKCreate("DKBuild/DKSolutionMenu.js", function(){
			var file = DKWidget_GetValue(DK_GetId(event));
			DKSolutionMenu_SetId(DK_GetId(event));
			DKSolutionMenu_SetFile(file);
		});
		return;
	}
		
	if(DK_Id(event, "DKSolutionUp")){
		var up = DKWidget_GetValue("DKSolutionPath")+"/..";
		//DKLog(up+"\n", DKDEBUG);
		DKSolution_OpenFolder(up);
	}
	
	if(DK_Type(event, "dblclick")){
		//DKLog(DK_GetId(event)+"\n", DKINFO);
		//DKLog(DKWidget_GetValue(DK_GetId(event))+"\n", DKINFO);
		if(DK_IdLike(event, "DKSolutionFolder")){
			DKLog("DKSolutionFolder", DKINFO);
			DKSolution_OpenFolder(DKWidget_GetValue(DK_GetId(event)));
			return;
		}
	
		DKSolution_OpenFile(DKWidget_GetValue(DK_GetId(event)));
		//DK_ClearSelection();
		return;
	}
}

////////////////////////////////////
function DKSolution_OpenFolder(path)
{
	//DKLog("DKSolution_OpenFolder("+path+") \n", DKINFO);
	if(DKSolution_UpdatePath(path)){
		return true;
	}
	return false;
}

//////////////////////////////////
function DKSolution_OpenFile(path)
{
	//DKLog("DKSolution_OpenFile("+path+") \n", DKINFO);
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
	DKWidget_SetValue("DKSolutionPath",aPath);
	//DKDev_OpenFile(aPath);
	if(DK_GetOS() == "Linux"){
		aPath = "xdg-open "+aPath;
	}
	DK_Run(aPath);
}

////////////////////////////////////
function DKSolution_UpdatePath(path)
{
	//if(!path){ return false; }
	//DKLog("DKSolution_UpdatePath("+path+") \n", DKDEBUG);
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

	DKWidget_SetInnerHtml("DKSolutionMenu", ""); //Clear it

	for(var d=0; d<files.length; d++){
		if(DKFile_IsDirectory(aPath+"/"+files[d])){ //Folders
			var element2 = DKWidget_CreateElement("DKSolutionMenu", "option", "DKSolutionFolder");
			var value = aPath+"/"+files[d];
			DKWidget_SetAttribute(element2,"value", value);
			DKWidget_SetProperty(element2, "white-space", "nowrap");
			DKAddEvent(element2, "click", DKSolution_OnEvent);
			DKWidget_SetProperty(element2, "padding-left", "17px");
			DKWidget_SetInnerHtml(element2,files[d]);
			DKWidget_SetProperty(element2, "background-image", "url(\"DKFile/folder.png\")");
			DKWidget_SetProperty(element2, "background-repeat", "no-repeat");
			DKAddEvent(element2, "click", DKSolution_OnEvent);
			DKAddEvent(element2, "dblclick", DKSolution_OnEvent);
			DKAddEvent(element2, "contextmenu", DKSolution_OnEvent);
		}
	}

	for(var f=0; f<files.length; f++){
		if(!DKFile_IsDirectory(aPath+"/"+files[f])){ //Files
			var element3 = DKWidget_CreateElement("DKSolutionMenu", "option", "DKSolutionFile");
			var value = aPath+"/"+files[f];
			DKWidget_SetAttribute(element3, "value", value);
			DKWidget_SetProperty(element3, "white-space", "nowrap");
			DKWidget_SetProperty(element3, "padding-left", "17px");
			DKWidget_SetProperty(element3, "background-repeat", "no-repeat");
			DKWidget_SetInnerHtml(element3,files[f]);
			DKAddEvent(element3, "click", DKSolution_OnEvent);
			DKAddEvent(element3, "dblclick", DKSolution_OnEvent);
			DKAddEvent(element3, "contextmenu", DKSolution_OnEvent);

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
			else if((extension == "js")){
				DKWidget_SetProperty(element3, "background-image", "url(\"DKFile/js.png\")");
			}
			else if((extension == "sln")){
				DKWidget_SetProperty(element3, "background-image", "url(\"DKFile/sln.png\")");
			}
			else if((extension == "html") || (extension == "htm")){
				DKWidget_SetProperty(element3, "background-image", "url(\"DKFile/html.png\")");
			}
			else{
				DKWidget_SetProperty(element3, "background-image", "url(\"DKFile/file.png\")");
			}
		}
	}
	
	DKWidget_SetValue("DKSolutionPath", aPath);
	return true;
}

