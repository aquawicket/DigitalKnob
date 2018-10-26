//////////////////////////
function DKSolution_Init()
{	
	DKDEBUGFUNC();
	DKCreate("DKFile/DKSolution.css");
	DKCreate("DKFile/DKSolution.html");
	DKCreate("DKFile/DKFileAssociation.js", function(){});
	
	DKAddEvent("DKSolutionUp", "click", DKSolution_OnEvent);
	DKAddEvent("DKSolutionMenu", "click", DKSolution_OnEvent);
	DKAddEvent("DKSolutionMenu", "contextmenu", DKSolution_OnEvent);
	DKAddEvent("DKSolutionPath", "keypress", DKSolution_OnEvent);
	
	//DKSolution_OpenFolder(DKWidget_GetValue("DKSolutionPath"));
}

/////////////////////////
function DKSolution_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKSolution_OnEvent);
	DKClose("DKFile/DKSolution.html");
	DKClose("DKFile/DKSolution.css");
}

//////////////////////////////////
function DKSolution_OnEvent(event)
{	
	DKDEBUGFUNC(event);
	DKDEBUG("DKSolution_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	DKSolution_Select(DK_GetId(event));

	if(DK_Type(event, "click")){
		DK_StopPropagation(event);
	}
	
	if(DK_Type(event, "contextmenu")){
		//DKINFO("DKSolution_OnEvent() contextmenu\n");
		var id = DK_GetId(event);
		//DKINFO("id = "+id+"\n");
		DK_StopPropagation(event);
		DKCreate("DKFile/DKSolutionMenu.js", function(){
			DKMenu_ValidatePosition("DKFile/DKSolutionMenu.html");
			var file = DKWidget_GetValue(id);
			//DKINFO("file = "+file+"\n");
			if(!file){
				file = DKWidget_GetValue("DKSolutionPath")+"/";
			}
			DKSolutionMenu_SetId(id);
			DKSolutionMenu_SetFile(file);
		});
		return;
	}
		
	if(DK_Id(event, "DKSolutionUp")){
		var up = DKWidget_GetValue("DKSolutionPath")+"/../";
		//DKINFO(up+"\n");
		DKSolution_OpenFolder(up);
	}
	
	if(DK_Type(event, "dblclick")){
		//DKINFO(DK_GetId(event)+"\n");
		//DKINFO(DKWidget_GetValue(DK_GetId(event))+"\n");
		if(DK_IdLike(event, "DKSolutionFolder")){
			//DKINFO("DKSolutionFolder\n");
			DKSolution_OpenFolder(DKWidget_GetValue(DK_GetId(event)));
			return;
		}
	
		DKSolution_OpenFile(DKWidget_GetValue(DK_GetId(event)));
		//DK_ClearSelection();
		return;
	}
	
	if(DK_Id(event, "DKSolutionPath")){
		if(DKWidget_GetValue(event) == 13){ //enter
			DKSolution_OpenFolder(DKWidget_GetValue("DKSolutionPath"));
		}
	}
}

//////////////////////////////
function DKSolution_Select(id)
{
	DKDEBUGFUNC(id);
	var elements = DKWidget_GetElements("DKSolutionMenu");
	var arry = elements.split(",");
	for(var i=0; i<arry.length-1; i++){
		if(!arry[i]){
			DKERROR("DKSolution_Select(id): arry["+i+"] invalid\n");
		}
		DKWidget_SetProperty(arry[i], "background-color", "rgb(255,255,255)");
		DKWidget_SetProperty(arry[i], "color", "rgb(0,0,0)");
	}
	if(id.indexOf("DKSolutionFolder") > -1 || id.indexOf("DKSolutionFile") > -1){
		DKWidget_SetProperty(id, "background-color", "rgb(123,157,212)");
		DKWidget_SetProperty(id, "color", "rgb(255,255,255)");
	}
}

////////////////////////////////////
function DKSolution_OpenFolder(path)
{
	DKDEBUGFUNC(path);
	if(DKSolution_UpdatePath(path)){
		return true;
	}
	return false;
}

//////////////////////////////////
function DKSolution_OpenFile(path)
{
	DKDEBUGFUNC(path);
	var aPath = path;
	if(DK_GetOS() != "Android"){
		aPath = DKFile_GetAbsolutePath(path);
	}
	//DKINFO("DKSolution_OpenFile("+path+"): aPath = "+aPath+"\n");
	if(!DK_Run(aPath, "")){ return false; }
	return true;
}

//////////////////////////////////
function DKSolution_OpenHere(path)
{
	DKDEBUGFUNC(path);
	var aPath = path;
	if(DK_GetOS() != "Android"){
		aPath = DKFile_GetAbsolutePath(path);
		if(typeof(absolutepath) == 'string'){ aPath = aPath.replace(absolutepath, ""); }
	}
	DKINFO("aPath:"+aPath+"\n");
	if(DKFile_IsDirectory(aPath)){ //Folder
		if(!DKSolution_UpdatePath(aPath)){ return false; }
		return true;
	}
	else{ //File
		if(!DKFileAssociation_Open(aPath)){ return false; }
		return true;
	}
	
	return false; //error
}

////////////////////////////////////
function DKSolution_UpdatePath(path)
{
	DKDEBUGFUNC(path);
	//reload events
	DKRemoveEvents(DKSolution_OnEvent);
	DKAddEvent("DKSolutionUp", "click", DKSolution_OnEvent);
	DKAddEvent("DKSolutionMenu", "click", DKSolution_OnEvent);
	DKAddEvent("DKSolutionMenu", "contextmenu", DKSolution_OnEvent);
	DKAddEvent("DKSolutionPath", "keypress", DKSolution_OnEvent);
	
	var aPath = path;
	if(DK_GetOS() != "Android"){
		aPath = DKFile_GetAbsolutePath(path);
	}
	//DKINFO("aPath:"+aPath+"\n");
	//var rPath = DKFile_GetRelativePath(aPath, path);
	//DKINFO("rPath:"+rPath+"\n");
	
	var temp = DKFile_DirectoryContents(aPath);
	if(!temp){ return false; }
	var files = temp.split(",");

	DKWidget_SetInnerHtml("DKSolutionMenu", ""); //Clear it

	for(var d=0; d<files.length; d++){
		if(DKFile_IsDirectory(aPath+"/"+files[d])){ //Folders
			var element2 = DKWidget_CreateElement("DKSolutionMenu", "div", "DKSolutionFolder");
			DKWidget_SetAttribute(element2, "class", "option");
			var value = aPath+"/"+files[d]+"/";
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
			var element3 = DKWidget_CreateElement("DKSolutionMenu", "div", "DKSolutionFile");
			DKWidget_SetAttribute(element3, "class", "option");
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