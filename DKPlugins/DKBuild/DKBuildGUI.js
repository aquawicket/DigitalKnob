//////////////////////////
function DKBuildGUI_Init()
{
	//DKLog("DKBuildGUI_Init()\n");
	
	DKCreate("DKBuild/DKBuildGUI.html", function(){
	DKCreate("DKFile/DKFile.js", function(){
	DKCreate("DKBuild/DKBuild.js", function(rval){
		//DKAddEvent("AppList", "click", DKBuildGUI_OnEvent);
		DKAddEvent("AppList", "change", DKBuildGUI_OnEvent);
		DKAddEvent("OSList", "change", DKBuildGUI_OnEvent);
		DKAddEvent("BuildType", "change", DKBuildGUI_OnEvent);
		DKAddEvent("git", "click", DKBuildGUI_OnEvent);
		DKAddEvent("libraries", "click", DKBuildGUI_OnEvent);
		DKAddEvent("build", "click", DKBuildGUI_OnEvent);
		//DKAddEvent("DKBuildGUI.html", "NewApp", DKBuildGUI_OnEvent);
	
		//DKBuild_ValidateSvn();
		DKBuild_ValidateGit();
		DKBuild_ValidateCmake();
		DKBuild_ValidateVC2015();

		/*
		if(DK_GetOS() == "Win32" ||  DK_GetOS() == "Win64"){
			DKWidget_SetValue("OSList", "win32");
		}
		if(DK_GetOS() == "Mac"){
			DKWidget_SetValue("OSList", "mac64");
		}	
		if(DK_GetOS() == "Linux"){
			DKWidget_SetValue("OSList", "linux64");
		}	

		if(DK_GetOS() == "Linux"){
			DKWidget_SetValue("BuildType", "Release");
		}
		else{
			DKWidget_SetValue("BuildType", "ALL");
		}
	
		if(DK_GetOS() == "Android"){ return; } //FIXME - android not ready
		*/
		
		DKBuildGUI_UpdateApps();
	});
	});
	});
}

/////////////////////////
function DKBuildGUI_End()
{
	//DKLog("DKBuildGUI_End()\n");
	
	DKRemoveEvents(DKBuildGUI_OnEvent);
	DKClose("DKBuild/DKBuildGUI.html");
	DKClose("DKBuild/DKBuild.js");
}

//////////////////////////////////
function DKBuildGUI_OnEvent(event)
{
	//DKLog("DKBuildGUI_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event,"AppList")){
		//if(DK_Type(event,"click")){
		//	DKBuildGUI_UpdateApps();
		//}
		if(DK_Type(event,"change")){
			DKBuildGUI_AppSelect();
		}
	}
	if(DK_Id(event,"OSList")){
		DKBuildGUI_OsSelect();
	}
	if(DK_Id(event,"BuildType")){
		DKBuildGUI_BuildSelect();
	}
	if(DK_Id(event,"git")){
		DKCreate("DKBuild/GitMenu.js", function(){
			DKMenu_ValidatePosition("DKBuild/GitMenu.html");
		});
	}
	if(DK_Id(event,"libraries")){
		DKCreate("DKBuild/LibraryMenu.js", function(){
			DKMenu_ValidatePosition("DKBuild/LibraryMenu.html");
		});
	}
	if(DK_Id(event,"build")){
		DKCreate("DKBuild/RunMenu.js", function(){
			DKMenu_ValidatePosition("DKBuild/RunMenu.html");
		});
	}		
	
	/*
	if(DK_Type(event,"NewApp")){
		DKSendEvent("DKBuildGUI", "NewApp", DK_GetValue(event));
		DKWidget_SetValue("AppList", DK_GetValue(event));
		//DKSendEvent("MenuRight.html", "SetPanel", "App");

		//var apppath = DK_CallFunc("DKBuildGUI::GetAppPath", DKWidget_GetValue("AppList"));
		//DKCreate("AppExplorer.js");
		//DKSendEvent("AppExplorer.html", "UpdateAppExplorer", apppath);
	}
	*/
}

////////////////////////////////
function DKBuildGUI_UpdateApps()
{
	////////  Update App List /////////////
	DKWidget_SetInnerHtml("AppList", "");
	DKBuild_GetAppList();
	
	for(var i=0; i<APP_LIST.length; ++i){
		//DKLog(APP_LIST[i]+"\n");
		var ele = DKWidget_CreateElement("AppList", "option", "al");
		DKWidget_SetInnerHtml(ele, APP_LIST[i]);
		DKWidget_SetAttribute(ele, "value", APP_LIST[i]);
		//DKWidget_SetValue("AppList", "DKBuilder");
	}
}

/////////////////////////////////
function DKBuildGUI_AppSelect()
{
	// We can send events to classes that are not of DKWidget as well.
	if(DKWidget_GetValue("AppList") == "NEW APP"){
		DKCreate("DKMessage/DKMessage.js", function(){
			DKSendEvent("DKMessage.html", "GetInput", "NewApp,DKBuildGUI.html"); // To -> DKMessageBox
		});
		return;
	}
	
	APP = DKWidget_GetValue("AppList");
	DKLog("APP = "+APP+"\n");
	//var apppath = DK_CallFunc("DKBuildGUI::GetAppPath", DKWidget_GetValue("AppList"));
	
	//DKSendEvent("DKMenuRight.html", "SetPanel", "App");
	//DKSendEvent("DKMenuRightApp.html", "Update", "");
	//DKSendEvent("DKMenuRightWeb.html", "Update", "");
}

//////////////////////////////
function DKBuildGUI_OsSelect()
{
	OS = DKWidget_GetValue("OSList");
	DKLog("OS = "+OS+"\n");
}

/////////////////////////////////
function DKBuildGUI_BuildSelect()
{
	TYPE = DKWidget_GetValue("BuildType");
	DKLog("TYPE = "+TYPE+"\n");
}

/*
//////////////////////////////////
function DKBuildGUI_UpdateLibs()
{
	///// Update Libraries
	DKWidget_SetInnerHtml("LibList", ""); //clear

	return;
	var result = DK_CallFunc("DKBuildGUI::GetLibList", "");
	DKLog("Result:"+result);
	
	var libs = result.split(",");
	
	//Add Libraries
	var id = DKWidget_CreateElement("LibList", "option", "BuildLibraries");
	DKWidget_SetAttribute(id, "value", "Build All Libraries");
	DKWidget_SetInnerHtml(id, "Build All Libraries");
	DKAddEvent(id, "click", DKBuildGUI_OnEvent);

	for(i=0; i<libs.length; ++i){
		var id2 = DKWidget_CreateElement("LibList", "option", "LIBRARY");
		DKWidget_SetAttribute(id2, "value", libs[i]);
		DKWidget_SetInnerHtml(id2, libs[i]);
		DKAddEvent(id2, "click", DKBuildGUI_OnEvent);
	}
}
*/