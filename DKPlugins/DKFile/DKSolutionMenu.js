DKSolutionMenu_id = "";
DKSolutionMenu_file = "";

//////////////////////////////
function DKSolutionMenu_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKFile/DKSolutionMenu.html");
	DKAddEvent("document", "mousedown", DKSolutionMenu_OnEvent);
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
	DKDEBUGFUNC();
	DKRemoveEvents(DKSolutionMenu_OnEvent);
	DKClose("DKFile/DKSolutionMenu.html");
}

//////////////////////////////////////
function DKSolutionMenu_OnEvent(event)
{
	DKDEBUGFUNC(event);
	DKDEBUG("DKSolutionMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
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
	
	if(DK_Id(event, "window")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKFile/DKSolutionMenu.html")){
			return;
		}
	}
	DKClose("DKFile/DKSolutionMenu.js");
}

/////////////////////////////////
function DKSolutionMenu_SetId(id)
{
	DKDEBUGFUNC(id);
	DKSolutionMenu_id = id;
}

/////////////////////////////////////
function DKSolutionMenu_SetFile(file)
{
	DKDEBUGFUNC(file);
	DKSolutionMenu_file = file;
}

//////////////////////////////
function DKSolutionMenu_Open()
{
	DKDEBUGFUNC();
	DKSolution_OpenFile(DKSolutionMenu_file);
}

//////////////////////////////////
function DKSolutionMenu_OpenHere()
{
	DKDEBUGFUNC();
	var path = DKSolutionMenu_file;
	//DKINFO("DKSolutionMenu_file = "+DKSolutionMenu_file+"\n");
	//DKINFO("absolutepath = "+absolutepath+"\n");
	//path = path.replace(absolutepath,"");
	//DKINFO("path = "+path+"\n");
	DKSolution_OpenHere(path);
}

/////////////////////////////////
function DKSolutionMenu_NewFile()
{
	DKDEBUGFUNC();
	if(!DKSolutionMenu_file){
		DKERROR("DKSolutionMenu_NewFile(): DKSolutionMenu_file is invalid\n");
		return;
	}
	var value = document.getElementById("DKSolutionPath").value;
	DKSolutionMenu_SetFile(value+"/New.txt");
	DKFile_StringToFile("", DKSolutionMenu_file);
	DKSolution_UpdatePath(value);
	
	//Find the id
	var elements = DKWidget_GetElements("DKSolutionMenu");
	//DKINFO("elements = "+elements+"\n");
	var arry = elements.split(",");
	for(var i=0; i<arry.length; i++){
		//DKINFO("arry["+i+"] ="+arry[i]+"\n");
		var value = DKWidget_GetValue(arry[i]);
		//DKINFO("arry["+i+"] ="+value+"\n");
		if(value == DKSolutionMenu_file){
			DKSolutionMenu_SetId(arry[i]);
			//DKINFO("id = "+arry[i]+"\n");
			break;
		}
	}
	
	DKSolutionMenu_Rename();
}

///////////////////////////////////
function DKSolutionMenu_NewFolder()
{
	DKDEBUGFUNC();
	if(!DKSolutionMenu_file){
		DKERROR("DKSolutionMenu_NewFile(): DKSolutionMenu_file is invalid\n");
		return;
	}
	
	DKSolutionMenu_SetFile(DKWidget_GetValue("DKSolutionPath")+"/New");
	DKFile_MkDir(DKSolutionMenu_file);
	DKSolution_UpdatePath(DKWidget_GetValue("DKSolutionPath"));
	
	//Find the id
	var elements = DKWidget_GetElements("DKSolutionMenu");
	//DKINFO("elements = "+elements+"\n");
	var arry = elements.split(",");
	for(var i=0; i<arry.length; i++){
		//DKINFO("arry["+i+"] ="+arry[i]+"\n");
		var value = DKWidget_GetValue(arry[i]);
		//DKINFO("arry["+i+"] ="+value+"\n");
		if(value == DKSolutionMenu_file){
			DKSolutionMenu_SetId(arry[i]);
			//DKINFO("id = "+arry[i]+"\n");
			break;
		}
	}
	
	DKSolutionMenu_Rename();
}

////////////////////////////////
function DKSolutionMenu_Rename()
{
	DKDEBUGFUNC();
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
	DKDEBUGFUNC();
	//TODO - confirm
	DKCreate("DKMessage/DKMessage.js", function(){
		DKFrame_Widget("DKMessage/DKMessage.html");
		DKMessage_Confirm("delete this file?", function(rval){
			//DKINFO("DKMessage_Confirm(): rval = "+rval+"\n");
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
	DKDEBUGFUNC();
	DK_SetClipboardFiles(DKSolutionMenu_file);
}

/////////////////////////////
function DKSolutionMenu_Cut()
{
	DKDEBUGFUNC();
	DK_SetClipboardFiles(DKSolutionMenu_file);
}

///////////////////////////////
function DKSolutionMenu_Paste()
{
	DKDEBUGFUNC();
	//TODO
}

////////////////////////////////
function DKSolutionMenu_Import()
{
	DKDEBUGFUNC();
	//TODO
}

////////////////////////////////
function DKSolutionMenu_GitAdd()
{
	DKDEBUGFUNC();
	DKCreate("DKBuild/DKBuild.js", function(){
		var git = GIT;       //from DKBuild.js
		var dkpath = DKPATH; //from DKBuild.js
		//DKINFO("DKSolutionMenu_GitAdd(): git = "+git+"\n");
		
		DKINFO("DKSolutionMenu_file = "+DKSolutionMenu_file+"\n");
		var search = DKSolutionMenu_file;
		while(!DKFile_Exists(search+"/.git")){
			var n = search.lastIndexOf("/");
			if(n == -1){
				DKWARN("could not locate a .git folder\n");
				return false;
			}
			search = search.substring(0, n);
			DKINFO(search+"\n");
		}
		
		//DKINFO("found .git\n");
		DKFile_ChDir(search);
		DK_Execute(git+" add "+DKSolutionMenu_file);	
	});
}

/////////////////////////////////////
function DKSolutionMenu_UpxCompress()
{
	DKDEBUGFUNC();
	DKCreate("DKBuild/DKBuild.js", function(){ //for DKPATH
	
		var dkpath = DKPATH; //from DKBuild.js
		var upx = dkpath+"/DK/3rdParty/upx-3.95-win64/upx.exe";
		DKINFO("upx = "+upx+"\n");
		//upx compress the exe file
		if(DKFile_Exists(upx)){
			DKWARN("UPX compressing exe... please wait\n");
			DK_Execute(upx+" -9 -v "+DKSolutionMenu_file);
		}
		else{
			DKWARN("DKBuild_DoResults(): UPX does not exists\n");
		}
	});
}