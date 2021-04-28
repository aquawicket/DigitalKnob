
dk.solutionmenu = new DKWidget("dk.solutionmenu");

dk.solutionmenu.id = "";
dk.solutionmenu.file = "";


dk.solutionmenu.init = function dk_solutionmenu_init()
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

dk.solutionmenu.end = function dk_solutionmenu_end()
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

dk.solutionmenu.onevent = function dk_solutionmenu_onevent(event)
{
	console.debug("DKSolutionMenu_OnEvent("+event.currentTarget.id+","+event.type+")\n");
	if(event.currentTarget.id === "DKSolutionMenu_Open"){
		dk.solutionmenu.pen();
	}
	if(event.currentTarget.id === "dk.solutionmenu.OpenHere"){
		dk.solutionmenu.openHere();
	}
	if(event.currentTarget.id === "dk.solutionmenu.NewFile"){
		dk.solutionmenu.newFile();
	}
	if(event.currentTarget.id === "dk.solutionmenu.NewFolder"){
		dk.solutionmenu.newFolder();
	}
	if(event.currentTarget.id === "dk.solutionmenu.Rename"){
		dk.solutionmenu.rename();
	}
	if(event.currentTarget.id === "dk.solutionmenu.Delete"){
		dk.solutionmenu.delete();
	}
	if(event.currentTarget.id === "dk.solutionmenu.Copy"){
		dk.solutionmenu.copy();
	}
	if(event.currentTarget.id === "dk.solutionmenu.Cut"){
		dk.solutionmenu.cut();
	}
	if(event.currentTarget.id === "dk.solutionmenu.Paste"){
		dk.solutionmenu.paste();
	}
	if(event.currentTarget.id === "dk.solutionmenu.Import"){
		dk.solutionmenu.import();
	}
	if(event.currentTarget.id === "dk.solutionmenu.GitAdd"){
		dk.solutionmenu.gitAdd();
	}
	if(event.currentTarget.id === "dk.solutionmenu.UpxCompress"){
		dk.solutionmenu.upxCompress();
	}
	
	//FIXME
	if(event.currentTarget === document){
		if(byId("DKFile/DKSolutionMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	dk.close("DKFile/DKSolutionMenu.js");
}

dk.solutionmenu.setId = function dk_solutionmenu_setId(id)
{
	dk.solutionmenu.id = id;
}

dk.solutionmenu.setFile = function dk_solutionmenu_setFile(file)
{
	dk.solutionmenu.file = file;
}

dk.solutionmenu.open = function dk_solutionmenu_open()
{
	DKSolution_OpenFile(dk.solutionmenu.file);
}

dk.solutionmenu.openHere = function dk_solutionmenu_openHere()
{
	console.log("dk.solutionmenu.OpenHere()");
	var path = dk.solutionmenu.file;
	//console.log("dk.solutionmenu.file = "+dk.solutionmenu.file+"\n");
	//console.log("absolutepath = "+absolutepath+"\n");
	//path = path.replace(absolutepath,"");
	//console.log("path = "+path+"\n");
	DKSolution_OpenHere(path);
}

dk.solutionmenu.newFile = function dk_solutionmenu_newFile()
{
	if(!dk.solutionmenu.file){
		console.error("dk.solutionmenu.NewFile(): dk.solutionmenu.file is invalid\n");
		return;
	}
	//var value = byId("DKSolutionPath").value;
	var value = byId("DKSolutionPath").value;
	console.log("dk.solutionmenu.NewFile(): value = "+value);
	dk.solutionmenu.SetFile(value+"/New.txt");
	DKFile_StringToFile("", dk.solutionmenu.file);
	DKSolution_UpdatePath(value);
	
	//Find the id
	var elements = DK_GetElements(byId("DKSolutionMenu"));
	//console.log("elements = "+elements+"\n");
	var arry = elements.split(",");
	for(var i=0; i<arry.length; i++){
		//console.log("arry["+i+"] ="+arry[i]+"\n");
		var value = byId(arry[i]).value;
		//console.log("arry["+i+"] ="+value+"\n");
		if(value === dk.solutionmenu.file){
			dk.solutionmenu.SetId(arry[i]);
			//console.log("id = "+arry[i]+"\n");
			break;
		}
	}
	
	dk.solutionmenu.Rename();
}

dk.solutionmenu.newFolder = function dk_solutionmenu_newFolder()
{
	if(!dk.solutionmenu.file){
		console.error("dk.solutionmenu.NewFile(): dk.solutionmenu.file is invalid\n");
		return;
	}
	
	dk.solutionmenu.SetFile(byId("DKSolutionPath").value+"/New");
	dk.file.makeDir(dk.solutionmenu.file);
	DKSolution_UpdatePath(byId("DKSolutionPath").value);
	
	//Find the id
	var elements = DK_GetElements(byId("DKSolutionMenu"));
	//console.log("elements = "+elements+"\n");
	var arry = elements.split(",");
	for(var i=0; i<arry.length; i++){
		//console.log("arry["+i+"] ="+arry[i]+"\n");
		var value = byId(arry[i]).value;
		//console.log("arry["+i+"] ="+value+"\n");
		if(value === dk.solutionmenu.file){
			dk.solutionmenu.SetId(arry[i]);
			//console.log("id = "+arry[i]+"\n");
			break;
		}
	}
	
	dk.solutionmenu.rename();
}

dk.solutionmenu.rename = function dk_solutionmenu_rename()
{
	var top1 = byId(dk.solutionmenu.id).offsetTop;
	var top2 = byId("DKSolutionMenu").offsetTop;
	var top = top1 - top2 - 1;
	
	dk.create("DKFile/DKSolutionRename.js", function(){
		DKSolutionRename_SetId(dk.solutionmenu.id);
		DKSolutionRename_SetFile(dk.solutionmenu.file);
		byId("DKFile/DKSolutionRename.html").style.top = top+"rem";
		var value = byId(dk.solutionmenu.id).innerHTML;
		byId("DKSolutionRename_box").value = value;
	});
}

dk.solutionmenu.delete = function dk_solutionmenu_delete()
{
	dk.create("DKGui/DKMessageBox.js", function(){
		DKFrame_Html("DKGui/DKMessageBox.html");
		DKMessageBox_Confirm("delete this file?", function(rval){
			if(rval === true){
				console.debug("dk.solutionmenu.Delete(): dk.solutionmenu.file = "+dk.solutionmenu.file);
				DKFile_Delete(dk.solutionmenu.file);
				DKSolution_UpdatePath(byId("DKSolutionPath").value);
			}
		});
	});
}

dk.solutionmenu.copy = function dk_solutionmenu_copy()
{
	DK_SetClipboardFiles(dk.solutionmenu.file);
}

dk.solutionmenu.cut = function dk_solutionmenu_cut()
{
	DK_SetClipboardFiles(dk.solutionmenu.file);
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
		//console.log("dk.solutionmenu.GitAdd(): git = "+git+"\n");
		
		console.log("dk.solutionmenu.file = "+dk.solutionmenu.file+"\n");
		var search = dk.solutionmenu.file;
		while(!dk.file.extist(search+"/.git")){
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
		DK_Execute(git+" add "+dk.solutionmenu.file);	
	});
}

dk.solutionmenu.upxCompress = function dk_solutionmenuuUpxCompress()
{
	dk.create("DKBuild/DKBuild.js", function(){ //for DKPATH
	
		var dkpath = DKPATH; //from DKBuild.js
		var upx = dkpath+"/DK/3rdParty/upx-3.95-win64/upx.exe";
		console.log("upx = "+upx+"\n");
		//upx compress the exe file
		if(dk.file.extist(upx)){
			console.warn("UPX compressing exe... please wait\n");
			DK_Execute(upx+" -9 -v "+dk.solutionmenu.file);
		}
		else{
			console.warn("DKBuild_DoResults(): UPX does not exists\n");
		}
	});
}