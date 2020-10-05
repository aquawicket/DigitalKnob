//////////////////////////
function DKSolution_Init()
{	
	DKCreate("DKFile/DKSolution.css");
	DKCreate("DKFile/DKSolution.html");
	DKCreate("DKFile/DKFileAssociation.js", function(){});
	byId("DKSolutionUp").addEventListener("click", DKSolution_OnEvent);
	byId("DKSolutionMenu").addEventListener("click", DKSolution_OnEvent);
	byId("DKSolutionMenu").addEventListener("contextmenu", DKSolution_OnEvent);
	byId("DKSolutionPath").addEventListener("keypress", DKSolution_OnEvent);
	
	//DKSolution_OpenFolder(DKWidget_GetValue("DKSolutionPath"));
}

/////////////////////////
function DKSolution_End()
{
	byId("DKSolutionUp").removeEventListener("click", DKSolution_OnEvent);
	byId("DKSolutionMenu").removeEventListener("click", DKSolution_OnEvent);
	byId("DKSolutionMenu").removeEventListener("contextmenu", DKSolution_OnEvent);
	byId("DKSolutionPath").removeEventListener("keypress", DKSolution_OnEvent);
	DKClose("DKFile/DKSolution.html");
	DKClose("DKFile/DKSolution.css");
}

//////////////////////////////////
function DKSolution_OnEvent(event)
{	
	console.debug("DKSolution_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")");
	DKSolution_Select(event.currentTarget.id);

	if(event.currentTarget.id === "click"){
		DK_StopPropagation(event);
	}
	
	if(event.type === "contextmenu"){
		//console.log("DKSolution_OnEvent() contextmenu\n");
		//PreventDefault(event);
		
		var id = event.currentTarget.id;
		//console.log("id = "+id+"\n");
		DKCPP_DKDuktape_StopPropagation(event);
		DKCreate("DKFile/DKSolutionMenu.js", function(){
			DKMenu_ValidatePosition("DKFile/DKSolutionMenu.html");
			var file = DKWidget_GetValue(id);
			//console.log("file = "+file+"\n");
			if(!file){
				file = DKWidget_GetValue("DKSolutionPath")+"/";
			}
			DKSolutionMenu_SetId(id);
			DKSolutionMenu_SetFile(file);
		});
		return;
	}
		
	if(event.currentTarget.id === "DKSolutionUp"){
		var up = DKWidget_GetValue("DKSolutionPath")+"/../";
		//console.log(up+"\n");
		DKSolution_OpenFolder(up);
	}
	
	if(event.type === "dblclick"){
		//console.log(DK_GetId(event)+"\n");
		//console.log(DKWidget_GetValue(DK_GetId(event))+"\n");
		if(event.currentTarget.id.includes("DKSolutionFolder")){
			//console.log("DKSolutionFolder\n");
			DKSolution_OpenFolder(DKWidget_GetValue(event.currentTarget.id));
			return;
		}
	
		DKSolution_OpenFile(DKWidget_GetValue(event.currentTarget.id));
		//DK_ClearSelection();
		return;
	}
	
	if(event.currentTarget.id === "DKSolutionPath"){
		if(DKWidget_GetValue(event) === 13){ //enter
			DKSolution_OpenFolder(DKWidget_GetValue("DKSolutionPath"));
		}
	}
}

//////////////////////////////
function DKSolution_Select(id)
{
	var elements = DKWidget_GetElements("DKSolutionMenu");
	var arry = elements.split(",");
	for(var i=0; i<arry.length-1; i++){
		if(!arry[i]){
			console.error("DKSolution_Select(id): arry["+i+"] invalid\n");
		}
		byId(arry[i]).style.backgroundColor = "rgb(255,255,255)";
		byId(arry[i]).style.color = "rgb(0,0,0)";
	}
	if(id.indexOf("DKSolutionFolder") > -1 || id.indexOf("DKSolutionFile") > -1){
		byId(id).style.backgroundColor = "rgb(123,157,212)";
		byId(id).style.color = "rgb(255,255,255)";
	}
}

////////////////////////////////////
function DKSolution_OpenFolder(path)
{
	if(DKSolution_UpdatePath(path)){
		return true;
	}
	return false;
}

//////////////////////////////////
function DKSolution_OpenFile(path)
{
	var aPath = path;
	if(DK_GetOS() !== "Android"){
		aPath = DKCPP_DKFile_GetAbsolutePath(path);
	}
	//console.log("DKSolution_OpenFile("+path+"): aPath = "+aPath+"\n");
	if(!DKCPP_DKDuktape_Run(aPath, "")){ return false; }
	return true;
}

//////////////////////////////////
function DKSolution_OpenHere(path)
{
	var aPath = path;
	if(DK_GetOS() !== "Android"){
		aPath = DKCPP_DKFile_GetAbsolutePath(path);
		if(typeof(absolutepath) === 'string'){ aPath = aPath.replace(absolutepath, ""); }
	}
	//console.log("aPath:"+aPath+"\n");
	if(DKCPP_DKFile_IsDirectory(aPath)){ //Folder
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
	console.log("DKSolution_UpdatePath("+path+")");
	
	//reload events
	byId("DKSolutionUp").addEventListener("click", DKSolution_OnEvent);
	byId("DKSolutionMenu").addEventListener("click", DKSolution_OnEvent);
	byId("DKSolutionMenu").addEventListener("contextmenu", DKSolution_OnEvent);
	byId("DKSolutionPath").addEventListener("keypress", DKSolution_OnEvent);
	
	if(!path){ path = ""; }
	var aPath = path;
	/*
	var aPath;
	if(DK_GetOS() !== "Android"){
		aPath = DKFile_GetAbsolutePath(path);
	}
	*/
	
	//console.log("aPath:"+aPath+"\n");
	//var rPath = DKCPP_DKFile_GetRelativePath(aPath, path);
	//console.log("rPath:"+rPath+"\n");
	
	var temp = DKFile_DirectoryContents(aPath);
	if(!temp){ return false; }
	var files = temp.split(",");

	byId("DKSolutionMenu").innerHTML = ""; //Clear it

	for(var d=0; d<files.length; d++){
		if(DKFile_IsDirectory(aPath+"/"+files[d])){ //Folders
			var element2 = DKWidget_CreateElement(byId("DKSolutionMenu"), "div", "DKSolutionFolder");
			byId(element2).setAttribute("class", "option");
			var value = aPath+"/"+files[d]+"/";
			byId(element2).setAttribute("value", value);
			byId(element2).style.whiteSpace = "nowrap";
			byId(element2).addEventListener("click", DKSolution_OnEvent);
			byId(element2).style.paddingLeft = "17px";
			byId(element2).innerHTML = files[d];
			byId(element2).style.backgroundImage = "url(\"DKFile/folder.png\")";
			byId(element2).style.backgroundRepeat = "no-repeat";
			byId(element2).addEventListener("click", DKSolution_OnEvent);
			byId(element2).addEventListener("dblclick", DKSolution_OnEvent);
			byId(element2).addEventListener("contextmenu", DKSolution_OnEvent);
		}
	}

	for(var f=0; f<files.length; f++){
		if(!DKFile_IsDirectory(aPath+"/"+files[f])){ //Files
			var element3 = DKWidget_CreateElement(byId("DKSolutionMenu"), "div", "DKSolutionFile");
			byId(element3).setAttribute("class", "option");
			var value = aPath+"/"+files[f];
			byId(element3).setAttribute("value", value);
			byId(element3).style.whiteSpace = "nowrap";
			byId(element3).style.paddingLeft = "17px";
			byId(element3).style.backgroundRepeat = "no-repeat";
			byId(element3).innerHTML = files[f];
			byId(element3).addEventListener("click", DKSolution_OnEvent);
			byId(element3).addEventListener("dblclick", DKSolution_OnEvent);
			byId(element3).addEventListener("contextmenu", DKSolution_OnEvent);

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
			else if((extension === "js")){
				byId(element3).style.backgroundImage = "url(\"DKFile/js.png\")";
			}
			else if((extension === "sln")){
				byId(element3).style.backgroundImage = "url(\"DKFile/sln.png\")";
			}
			else if((extension === "html") || (extension === "htm")){
				byId(element3).style.backgroundImage = "url(\"DKFile/html.png\")";
			}
			else{
				byId(element3).style.backgroundImage = "url(\"DKFile/file.png\")";
			}
		}
	}
	
	DKWidget_SetValue("DKSolutionPath", aPath);
	return true;
}