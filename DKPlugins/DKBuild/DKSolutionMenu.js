DKSolutionMenu_id = "";
DKSolutionMenu_file = "";

//////////////////////////////
function DKSolutionMenu_Init()
{
	DKCreate("DKBuild/DKSolutionMenu.html");
	DKWidget_SetProperty("DKSolutionMenu.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("DKSolutionMenu.html","left",DKWindow_GetMouseX()+"px");
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
	DKAddEvent("DKSolutionMenu_GitAdd", "click", DKSolutionMenu_OnEvent);
}

/////////////////////////////
function DKSolutionMenu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_Open", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_OpenHere", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_NewFile", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_NewFolder", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_Rename", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_Delete", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_Copy", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_Cut", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_Paste", "click", DKSolutionMenu_OnEvent);
	DKRemoveEvent("DKSolutionMenu_GitAdd", "click", DKSolutionMenu_OnEvent);
	DKClose("DKSolutionMenu.html");
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
	if(DK_Id(event,"DKSolutionMenu_GitAdd")){
		DKSolutionMenu_GitAdd();
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKSolutionMenu.html")){
			return;
		}
	}
	DKClose("DKSolutionMenu.js");
}

/////////////////////////////////
function DKSolutionMenu_SetId(id)
{
	DKLog("DKSolutionMenu_SetId("+id+")\n", DKINFO);
	DKSolutionMenu_id = id;
}

/////////////////////////////////////
function DKSolutionMenu_SetFile(file)
{
	DKLog("DKSolutionMenu_SetFile("+file+")\n", DKINFO);
	DKSolutionMenu_file = file;
}

//////////////////////////////
function DKSolutionMenu_Open()
{
	DKLog("DKSolutionMenu_Open("+DKSolutionMenu_file+")\n", DKINFO);
	DKSolution_OpenFile(DKSolutionMenu_file);
}

//////////////////////////////////
function DKSolutionMenu_OpenHere()
{
	DKLog("DKSolutionMenu_OpenHere("+DKSolutionMenu_file+")\n", DKINFO);
	DKSolution_OpenHere(DKSolutionMenu_file);
}

/////////////////////////////////
function DKSolutionMenu_NewFile()
{
	DKLog("DKSolutionMenu_NewFile() \n", DKINFO);
	if(!DKSolutionMenu_file){
		DKLog("DKSolutionMenu_NewFile(): DKSolutionMenu_file is invalid\n", DKERROR);
		return;
	}
	
	DKSolutionMenu_SetFile(DKWidget_GetValue("DKSolutionPath")+"/New.txt");
	DKFile_StringToFile("", DKSolutionMenu_file);
	DKSolution_UpdatePath(DKWidget_GetValue("DKSolutionPath"));
	
	//Find the id
	var elements = DKWidget_GetElements("DKSolutionMenu");
	DKLog("elements = "+elements+"\n", DKINFO);
	var arry = elements.split(",");
	for(var i=0; i<arry.length; i++){
		DKLog("arry["+i+"] ="+arry[i]+"\n", DKINFO);
		var value = DKWidget_GetValue(arry[i]);
		DKLog("arry["+i+"] ="+value+"\n", DKINFO);
		if(value == DKSolutionMenu_file){
			DKSolutionMenu_SetId(arry[i]);
			DKLog("id = "+arry[i]+"\n", DKINFO);
			break;
		}
	}
	
	DKSolutionMenu_Rename();
}

///////////////////////////////////
function DKSolutionMenu_NewFolder()
{
	DKLog("DKSolutionMenu_NewFolder() \n", DKINFO);
	if(!DKSolutionMenu_file){
		DKLog("DKSolutionMenu_NewFile(): DKSolutionMenu_file is invalid\n", DKERROR);
		return;
	}
	
	DKSolutionMenu_SetFile(DKWidget_GetValue("DKSolutionPath")+"/New");
	DKFile_MkDir(DKSolutionMenu_file);
	DKSolution_UpdatePath(DKWidget_GetValue("DKSolutionPath"));
	
	//Find the id
	var elements = DKWidget_GetElements("DKSolutionMenu");
	DKLog("elements = "+elements+"\n", DKINFO);
	var arry = elements.split(",");
	for(var i=0; i<arry.length; i++){
		DKLog("arry["+i+"] ="+arry[i]+"\n", DKINFO);
		var value = DKWidget_GetValue(arry[i]);
		DKLog("arry["+i+"] ="+value+"\n", DKINFO);
		if(value == DKSolutionMenu_file){
			DKSolutionMenu_SetId(arry[i]);
			DKLog("id = "+arry[i]+"\n", DKINFO);
			break;
		}
	}
	
	DKSolutionMenu_Rename();
}

////////////////////////////////
function DKSolutionMenu_Rename()
{
	//TODO
	DKLog("DKSolutionMenu_Rename() \n", DKINFO);

	var top1 = DKWidget_GetOffsetTop(DKSolutionMenu_id);
	var top2 = DKWidget_GetOffsetTop("DKSolutionMenu");
	var top = top1 - top2 - 1;
	
	DKCreate("DKBuild/DKSolutionRename.js", function(){
		DKSolutionRename_SetId(DKSolutionMenu_id);
		DKSolutionRename_SetFile(DKSolutionMenu_file);
		DKWidget_SetProperty("DKSolutionRename.html", "top", top+"rem");
		var value = DKWidget_GetInnerHtml(DKSolutionMenu_id);
		DKWidget_SetValue("DKSolutionRename_box", value);
	});
}

////////////////////////////////
function DKSolutionMenu_Delete()
{
	DKLog("DKSolutionMenu_Delete() \n", DKINFO);
	
	//TODO - confirm
	DKCreate("DKMessage/DKMessage.js", function(){
		DKFrame_Widget("DKMessage.html");
		DKMessageBox_Confirm("delete this file?", function(rval){
			DKLog("DKMessageBox_Confirm(): rval = "+rval+"\n", DKINFO);
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
	//TODO
	DKLog("DKSolutionMenu_Copy() \n", DKINFO);
	DK_SetClipboardFiles(DKSolutionMenu_file);
}

/////////////////////////////
function DKSolutionMenu_Cut()
{
	//TODO
	DKLog("DKSolutionMenu_Cut() \n", DKINFO);
	DK_SetClipboardFiles(DKSolutionMenu_file);
}

///////////////////////////////
function DKSolutionMenu_Paste()
{
	//TODO
	DKLog("DKSolutionMenu_Paste() \n", DKINFO);
}

////////////////////////////////
function DKSolutionMenu_GitAdd()
{
	//TODO
	DKLog("DKSolutionMenu_GitAdd() \n", DKINFO);
	
	//we need the path of git.exe
	//var git = GIT; //from DKBuild.js
	//DKLog("DKSolutionMenu_GitAdd(): git = "+git+"\n", DKINFO);
	// The GIT variable seems OK
	
	
	//we need to find the folder of the git repository
	//we need to chdir to that path
	//we need to "git add path" of the file we want to add.
}