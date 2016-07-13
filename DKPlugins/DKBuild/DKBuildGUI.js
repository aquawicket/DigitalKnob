//////////////////////////
function DKBuildGUI_Init()
{
	//DKLog("DKBuildGUI_Init() \n");
	DKCreate("DKThreadJS");
	DKCreate("DKRocketJS");
	DKCreate("DKWidgetJS");
	DKCreate("DKFileJS");
	DKCreate("DKWindow");
	DKCreate("DKRocket");
	DKCreate("DKBuild/DKBuildGUI.html");
	DKCreate("DKBuild/DKBuild.html,DKBuildGUI.html");
	DKCreate("DKFile/DKFile.js");
	//DKAddEvent("AppList", "click", DKBuildGUI_OnEvent);
	DKAddEvent("AppList", "change", DKBuildGUI_OnEvent);
	DKAddEvent("svn", "click", DKBuildGUI_OnEvent);
	DKAddEvent("libraries", "click", DKBuildGUI_OnEvent);
	DKAddEvent("build", "click", DKBuildGUI_OnEvent);
	//DKAddEvent("DKBuildGUI.html", "NewApp", DKBuildGUI_OnEvent);
	
	DKBuild_ValidateSvn();
	DKBuild_ValidateCmake();
	DKBuild_ValidateVC2015();

	if(DK_GetOS() == "WIN32" ||  DK_GetOS() == "WIN64"){
		DKWidget_SetValue("OSList", "win32");
	}
	if(DK_GetOS() == "MAC"){
		DKWidget_SetValue("OSList", "mac64");
	}
	if(DK_GetOS() == "LINUX"){
		DKWidget_SetValue("OSList", "linux64");
	}

	if(DK_GetOS() == "LINUX"){
		DKWidget_SetValue("BuildType", "Release");
	}
	else{
		DKWidget_SetValue("BuildType", "ALL");
	}
	
	if(DK_GetOS() == "ANDROID"){ return; } //FIXME - android not ready
	DKBuildGUI_UpdateApps();
}

/////////////////////////
function DKBuildGUI_End()
{
	DKClose("DKBuildGUI.html");
	DKClose("DKBuild.html");
}

//////////////////////////////////
function DKBuildGUI_OnEvent(event)
{
	if(DK_Id(event,"AppList")){
		//if(DK_Type(event,"click")){
		//	DKBuildGUI_UpdateApps();
		//}
		if(DK_Type(event,"change")){
			DKBuildGUI_AppSelect();
		}
	}
	if(DK_Id(event,"svn")){
		DKCreate("DKBuild/SvnMenu.js");
	}
	if(DK_Id(event,"libraries")){
		DKCreate("DKBuild/LibraryMenu.js");
	}
	if(DK_Id(event,"build")){
		DKCreate("DKBuild/RunMenu.js");
	}		
	
	/*
	if(DK_Type(event,"NewApp")){
		DKSendEvent("DKBuildGUI", "NewApp", DKWidget_GetValue(event));
		DKWidget_SetValue("AppList", DKWidget_GetValue(event));
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
		var ele = DKWidget_CreateElement("AppList", "option", "al");
		DKWidget_SetInnerHtml(ele, APP_LIST[i]);
		DKWidget_SetAttribute(ele, "value", APP_LIST[i]);
		DKWidget_SetValue("AppList", "DKBuilder");
	}
}

/////////////////////////////////
function DKBuildGUI_AppSelect()
{
	// We can send events to classes that are not of DKWidget as well.
	if(DKWidget_GetValue("AppList") == "NEW APP"){
		DKCreate("DKMessage/DKMessage.js");
		DKSendEvent("DKMessage.html", "GetInput", "NewApp,DKBuildGUI.html"); // To -> DKMessageBox
		return;
	}
	
	APP = DKWidget_GetValue("AppList");
	DKLog("OS: "+OS+"\n");
	//var apppath = DK_CallFunc("DKBuildGUI::GetAppPath", DKWidget_GetValue("AppList"));
	
	//DKSendEvent("DKMenuRight.html", "SetPanel", "App");
	//DKSendEvent("DKMenuRightApp.html", "Update", "");
	//DKSendEvent("DKMenuRightWeb.html", "Update", "");
}

/*
//////////////////////////////////
function DKBuildGUI_UpdateLibs()
{
	///// Update Libraries
	DKWidget_SetInnerHtml("LibList", ""); //clear

	return;
	var result = DK_CallFunc("DKBuildGUI::GetLibList", "");
	DKLog("Result:"+result, DKDEBUG);
	
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