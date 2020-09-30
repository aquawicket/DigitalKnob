//////////////////////////
function DKBuildGUI_Init()
{
	//DKCreate("DKBuild/DKBuild.js", function(){});
	DKCreate("DKBuild/DKBuildGUI.html", function(){
	DKCreate("DKFile/DKFile.js", function(){
	DKCreate("DKBuild/DKBuild.js", function(rval){
		//byId("AppList").addEventListener("click", DKBuildGUI_OnEvent);
		byId("AppList").addEventListener("change", DKBuildGUI_OnEvent);
		byId("OSList").addEventListener("change", DKBuildGUI_OnEvent);
		byId("BuildType").addEventListener("change", DKBuildGUI_OnEvent);
		byId("git").addEventListener("click", DKBuildGUI_OnEvent);
		byId("libraries").addEventListener("click", DKBuildGUI_OnEvent);
		byId("build").addEventListener("click", DKBuildGUI_OnEvent);
	
		//DKBuild_ValidateSvn();
		DKCreate("DKGit/DKGit.js", function(){
			//DKGit_ValidateGit();
		});
		DKBuild_ValidateCmake();
		DKBuild_ValidateVC2019();

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
	byId("AppList").removeEventListener("change", DKBuildGUI_OnEvent);
	byId("OSList").removeEventListener("change", DKBuildGUI_OnEvent);
	byId("BuildType").removeEventListener("change", DKBuildGUI_OnEvent);
	byId("git").removeEventListener("click", DKBuildGUI_OnEvent);
	byId("libraries").removeEventListener("click", DKBuildGUI_OnEvent);
	byId("build").removeEventListener("click", DKBuildGUI_OnEvent);
	DKClose("DKBuild/DKBuildGUI.html");
	DKClose("DKBuild/DKBuild.js");
}

//////////////////////////////////
function DKBuildGUI_OnEvent(event)
{
	//console.lof("DKBuildGUI_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	if(event.currentTarget.id == "AppList"){
		//if(DK_Type(event,"click")){
		//	DKBuildGUI_UpdateApps();
		//}
		if(event.type == "change"){
			DKBuildGUI_AppSelect();
		}
	}
	if(event.currentTarget.id == "OSList"){
		DKBuildGUI_OsSelect();
	}
	if(event.currentTarget.id == "BuildType"){
		DKBuildGUI_BuildSelect();
	}
	if(event.currentTarget.id == "git"){
		DKCreate("DKBuild/GitMenu.js", function(){
			DKMenu_ValidatePosition("DKBuild/GitMenu.html");
		});
	}
	if(event.currentTarget.id == "libraries"){
		DKCreate("DKBuild/LibraryMenu.js", function(){
			DKMenu_ValidatePosition("DKBuild/LibraryMenu.html");
		});
	}
	if(event.currentTarget.id == "build"){
		DKCreate("DKBuild/RunMenu.js", function(){
			DKMenu_ValidatePosition("DKBuild/RunMenu.html");
		});
	}		
	
	/*
	if(event.type == "NewApp"){
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
	byId("AppList").innerHTML == "";	
	DKBuild_GetAppList();
	
	for(var i=0; i<APP_LIST.length; ++i){
		//console.lof(APP_LIST[i]+"\n");
		var ele = DKWidget_CreateElement(byId("AppList"), "option", "al");
		byId(ele).innerHTML = APP_LIST[i];
		byId(ele).value = APP_LIST[i];
		//DKWidget_SetValue("AppList", "DKBuilder");
	}
}

///////////////////////////////
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
	//console.lof("APP = "+APP+"\n");
	//var apppath = DK_CallFunc("DKBuildGUI::GetAppPath", DKWidget_GetValue("AppList"));
	
	//DKSendEvent("DKMenuRight.html", "SetPanel", "App");
	//DKSendEvent("DKMenuRightApp.html", "Update", "");
	//DKSendEvent("DKMenuRightWeb.html", "Update", "");
}

//////////////////////////////
function DKBuildGUI_OsSelect()
{
	OS = DKWidget_GetValue("OSList");
	console.lof("OS = "+OS+"\n");
}

/////////////////////////////////
function DKBuildGUI_BuildSelect()
{
	TYPE = DKWidget_GetValue("BuildType");
	console.lof("TYPE = "+TYPE+"\n");
}

/*
//////////////////////////////////
function DKBuildGUI_UpdateLibs()
{
	///// Update Libraries
	DKWidget_SetInnerHtml("LibList", ""); //clear

	return;
	var result = DK_CallFunc("DKBuildGUI::GetLibList", "");
	console.lof("Result:"+result);
	
	var libs = result.split(",");
	
	//Add Libraries
	var id = DKWidget_CreateElement("LibList", "option", "BuildLibraries");
	byId(id).value = "Build All Libraries";
	DKWidget_SetInnerHtml(id, "Build All Libraries");
	byId(id).addEventListener("click", DKBuildGUI_OnEvent);

	for(i=0; i<libs.length; ++i){
		var id2 = DKWidget_CreateElement("LibList", "option", "LIBRARY");
		byId(id2).value = libs[i]);
		DKWidget_SetInnerHtml(id2, libs[i]);
		byId(id2).addEventListener("click", DKBuildGUI_OnEvent);
	}
}
*/