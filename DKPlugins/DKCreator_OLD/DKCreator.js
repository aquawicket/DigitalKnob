DKCreate("DKCreator/DKCreator.html");
DKCreate("DKFile/DKFile.js");

/////////////////////////
function DKCreator_Init()
{
	DKAddEvent("body", "mousedown", DKCreator_OnEvent);
	DKAddEvent("logo", "click", DKCreator_OnEvent);
	DKAddEvent("logo", "mouseover", DKCreator_OnEvent);
	//DKAddEvent("AppList", "click", DKCreator_OnEvent);
	DKAddEvent("AppList", "change", DKCreator_OnEvent);
	DKAddEvent("settings", "click", DKCreator_OnEvent);
	DKAddEvent("Svn Update", "click", DKCreator_OnEvent);
	DKAddEvent("Svn Commit", "click", DKCreator_OnEvent);
	DKAddEvent("libraries", "click", DKCreator_OnEvent);
	DKAddEvent("build", "click", DKCreator_OnEvent);
	DKAddEvent("Build App", "click", DKCreator_OnEvent);
	DKAddEvent("Rebuild App", "click", DKCreator_OnEvent);
	DKAddEvent("Build All", "click", DKCreator_OnEvent);
	DKAddEvent("Rebuild All", "click", DKCreator_OnEvent);
	DKAddEvent("Copy Assets", "click", DKCreator_OnEvent);
	DKAddEvent("Run App", "click", DKCreator_OnEvent);
	DKAddEvent("toggleDatabase", "click", DKCreator_OnEvent);
	DKAddEvent("toggleNotepad", "click", DKCreator_OnEvent);
	DKAddEvent("LoginText", "click", DKCreator_OnEvent);
	DKAddEvent("spin", "click", DKCreator_OnEvent);
	DKAddEvent("DKCreator.html", "NewApp", DKCreator_OnEvent);
	DKAddEvent("spin", "click", DKCreator_OnEvent);
	
	var exename = DKFile_GetFullExeName();
	var version = DKFile_GetModifiedTime(exename);
	DKWidget_SetInnerHtml("version", version);
	
	if(DK_GetOS() == "Win32" ||  DK_GetOS() == "Win64"){
		DKWidget_SetValue("OSList", "WIN32");
	}
	if(DK_GetOS() == "Mac"){
		DKWidget_SetValue("OSList", "MAC");
	}
	if(DK_GetOS() == "iOS"){
		DKWidget_SetValue("OSList", "IOS");
	}
	if(DK_GetOS() == "Linux"){
		DKWidget_SetValue("OSList", "LINUX");
	}
	if(DK_GetOS() == "Android"){
		DKWidget_SetValue("OSList", "ANDROID");
	}
	
	DKWidget_SetValue("AppList", "DKCreator");
	DKWidget_SetValue("BuildType", "Release");
}

///////////////////////////////
function DKCreator_OnEvent(event)
{
	DKLog("DKCreator_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event,"spin")){
		DK_Crash();
	}
	if(DK_Id(event,"logo") && DK_Type(event,"mouseover")){
		DKLog("hover logo \n");
	}
	if(DK_Id(event,"logo") && DK_Type(event,"click")){
		DKSendEvent("DKMessage.html", "ShowMessage", "logo clicked");
	}
	if(DK_Id(event,"AppList")){
		//if(DK_Type(event,"click")){
		//	DKCreator_UpdateApps();
		//}
		if(DK_Type(event,"change")){
			DKCreator_AppSelect();
		}
	}
	if(DK_Id(event,"settings")){
		DKWidget_Show("update");
	}
	else{
		DKWidget_Hide("update");
	}
	if(DK_Id(event,"Svn Update")){
		DKLog("Svn Update \n");
		DKSendEvent("DKCreator", "SvnUpdate", "");
	}
	if(DK_Id(event,"Svn Commit")){
		DKLog("Svn Commit \n");
		DKSendEvent("DKCreator", "SvnCommit", "");
	}
	if(DK_Id(event,"libraries")){
		DKCreator_UpdateLibs();
		DKWidget_Show("LibList");
	}
	else{
		DKWidget_Hide("LibList");
	}
	if(DK_Id(event,"build")){
		DKWidget_Show("BuildList");
	}
	else{
		DKWidget_Hide("BuildList");
	}
	if(DK_Id(event,"toggleNotepad")){
		//DKWidget_Toggle("DKNotepad.html");
		DKCreate("DKNotepad/DKNotepad.js");
		//var assets = DKAssets_LocalAssets();
		var dkpath = "/../../../Docs/TODO.txt";
		DKNotepad_LoadFile(dkpath);
	}
	if(DK_Id(event,"LoginText")){
		DKWidget_Toggle("DKLogin.html");
		DKCreate("DKLogin/DKLogin.js");
	}
	
	if(DK_Id(event, "BuildLibraries")){
		DKLog("********** BuildLibraries **************");
		DKSendEvent("DKCreator", "BuildLibraries", DKWidget_GetValue("OSList")+","+DKWidget_GetValue("BuildType"));
	}
	if(DK_Id(event, "Build App")){
		DKSendEvent("DKCreator", "BuildApp", DKWidget_GetValue("AppList")+","+DKWidget_GetValue("OSList")+","+DKWidget_GetValue("BuildType"));
	}
	if(DK_Id(event, "Rebuild App")){
		DKSendEvent("DKCreator", "RebuildApp", DKWidget_GetValue("AppList")+","+DKWidget_GetValue("OSList")+","+DKWidget_GetValue("BuildType"));
	}
	if(DK_Id(event, "Build All")){
		DKLog("DKCreator::Build All: TODO", DKWARN);
		//DKSendEvent("DKCreator", "BuildApp", //DKWidget_GetValue("AppList")+","+DKWidget_GetValue("OSList")+","+DKWidget_GetValue("BuildType"));
	}
	if(DK_Id(event, "Rebuild All")){
		DKLog("DKCreator::Rebuild All: TODO", DKWARN);
		//DKSendEvent("DKCreator", "RebuildApp", //DKWidget_GetValue("AppList")+","+DKWidget_GetValue("OSList")+","+DKWidget_GetValue("BuildType"));
	}
	if(DK_Id(event, "Copy Assets")){
		DKSendEvent("DKCreator", "CopyAssets", DKWidget_GetValue("AppList")+","+DKWidget_GetValue("OSList")+","+DKWidget_GetValue("BuildType"));
	}
	if(DK_Id(event, "Run App")){
		DKSendEvent("DKCreator", "RunApp", DKWidget_GetValue("AppList")+","+DKWidget_GetValue("OSList")+","+DKWidget_GetValue("BuildType"));
	}
	
	if(DK_IdLike(event,"LIBRARY")){
		DKLog("LIB Clicked");
		var value = DKWidget_GetInnerHtml(DK_GetId(event));
		DKSendEvent("DKCreator", "BuildLib", value+","+DKWidget_GetValue("OSList")+","+DKWidget_GetValue("BuildType"));
	}
	
	if(DK_Type(event,"NewApp")){
		DKSendEvent("DKCreator", "NewApp", DK_GetValue(event));
		DKWidget_SetValue("AppList", DK_GetValue(event));
		DKSendEvent("MenuRight.html", "SetPanel", "App");

		//var apppath = DK_CallFunc("DKCreator::GetAppPath", DKWidget_GetValue("AppList"));
		//DKCreate("AppExplorer.js");
		//DKSendEvent("AppExplorer.html", "UpdateAppExplorer", apppath);
	}
	
}

///////////////////////////////
function DKCreator_UpdateApps()
{
	////////  Update App List /////////////
	DKWidget_SetInnerHtml("AppList", "");

	var newApp = DKWidget_CreateElement("AppList", "option", "NewApp");
	DKWidget_SetAttribute(newApp, "value", "NEW APP");
	DKWidget_SetInnerHtml(newApp, "NEW APP");

	//Add apps
	var result = DK_CallFunc("DKCreator::GetAppList", "");
	var applist = result.split(",");

	for(i=0; i<applist.length; i++){
		var element = DKWidget_CreateElement("AppList", "option", "APP");
		DKWidget_SetAttribute(element, "value", applist[i]);
		DKWidget_SetInnerHtml(element, applist[i]);
	}	
}

//////////////////////////////
function DKCreator_AppSelect()
{
	// We can send events to classes that are not of DKWidget as well.
	if(DKWidget_GetValue("AppList") == "NEW APP"){
		DKCreate("DKMessage/DKMessage.js");
		DKSendEvent("DKMessage.html", "GetInput", "NewApp,DKCreator.html"); // To -> DKMessageBox
		return;
	}
	
	var apppath = DK_CallFunc("DKCreator::GetAppPath", DKWidget_GetValue("AppList"));
	
	DKSendEvent("DKMenuRight.html", "SetPanel", "App");
	DKSendEvent("DKMenuRightApp.html", "Update", "");
	DKSendEvent("DKMenuRightWeb.html", "Update", "");
}

/////////////////////////////////////
function DKCreator_OnMouseOver(event)
{
	if(DK_Id(event,"logo")){
		var tooltip = "Powered By DigitalKnob";
		DKSendEvent("DKTooltip.html", "show_tooltip", tooltip);
	}
}

/////////////////////////////
function DKCreator_UpdateLibs()
{
	///// Update Libraries
	DKWidget_SetInnerHtml("LibList", ""); //clear

	var result = DK_CallFunc("DKCreator::GetLibList", "");
	DKLog("Result:"+result);
	
	var libs = result.split(",");
	
	//Add Libraries
	var id = DKWidget_CreateElement("LibList", "option", "BuildLibraries");
	DKWidget_SetAttribute(id, "value", "Build All Libraries");
	DKWidget_SetInnerHtml(id, "Build All Libraries");
	DKAddEvent(id, "click", DKCreator_OnEvent);

	for(i=0; i<libs.length; ++i){
		var id2 = DKWidget_CreateElement("LibList", "option", "LIBRARY");
		DKWidget_SetAttribute(id2, "value", libs[i]);
		DKWidget_SetInnerHtml(id2, libs[i]);
		DKAddEvent(id2, "click", DKCreator_OnEvent);
	}
}