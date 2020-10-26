//////////////////////////
function DKBuildGUI_Init()
{
	//DK_Create("DKBuild/DKBuild.js", function(){});
	DK_Create("DKBuild/DKBuildGUI.html", function(){
	DK_Create("DKFile/DKFile.js", function(){
	DK_Create("DKBuild/DKBuild.js", function(rval){
		//byId("AppList").addEventListener("click", DKBuildGUI_OnEvent);
		byId("AppList").addEventListener("change", DKBuildGUI_OnEvent);
		byId("OSList").addEventListener("change", DKBuildGUI_OnEvent);
		byId("BuildType").addEventListener("change", DKBuildGUI_OnEvent);
		byId("git").addEventListener("click", DKBuildGUI_OnEvent);
		byId("libraries").addEventListener("click", DKBuildGUI_OnEvent);
		byId("build").addEventListener("click", DKBuildGUI_OnEvent);
	
		//DKBuild_ValidateSvn();
		DK_Create("DKGit/DKGit.js", function(){
			//DKGit_ValidateGit();
		});
		DKBuild_ValidateCmake();
		DKBuild_ValidateVC2019();

		/*
		if(DK_GetOS() === "Win32" ||  DK_GetOS() === "Win64"){
			byId("OSList").value = "win32";
		}
		if(DK_GetOS() === "Mac"){
			byId("OSList").value = "mac64";
		}	
		if(DK_GetOS() === "Linux"){
			byId("OSList").value = "linux64";
		}	

		if(DK_GetOS() === "Linux"){
			byId("BuildType").value = "Release";
		}
		else{
			byId("BuildType").value = "ALL";
		}
	
		if(DK_GetOS() === "Android"){ return; } //FIXME - android not ready
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
	DK_Close("DKBuild/DKBuildGUI.html");
	DK_Close("DKBuild/DKBuild.js");
}

//////////////////////////////////
function DKBuildGUI_OnEvent(event)
{
	//console.log("DKBuildGUI_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	if(event.currentTarget.id === "AppList"){
		//if(DK_Type(event,"click")){
		//	DKBuildGUI_UpdateApps();
		//}
		if(event.type === "change"){
			DKBuildGUI_AppSelect();
		}
	}
	if(event.currentTarget.id === "OSList"){
		DKBuildGUI_OsSelect();
	}
	if(event.currentTarget.id === "BuildType"){
		DKBuildGUI_BuildSelect();
	}
	if(event.currentTarget.id === "git"){
		DK_Create("DKGit/GitMenu.js", function(){
			DKMenu_ValidatePosition("DKGit/GitMenu.html");
		});
	}
	if(event.currentTarget.id === "libraries"){
		DK_Create("DKBuild/LibraryMenu.js", function(){
			DKMenu_ValidatePosition("DKBuild/LibraryMenu.html");
		});
	}
	if(event.currentTarget.id === "build"){
		DK_Create("DKBuild/RunMenu.js", function(){
			DKMenu_ValidatePosition("DKBuild/RunMenu.html");
		});
	}		
	
	/*
	if(event.type === "NewApp"){
		DKSendEvent("DKBuildGUI", "NewApp", DKWidget_GetValue(event));
		byId("AppList").value = DKWidget_GetValue(event);
		//DKSendEvent("MenuRight.html", "SetPanel", "App");

		//var apppath = DK_CallFunc("DKBuildGUI::GetAppPath", byId("AppList").value);
		//DK_Create("AppExplorer.js");
		//DKSendEvent("AppExplorer.html", "UpdateAppExplorer", apppath);
	}
	*/
}

////////////////////////////////
function DKBuildGUI_UpdateApps()
{
	////////  Update App List /////////////
	byId("AppList").innerHTML === "";	
	DKBuild_GetAppList();
	
	for(var i=0; i<APP_LIST.length; ++i){
		//console.log(APP_LIST[i]+"\n");
		var ele = DK_CreateElement(byId("AppList"), "option", "al");
		ele.innerHTML = APP_LIST[i];
		ele.value = APP_LIST[i];
		byId("AppList").value = "DKBuilder";
	}
}

///////////////////////////////
function DKBuildGUI_AppSelect()
{
	// We can send events to classes that are not of DKWidget as well.
	if(byId("AppList").value === "NEW APP"){
		DK_Create("DKGui/DKMessageBox.js", function(){
			DKSendEvent("DKGui/DKMessageBox.html", "GetInput", "NewApp,DKBuildGUI.html"); // To -> DKMessageBox
		});
		return;
	}
	
	APP = byId("AppList").value;
	//console.log("APP = "+APP+"\n");
	//var apppath = DK_CallFunc("DKBuildGUI::GetAppPath", byId("AppList").value);
	
	//DKSendEvent("DKMenuRight.html", "SetPanel", "App");
	//DKSendEvent("DKMenuRightApp.html", "Update", "");
	//DKSendEvent("DKMenuRightWeb.html", "Update", "");
}

//////////////////////////////
function DKBuildGUI_OsSelect()
{
	OS = byId("OSList").value;
	console.log("OS = "+OS+"\n");
}

/////////////////////////////////
function DKBuildGUI_BuildSelect()
{
	TYPE = byId("BuildType").value;
	console.log("TYPE = "+TYPE+"\n");
}

/*
//////////////////////////////////
function DKBuildGUI_UpdateLibs()
{
	///// Update Libraries
	byId("LibList").innerHTML = ""; //clear

	return;
	var result = DK_CallFunc("DKBuildGUI::GetLibList", "");
	console.log("Result:"+result);
	
	var libs = result.split(",");
	
	//Add Libraries
	var id = DK_CreateElement(byId("LibList"), "option", "BuildLibraries");
	id.value = "Build All Libraries";
	id.innerHTML = "Build All Libraries";
	id.addEventListener("click", DKBuildGUI_OnEvent);

	for(i=0; i<libs.length; ++i){
		var id2 = DK_CreateElement(byId("LibList"), "option", "LIBRARY");
		id2.value = libs[i]);
		id2.innerHTML = libs[i];
		id2.addEventListener("click", DKBuildGUI_OnEvent);
	}
}
*/