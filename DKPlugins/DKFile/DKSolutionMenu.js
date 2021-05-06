
dk.solutionmenu = new DKPlugin("dk_solutionmenu");

dk.solutionmenu.id = "";
dk.solutionmenu.file = "";


dk.solutionmenu.init = function dk_solutionmenu_init()
{
	dk.create("DKFile/DKSolutionMenu.html", function(){
    	document.addEventListener("mousedown", dk.solutionmenu.onevent);
    	byId("DKSolutionMenu_Open").onclick = dk.solutionmenu.open;
    	byId("DKSolutionMenu_OpenHere").onclick = dk.solutionmenu.openHere;
    	byId("DKSolutionMenu_NewFile").onclick = dk.solutionmenu.newFile;
    	byId("DKSolutionMenu_NewFolder").onclick = dk.solutionmenu.newFolder;
    	byId("DKSolutionMenu_Rename").onclick = dk.solutionmenu.rename;
    	byId("DKSolutionMenu_Delete").onclick = dk.solutionmenu.delete;
    	byId("DKSolutionMenu_Copy").onclick = dk.solutionmenu.copy;
    	byId("DKSolutionMenu_Cut").onclick = dk.solutionmenu.cut;
    	byId("DKSolutionMenu_Paste").onclick = dk.solutionmenu.paste;
	    byId("DKSolutionMenu_Import").onclick = dk.solutionmenu.import;
    	byId("DKSolutionMenu_GitAdd").onclick = dk.solutionmenu.gitAdd;
	    byId("DKSolutionMenu_UpxCompress").onclick = dk.solutionmenu.upxCompress;
    });
}

dk.solutionmenu.end = function dk_solutionmenu_end()
{
	document.removeEventListener("mousedown", dk.solutionmenu.onevent);
	/*
	byId("DKSolutionMenu_Open").onclick = null;
	byId("DKSolutionMenu_OpenHere").onclick = null;
	byId("DKSolutionMenu_NewFile").onclick = null;
	byId("DKSolutionMenu_NewFolder").onclick = null;
	byId("DKSolutionMenu_Rename").onclick = null;
	byId("DKSolutionMenu_Delete").onclick = null;
	byId("DKSolutionMenu_Copy").onclick = null;
	byId("DKSolutionMenu_Cut").onclick = null;
	byId("DKSolutionMenu_Paste").onclick = null;
	byId("DKSolutionMenu_Import").onclick = null;
	byId("DKSolutionMenu_GitAdd").onclick = null;
	byId("DKSolutionMenu_UpxCompress").onclick = null;
	*/
	dk.close("DKFile/DKSolutionMenu.html");
}

dk.solutionmenu.onevent = function dk_solutionmenu_onevent(event)
{
	console.debug("DKSolutionMenu_OnEvent("+event.currentTarget.id+","+event.type+")\n");
	if(event.currentTarget.id === "DKSolutionMenu_Open"){
		dk.solutionmenu.open();
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
		if(byId("DKFile/DKSolutionMenu.html") && byId("DKFile/DKSolutionMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
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
	dk.solution.openFile(dk.solutionmenu.file);
}

dk.solutionmenu.openHere = function dk_solutionmenu_openHere()
{
	console.log("dk.solutionmenu.OpenHere()");
	var path = dk.solutionmenu.file;
	//console.log("dk.solutionmenu.file = "+dk.solutionmenu.file+"\n");
	//console.log("absolutepath = "+absolutepath+"\n");
	//path = path.replace(absolutepath,"");
	//console.log("path = "+path+"\n");
	dk.solution.openHere(path);
}

dk.solutionmenu.newFile = function dk_solutionmenu_newFile()
{
	if(!dk.solutionmenu.file){
		console.error("dk.solutionmenu.newFile(): dk.solutionmenu.file is invalid\n");
		return;
	}
	//var value = byId("DKSolutionPath").value;
	var value = byId("DKSolutionPath").value;
	console.log("dk.solutionmenu.NewFile(): value = "+value);
	dk.solutionmenu.setFile(value+"/New.txt");
	dk.file.stringToFile("", dk.solutionmenu.file);
	dk.solution.updatePath(value);
	
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
	
	dk.solutionmenu.setFile(byId("DKSolutionPath").value+"/New");
	dk.file.makeDir(dk.solutionmenu.file);
	dk.solution.updatePath(byId("DKSolutionPath").value);
	
	//Find the id
	//console.log("elements = "+elements+"\n");
	var arry = byId("DKSolutionMenu").childNodes;
	for(var i=0; i<arry.length; i++){
		//console.log("arry["+i+"] ="+arry[i]+"\n");
		var value = arry[i].value;
		//console.log("arry["+i+"] ="+value+"\n");
		if(value === dk.solutionmenu.file){
			dk.solutionmenu.setId(arry[i]);
			//console.log("id = "+arry[i]+"\n");
			break;
		}
	}
	
	dk.solutionmenu.rename();
}

dk.solutionmenu.rename = function dk_solutionmenu_rename()
{
	var top1 = byId("DKSolutionMenu").offsetTop;
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
				dk.file.delete(dk.solutionmenu.file);
				dk.solution.updatePath(byId("DKSolutionPath").value);
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