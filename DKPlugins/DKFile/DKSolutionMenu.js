DKSolutionMenu_id = "";
DKSolutionMenu_file = "";

//////////////////////////////
function DKSolutionMenu_Init()
{
	DKCreate("DKFile/DKSolutionMenu.html", function(){
    	document.addEventListener("mousedown", DKSolutionMenu_OnEvent);
    	byId("DKSolutionMenu_Open").addEventListener("click", DKSolutionMenu_OnEvent);
    	byId("DKSolutionMenu_OpenHere").addEventListener("click", DKSolutionMenu_OnEvent);
    	byId("DKSolutionMenu_NewFile").addEventListener("click", DKSolutionMenu_OnEvent);
    	byId("DKSolutionMenu_NewFolder").addEventListener("click", DKSolutionMenu_OnEvent);
    	byId("DKSolutionMenu_Rename").addEventListener("click", DKSolutionMenu_OnEvent);
    	byId("DKSolutionMenu_Delete").addEventListener("click", DKSolutionMenu_OnEvent);
    	byId("DKSolutionMenu_Copy").addEventListener("click", DKSolutionMenu_OnEvent);
    	byId("DKSolutionMenu_Cut").addEventListener("click", DKSolutionMenu_OnEvent);
    	byId("DKSolutionMenu_Paste").addEventListener("click", DKSolutionMenu_OnEvent);
	    byId("DKSolutionMenu_Import").addEventListener("click", DKSolutionMenu_OnEvent);
    	byId("DKSolutionMenu_GitAdd").addEventListener("click", DKSolutionMenu_OnEvent);
	    byId("DKSolutionMenu_UpxCompress").addEventListener("click", DKSolutionMenu_OnEvent);
    });
}

/////////////////////////////
function DKSolutionMenu_End()
{
	document.removeEventListener("mousedown", DKSolutionMenu_OnEvent);
	byId("DKSolutionMenu_Open").removeEventListener("click", DKSolutionMenu_OnEvent);
	byId("DKSolutionMenu_OpenHere").removeEventListener("click", DKSolutionMenu_OnEvent);
	byId("DKSolutionMenu_NewFile").removeEventListener("click", DKSolutionMenu_OnEvent);
	byId("DKSolutionMenu_NewFolder").removeEventListener("click", DKSolutionMenu_OnEvent);
	byId("DKSolutionMenu_Rename").removeEventListener("click", DKSolutionMenu_OnEvent);
	byId("DKSolutionMenu_Delete").removeEventListener("click", DKSolutionMenu_OnEvent);
	byId("DKSolutionMenu_Copy").removeEventListener("click", DKSolutionMenu_OnEvent);
	byId("DKSolutionMenu_Cut").removeEventListener("click", DKSolutionMenu_OnEvent);
	byId("DKSolutionMenu_Paste").removeEventListener("click", DKSolutionMenu_OnEvent);
	byId("DKSolutionMenu_Import").removeEventListener("click", DKSolutionMenu_OnEvent);
	byId("DKSolutionMenu_GitAdd").removeEventListener("click", DKSolutionMenu_OnEvent);
	byId("DKSolutionMenu_UpxCompress").removeEventListener("click", DKSolutionMenu_OnEvent);
	DKClose("DKFile/DKSolutionMenu.html");
}

//////////////////////////////////////
function DKSolutionMenu_OnEvent(event)
{
	console.debug("DKSolutionMenu_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
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
	if(event.currentTarget === window){
		if(byId("DKFile/DKSolutionMenu.html").contains(DKWidget_GetHoverElement())){
			return;
		}
	}
	DKClose("DKFile/DKSolutionMenu.js");
}

/////////////////////////////////
function DKSolutionMenu_SetId(id)
{
	DKSolutionMenu_id = id;
}

/////////////////////////////////////
function DKSolutionMenu_SetFile(file)
{
	DKSolutionMenu_file = file;
}

//////////////////////////////
function DKSolutionMenu_Open()
{
	DKSolution_OpenFile(DKSolutionMenu_file);
}

//////////////////////////////////
function DKSolutionMenu_OpenHere()
{
	var path = DKSolutionMenu_file;
	//console.log("DKSolutionMenu_file = "+DKSolutionMenu_file+"\n");
	//console.log("absolutepath = "+absolutepath+"\n");
	//path = path.replace(absolutepath,"");
	//console.log("path = "+path+"\n");
	DKSolution_OpenHere(path);
}

/////////////////////////////////
function DKSolutionMenu_NewFile()
{
	if(!DKSolutionMenu_file){
		console.error("DKSolutionMenu_NewFile(): DKSolutionMenu_file is invalid\n");
		return;
	}
	//var value = byId("DKSolutionPath").value;
	var value = DKWidget_GetValue("DKSolutionPath");
	console.log("DKSolutionMenu_NewFile(): value = "+value);
	DKSolutionMenu_SetFile(value+"/New.txt");
	DKFile_StringToFile("", DKSolutionMenu_file);
	DKSolution_UpdatePath(value);
	
	//Find the id
	var elements = DKWidget_GetElements("DKSolutionMenu");
	//console.log("elements = "+elements+"\n");
	var arry = elements.split(",");
	for(var i=0; i<arry.length; i++){
		//console.log("arry["+i+"] ="+arry[i]+"\n");
		var value = DKWidget_GetValue(arry[i]);
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
function DKSolutionMenu_NewFolder()
{
	if(!DKSolutionMenu_file){
		console.error("DKSolutionMenu_NewFile(): DKSolutionMenu_file is invalid\n");
		return;
	}
	
	DKSolutionMenu_SetFile(DKWidget_GetValue("DKSolutionPath")+"/New");
	DKFile_MkDir(DKSolutionMenu_file);
	DKSolution_UpdatePath(DKWidget_GetValue("DKSolutionPath"));
	
	//Find the id
	var elements = DKWidget_GetElements("DKSolutionMenu");
	//console.log("elements = "+elements+"\n");
	var arry = elements.split(",");
	for(var i=0; i<arry.length; i++){
		//console.log("arry["+i+"] ="+arry[i]+"\n");
		var value = DKWidget_GetValue(arry[i]);
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
function DKSolutionMenu_Rename()
{
	var top1 = DKWidget_GetOffsetTop(DKSolutionMenu_id);
	var top2 = DKWidget_GetOffsetTop("DKSolutionMenu");
	var top = top1 - top2 - 1;
	
	DKCreate("DKFile/DKSolutionRename.js", function(){
		DKSolutionRename_SetId(DKSolutionMenu_id);
		DKSolutionRename_SetFile(DKSolutionMenu_file);
		byId("DKFile/DKSolutionRename.html").style.top = top+"rem";
		var value = byId(DKSolutionMenu_id).innerHTML;
		DKWidget_SetValue("DKSolutionRename_box", value);
	});
}

////////////////////////////////
function DKSolutionMenu_Delete()
{
	//TODO - confirm
	DKCreate("DKMessage/DKMessage.js", function(){
		DKFrame_Widget("DKMessage/DKMessage.html");
		DKMessage_Confirm("delete this file?", function(rval){
			//console.log("DKMessage_Confirm(): rval = "+rval+"\n");
			if(rval === true){
				DKFile_Delete(DKSolutionMenu_file);
				DKSolution_UpdatePath(DKWidget_GetValue("DKSolutionPath"));
			}
		});
	});
}

//////////////////////////////
function DKSolutionMenu_Copy()
{
	DK_SetClipboardFiles(DKSolutionMenu_file);
}

/////////////////////////////
function DKSolutionMenu_Cut()
{
	DK_SetClipboardFiles(DKSolutionMenu_file);
}

///////////////////////////////
function DKSolutionMenu_Paste()
{
	//TODO
}

////////////////////////////////
function DKSolutionMenu_Import()
{
	//TODO
}

////////////////////////////////
function DKSolutionMenu_GitAdd()
{
	DKCreate("DKBuild/DKBuild.js", function(){
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

/////////////////////////////////////
function DKSolutionMenu_UpxCompress()
{
	DKCreate("DKBuild/DKBuild.js", function(){ //for DKPATH
	
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