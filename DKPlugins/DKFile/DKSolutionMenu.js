
dk.solutionmenu = new DKWidget("dk.solutionmenu");

DKSolutionMenu_id = "";
DKSolutionMenu_file = "";

//////////////////////////////
dk.solutionmenu. = function dk_solutionmenu_Init()
{
	dk.create("DKFile/DKSolutionMenu.html", function(){
    	document.addEventListener("mousedown", dk.solutionmenu.onevent);
    	byId("DKSolutionMenu_Open").addEventListener("click", dk.solutionmenu.onevent);
    	byId("DKSolutionMenu_OpenHere").addEventListener("click", dk.solutionmenu.onevent);
    	byId("DKSolutionMenu_NewFile").addEventListener("click", dk.solutionmenu.onevent);
    	byId("DKSolutionMenu_NewFolder").addEventListener("click", dk.solutionmenu.onevent);
    	byId("DKSolutionMenu_Rename").addEventListener("click", dk.solutionmenu.onevent);
    	byId("DKSolutionMenu_Delete").addEventListener("click", dk.solutionmenu.onevent);
    	byId("DKSolutionMenu_Copy").addEventListener("click", dk.solutionmenu.onevent);
    	byId("DKSolutionMenu_Cut").addEventListener("click", dk.solutionmenu.onevent);
    	byId("DKSolutionMenu_Paste").addEventListener("click", dk.solutionmenu.onevent);
	    byId("DKSolutionMenu_Import").addEventListener("click", dk.solutionmenu.onevent);
    	byId("DKSolutionMenu_GitAdd").addEventListener("click", dk.solutionmenu.onevent);
	    byId("DKSolutionMenu_UpxCompress").addEventListener("click", dk.solutionmenu.onevent);
    });
}

/////////////////////////////
dk.solutionmenu. = function dk_solutionmenu_End()
{
	document.removeEventListener("mousedown", dk.solutionmenu.onevent);
	byId("DKSolutionMenu_Open").removeEventListener("click", dk.solutionmenu.onevent);
	byId("DKSolutionMenu_OpenHere").removeEventListener("click", dk.solutionmenu.onevent);
	byId("DKSolutionMenu_NewFile").removeEventListener("click", dk.solutionmenu.onevent);
	byId("DKSolutionMenu_NewFolder").removeEventListener("click", dk.solutionmenu.onevent);
	byId("DKSolutionMenu_Rename").removeEventListener("click", dk.solutionmenu.onevent);
	byId("DKSolutionMenu_Delete").removeEventListener("click", dk.solutionmenu.onevent);
	byId("DKSolutionMenu_Copy").removeEventListener("click", dk.solutionmenu.onevent);
	byId("DKSolutionMenu_Cut").removeEventListener("click", dk.solutionmenu.onevent);
	byId("DKSolutionMenu_Paste").removeEventListener("click", dk.solutionmenu.onevent);
	byId("DKSolutionMenu_Import").removeEventListener("click", dk.solutionmenu.onevent);
	byId("DKSolutionMenu_GitAdd").removeEventListener("click", dk.solutionmenu.onevent);
	byId("DKSolutionMenu_UpxCompress").removeEventListener("click", dk.solutionmenu.onevent);
	dk.close("DKFile/DKSolutionMenu.html");
}

//////////////////////////////////////
dk.solutionmenu. = function dk_solutionmenu_OnEvent(event)
{
	console.debug("DKSolutionMenu_OnEvent("+event.currentTarget.id+","+event.type+")\n");
	if(event.currentTarget.id === "DKSolutionMenu_Open"){
		DKSolutionMenu_Open();
	}
	if(event.currentTarget.id === "DKSolutionMenu_OpenHere"){
		DKSolutionMenu_OpenHere();
	}
	if(event.currentTarget.id === "DKSolutionMenu_NewFile"){
		DKSolutionMenu_NewFile();
	}
	if(event.currentTarget.id === "DKSolutionMenu_NewFolder"){
		DKSolutionMenu_NewFolder();
	}
	if(event.currentTarget.id === "DKSolutionMenu_Rename"){
		DKSolutionMenu_Rename();
	}
	if(event.currentTarget.id === "DKSolutionMenu_Delete"){
		DKSolutionMenu_Delete();
	}
	if(event.currentTarget.id === "DKSolutionMenu_Copy"){
		DKSolutionMenu_Copy();
	}
	if(event.currentTarget.id === "DKSolutionMenu_Cut"){
		DKSolutionMenu_Cut();
	}
	if(event.currentTarget.id === "DKSolutionMenu_Paste"){
		DKSolutionMenu_Paste();
	}
	if(event.currentTarget.id === "DKSolutionMenu_Import"){
		DKSolutionMenu_Import();
	}
	if(event.currentTarget.id === "DKSolutionMenu_GitAdd"){
		DKSolutionMenu_GitAdd();
	}
	if(event.currentTarget.id === "DKSolutionMenu_UpxCompress"){
		DKSolutionMenu_UpxCompress();
	}
	
	//FIXME
	if(event.currentTarget === document){
		if(byId("DKFile/DKSolutionMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	dk.close("DKFile/DKSolutionMenu.js");
}

/////////////////////////////////
dk.solutionmenu. = function dk_solutionmenu_SetId(id)
{
	DKSolutionMenu_id = id;
}

/////////////////////////////////////
dk.solutionmenu. = function dk_solutionmenu_SetFile(file)
{
	DKSolutionMenu_file = file;
}

//////////////////////////////
dk.solutionmenu. = function dk_solutionmenu_Open()
{
	DKSolution_OpenFile(DKSolutionMenu_file);
}

//////////////////////////////////
dk.solutionmenu. = function dk_solutionmenu_OpenHere()
{
	console.log("DKSolutionMenu_OpenHere()");
	var path = DKSolutionMenu_file;
	//console.log("DKSolutionMenu_file = "+DKSolutionMenu_file+"\n");
	//console.log("absolutepath = "+absolutepath+"\n");
	//path = path.replace(absolutepath,"");
	//console.log("path = "+path+"\n");
	DKSolution_OpenHere(path);
}

/////////////////////////////////
dk.solutionmenu. = function dk_solutionmenu_NewFile()
{
	if(!DKSolutionMenu_file){
		console.error("DKSolutionMenu_NewFile(): DKSolutionMenu_file is invalid\n");
		return;
	}
	//var value = byId("DKSolutionPath").value;
	var value = byId("DKSolutionPath").value;
	console.log("DKSolutionMenu_NewFile(): value = "+value);
	DKSolutionMenu_SetFile(value+"/New.txt");
	dk.file.stringToFile("", DKSolutionMenu_file);
	DKSolution_UpdatePath(value);
	
	//Find the id
	var elements = DK_GetElements(byId("DKSolutionMenu"));
	//console.log("elements = "+elements+"\n");
	var arry = elements.split(",");
	for(var i=0; i<arry.length; i++){
		//console.log("arry["+i+"] ="+arry[i]+"\n");
		var value = byId(arry[i]).value;
		//console.log("arry["+i+"] ="+value+"\n");
		if(value === DKSolutionMenu_file){
			DKSolutionMenu_SetId(arry[i]);
			//console.log("id = "+arry[i]+"\n");
			break;
		}
	}
	
	DKSolutionMenu_Rename();
}

///////////////////////////////////
dk.solutionmenu. = function dk_solutionmenu_NewFolder()
{
	if(!DKSolutionMenu_file){
		console.error("DKSolutionMenu_NewFile(): DKSolutionMenu_file is invalid\n");
		return;
	}
	
	DKSolutionMenu_SetFile(byId("DKSolutionPath").value+"/New");
	dk.file.makeDir(DKSolutionMenu_file);
	DKSolution_UpdatePath(byId("DKSolutionPath").value);
	
	//Find the id
	var elements = DK_GetElements(byId("DKSolutionMenu"));
	//console.log("elements = "+elements+"\n");
	var arry = elements.split(",");
	for(var i=0; i<arry.length; i++){
		//console.log("arry["+i+"] ="+arry[i]+"\n");
		var value = byId(arry[i]).value;
		//console.log("arry["+i+"] ="+value+"\n");
		if(value === DKSolutionMenu_file){
			DKSolutionMenu_SetId(arry[i]);
			//console.log("id = "+arry[i]+"\n");
			break;
		}
	}
	
	DKSolutionMenu_Rename();
}

////////////////////////////////
dk.solutionmenu. = function dk_solutionmenu_Rename()
{
	var top1 = byId(DKSolutionMenu_id).offsetTop;
	var top2 = byId("DKSolutionMenu").offsetTop;
	var top = top1 - top2 - 1;
	
	dk.create("DKFile/DKSolutionRename.js", function(){
		DKSolutionRename_SetId(DKSolutionMenu_id);
		DKSolutionRename_SetFile(DKSolutionMenu_file);
		byId("DKFile/DKSolutionRename.html").style.top = top+"rem";
		var value = byId(DKSolutionMenu_id).innerHTML;
		byId("DKSolutionRename_box").value = value;
	});
}

////////////////////////////////
dk.solutionmenu. = function dk_solutionmenu_Delete()
{
	dk.create("DKGui/DKMessageBox.js", function(){
		DKFrame_Html("DKGui/DKMessageBox.html");
		DKMessageBox_Confirm("delete this file?", function(rval){
			if(rval === true){
				console.debug("DKSolutionMenu_Delete(): DKSolutionMenu_file = "+DKSolutionMenu_file);
				DKFile_Delete(DKSolutionMenu_file);
				DKSolution_UpdatePath(byId("DKSolutionPath").value);
			}
		});
	});
}

dk.solutionmenu.copy = function dk_solutionmenu_copy()
{
	DK_SetClipboardFiles(DKSolutionMenu_file);
}

dk.solutionmenu.cut = function dk_solutionmenu_cut()
{
	DK_SetClipboardFiles(DKSolutionMenu_file);
}

dk.solutionmenu.paste = function dk_solutionmenu_paste()
{
	//TODO
}

dk.solutionmenu.import = function dk_solutionmenu_import()
{
	//TODO
}

dk.solutionmenu.gitAdd = function dk_solutionmenu_gitAdd()
{
	dk.create("DKBuild/DKBuild.js", function(){
		var git = GIT;       //from DKBuild.js
		var dkpath = DKPATH; //from DKBuild.js
		//console.log("DKSolutionMenu_GitAdd(): git = "+git+"\n");
		
		console.log("DKSolutionMenu_file = "+DKSolutionMenu_file+"\n");
		var search = DKSolutionMenu_file;
		while(!DKFile_Exists(search+"/.git")){
			var n = search.lastIndexOf("/");
			if(n === -1){
				console.warn("could not locate a .git folder\n");
				return false;
			}
			search = search.substring(0, n);
			console.log(search+"\n");
		}
		
		//console.log("found .git\n");
		DKFile_ChDir(search);
		DK_Execute(git+" add "+DKSolutionMenu_file);	
	});
}

dk.solutionmenu.upxCompress = function dk_solutionmenuuUpxCompress()
{
	dk.create("DKBuild/DKBuild.js", function(){ //for DKPATH
	
		var dkpath = DKPATH; //from DKBuild.js
		var upx = dkpath+"/DK/3rdParty/upx-3.95-win64/upx.exe";
		console.log("upx = "+upx+"\n");
		//upx compress the exe file
		if(DKFile_Exists(upx)){
			console.warn("UPX compressing exe... please wait\n");
			DK_Execute(upx+" -9 -v "+DKSolutionMenu_file);
		}
		else{
			console.warn("DKBuild_DoResults(): UPX does not exists\n");
		}
	});
}