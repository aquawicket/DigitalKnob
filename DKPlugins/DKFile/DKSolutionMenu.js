DKSolutionMenu_id = "";
DKSolutionMenu_file = "";

//////////////////////////////
function DKSolutionMenu_Init()
{
	DKLog("DKSolutionMenu_Init()\n", DKDEBUG);
	DKCreate("DKFile/DKSolutionMenu.html");
	DKAddEvent("GLOBAL", "mousedown", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_Open", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_OpenHere", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_NewFile", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_NewFolder", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_Rename", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_Delete", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_Copy", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_Cut", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_Paste", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_Import", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_GitAdd", "click", DKSolutionMenu_OnEvent);
	DKAddEvent("DKSolutionMenu_UpxCompress", "click", DKSolutionMenu_OnEvent);
}

/////////////////////////////
function DKSolutionMenu_End()
{
	DKLog("DKSolutionMenu_End()\n", DKDEBUG);
	DKRemoveEvents(DKSolutionMenu_OnEvent);
	DKClose("DKFile/DKSolutionMenu.html");
}

//////////////////////////////////////
function DKSolutionMenu_OnEvent(event)
{
	DKLog("DKSolutionMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	if(DK_Id(event,"DKSolutionMenu_Open")){
		DKSolutionMenu_Open();
	}
	if(DK_Id(event,"DKSolutionMenu_OpenHere")){
		DKSolutionMenu_OpenHere();
	}
	if(DK_Id(event,"DKSolutionMenu_NewFile")){
		DKSolutionMenu_NewFile();
	}
	if(DK_Id(event,"DKSolutionMenu_NewFolder")){
		DKSolutionMenu_NewFolder();
	}
	if(DK_Id(event,"DKSolutionMenu_Rename")){
		DKSolutionMenu_Rename();
	}
	if(DK_Id(event,"DKSolutionMenu_Delete")){
		DKSolutionMenu_Delete();
	}
	if(DK_Id(event,"DKSolutionMenu_Copy")){
		DKSolutionMenu_Copy();
	}
	if(DK_Id(event,"DKSolutionMenu_Cut")){
		DKSolutionMenu_Cut();
	}
	if(DK_Id(event,"DKSolutionMenu_Paste")){
		DKSolutionMenu_Paste();
	}
	if(DK_Id(event,"DKSolutionMenu_Import")){
		DKSolutionMenu_Import();
	}
	if(DK_Id(event,"DKSolutionMenu_GitAdd")){
		DKSolutionMenu_GitAdd();
	}
	if(DK_Id(event,"DKSolutionMenu_UpxCompress")){
		DKSolutionMenu_UpxCompress();
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKFile/DKSolutionMenu.html")){
			return;
		}
	}
	DKClose("DKFile/DKSolutionMenu.js");
}

/////////////////////////////////
function DKSolutionMenu_SetId(id)
{
	DKLog("DKSolutionMenu_SetId("+id+")\n", DKDEBUG);
	DKSolutionMenu_id = id;
}

/////////////////////////////////////
function DKSolutionMenu_SetFile(file)
{
	DKLog("DKSolutionMenu_SetFile("+file+")\n", DKDEBUG);
	DKSolutionMenu_file = file;
}

//////////////////////////////
function DKSolutionMenu_Open()
{
	DKLog("DKSolutionMenu_Open("+DKSolutionMenu_file+")\n", DKDEBUG);
	DKSolution_OpenFile(DKSolutionMenu_file);
}

//////////////////////////////////
function DKSolutionMenu_OpenHere()
{
	DKLog("DKSolutionMenu_OpenHere("+DKSolutionMenu_file+")\n", DKDEBUG);
	var path = DKSolutionMenu_file;
	//DKLog("DKSolutionMenu_file = "+DKSolutionMenu_file+"\n");
	//DKLog("absolutepath = "+absolutepath+"\n");
	//path = path.replace(absolutepath,"");
	//DKLog("path = "+path+"\n");
	DKSolution_OpenHere(path);
}

/////////////////////////////////
function DKSolutionMenu_NewFile()
{
	DKLog("DKSolutionMenu_NewFile()\n", DKDEBUG);
	if(!DKSolutionMenu_file){
		DKLog("DKSolutionMenu_NewFile(): DKSolutionMenu_file is invalid\n", DKERROR);
		return;
	}
	
	DKSolutionMenu_SetFile(DKWidget_GetValue("DKSolutionPath")+"/New.txt");
	DKFile_StringToFile("", DKSolutionMenu_file);
	DKSolution_UpdatePath(DKWidget_GetValue("DKSolutionPath"));
	
	//Find the id
	var elements = DKWidget_GetElements("DKSolutionMenu");
	//DKLog("elements = "+elements+"\n");
	var arry = elements.split(",");
	for(var i=0; i<arry.length; i++){
		//DKLog("arry["+i+"] ="+arry[i]+"\n");
		var value = DKWidget_GetValue(arry[i]);
		//DKLog("arry["+i+"] ="+value+"\n");
		if(value == DKSolutionMenu_file){
			DKSolutionMenu_SetId(arry[i]);
			//DKLog("id = "+arry[i]+"\n");
			break;
		}
	}
	
	DKSolutionMenu_Rename();
}

///////////////////////////////////
function DKSolutionMenu_NewFolder()
{
	DKLog("DKSolutionMenu_NewFolder()\n", DKDEBUG);
	if(!DKSolutionMenu_file){
		DKLog("DKSolutionMenu_NewFile(): DKSolutionMenu_file is invalid\n", DKERROR);
		return;
	}
	
	DKSolutionMenu_SetFile(DKWidget_GetValue("DKSolutionPath")+"/New");
	DKFile_MkDir(DKSolutionMenu_file);
	DKSolution_UpdatePath(DKWidget_GetValue("DKSolutionPath"));
	
	//Find the id
	var elements = DKWidget_GetElements("DKSolutionMenu");
	//DKLog("elements = "+elements+"\n");
	var arry = elements.split(",");
	for(var i=0; i<arry.length; i++){
		//DKLog("arry["+i+"] ="+arry[i]+"\n");
		var value = DKWidget_GetValue(arry[i]);
		//DKLog("arry["+i+"] ="+value+"\n");
		if(value == DKSolutionMenu_file){
			DKSolutionMenu_SetId(arry[i]);
			//DKLog("id = "+arry[i]+"\n");
			break;
		}
	}
	
	DKSolutionMenu_Rename();
}

////////////////////////////////
function DKSolutionMenu_Rename()
{
	DKLog("DKSolutionMenu_Rename()\n", DKDEBUG);
	var top1 = DKWidget_GetOffsetTop(DKSolutionMenu_id);
	var top2 = DKWidget_GetOffsetTop("DKSolutionMenu");
	var top = top1 - top2 - 1;
	
	DKCreate("DKFile/DKSolutionRename.js", function(){
		DKSolutionRename_SetId(DKSolutionMenu_id);
		DKSolutionRename_SetFile(DKSolutionMenu_file);
		DKWidget_SetProperty("DKFile/DKSolutionRename.html", "top", top+"rem");
		var value = DKWidget_GetInnerHtml(DKSolutionMenu_id);
		DKWidget_SetValue("DKSolutionRename_box", value);
	});
}

////////////////////////////////
function DKSolutionMenu_Delete()
{
	DKLog("DKSolutionMenu_Delete()\n", DKDEBUG);
	//TODO - confirm
	DKCreate("DKMessage/DKMessage.js", function(){
		DKFrame_Widget("DKMessage/DKMessage.html");
		DKMessage_Confirm("delete this file?", function(rval){
			//DKLog("DKMessage_Confirm(): rval = "+rval+"\n");
			if(rval == true){
				DKFile_Delete(DKSolutionMenu_file);
				DKSolution_UpdatePath(DKWidget_GetValue("DKSolutionPath"));
			}
		});
	});
}

//////////////////////////////
function DKSolutionMenu_Copy()
{
	DKLog("DKSolutionMenu_Copy()\n", DKDEBUG);
	DK_SetClipboardFiles(DKSolutionMenu_file);
}

/////////////////////////////
function DKSolutionMenu_Cut()
{
	DKLog("DKSolutionMenu_Cut()\n", DKDEBUG);
	DK_SetClipboardFiles(DKSolutionMenu_file);
}

///////////////////////////////
function DKSolutionMenu_Paste()
{
	DKLog("DKSolutionMenu_Paste()\n", DKDEBUG);
	//TODO
}

////////////////////////////////
function DKSolutionMenu_Import()
{
	DKLog("DKSolutionMenu_Import()\n", DKDEBUG);
	//TODO
}

////////////////////////////////
function DKSolutionMenu_GitAdd()
{
	DKLog("DKSolutionMenu_GitAdd()\n", DKDEBUG);
	DKCreate("DKBuild/DKBuild.js", function(){
		var git = GIT;       //from DKBuild.js
		var dkpath = DKPATH; //from DKBuild.js
		//DKLog("DKSolutionMenu_GitAdd(): git = "+git+"\n");
		
		DKLog("DKSolutionMenu_file = "+DKSolutionMenu_file+"\n", DKINFO);
		var search = DKSolutionMenu_file;
		while(!DKFile_Exists(search+"/.git")){
			var n = search.lastIndexOf("/");
			if(n == -1){
				DKLog("could not locate a .git folder\n", DKWARN);
				return false;
			}
			search = search.substring(0, n);
			DKLog(search+"\n", DKINFO);
		}
		
		//DKLog("found .git\n", DKINFO);
		DKFile_ChDir(search);
		DK_Execute(git+" add "+DKSolutionMenu_file);	
	});
}

/////////////////////////////////////
function DKSolutionMenu_UpxCompress()
{
	DKLog("DKSolutionMenu_UpxCompress()\n", DKDEBUG);
	DKCreate("DKBuild/DKBuild.js", function(){ //for DKPATH
	
		var dkpath = DKPATH; //from DKBuild.js
		var upx = dkpath+"/DK/3rdParty/upx-3.95-win64/upx.exe";
		DKLog("upx = "+upx+"\n");
		//upx compress the exe file
		if(DKFile_Exists(upx)){
			DKLog("UPX compressing exe... please wait \n", DKWARN);
			DK_Execute(upx+" -9 -v "+DKSolutionMenu_file);
		}
		else{
			DKLog("DKBuild_DoResults(): UPX does not exists \n", DKWARN);
		}
	});
}