///////////////////////
function RunMenu_Init()
{
	DKCreate("DKBuild/RunMenu.html");
	DKWidget_SetProperty("RunMenu.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("RunMenu.html","left",DKWindow_GetMouseX()+"px");
	DKAddEvent("GLOBAL", "mousedown", RunMenu_OnEvent);
	DKAddEvent("Build App", "click", RunMenu_OnEvent);
	DKAddEvent("Rebuild App", "click", RunMenu_OnEvent);
	DKAddEvent("Rebuild All", "click", RunMenu_OnEvent);
	DKAddEvent("Copy Assets", "click", RunMenu_OnEvent);
	DKAddEvent("Run App", "click", RunMenu_OnEvent);
	DKAddEvent("Export to Android Studio", "click", RunMenu_OnEvent);
}

//////////////////////
function RunMenu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", RunMenu_OnEvent);
	DKClose("DKBuild/RunMenu.html");
}

///////////////////////////////
function RunMenu_OnEvent(event)
{
	if(DK_Id(event, "Build App")){
		OS = DKWidget_GetValue("OSList");
		APP = DKWidget_GetValue("AppList");
		TYPE = DKWidget_GetValue("BuildType");
		LINK = DKWidget_GetValue("LinkType");
		LEVEL = "Build";
		DKThread_DKQueue("BuildApp "+APP+":"+OS+":"+TYPE+":"+LINK+":"+LEVEL, "DKBuild_DoResults();");
	}
	if(DK_Id(event, "Rebuild App")){
		OS = DKWidget_GetValue("OSList");
		APP = DKWidget_GetValue("AppList");
		TYPE = DKWidget_GetValue("BuildType");
		LINK = DKWidget_GetValue("LinkType");
		LEVEL = "Rebuild";
		DKThread_DKQueue("RebuildApp "+APP+":"+OS+":"+TYPE+":"+LINK+":"+LEVEL, "DKBuild_DoResults();");
	}
	if(DK_Id(event, "Rebuild All")){
		OS = DKWidget_GetValue("OSList");
		APP = DKWidget_GetValue("AppList");
		TYPE = DKWidget_GetValue("BuildType");
		LINK = DKWidget_GetValue("LinkType");
		LEVEL = "RebuildAll";
		DKThread_DKQueue("BuildAll "+APP+":"+OS+":"+TYPE+":"+LINK+":"+LEVEL, "DKBuild_DoResults();");
	}
	if(DK_Id(event, "Copy Assets")){
		DKLog("DKBuildGUI::Copy Assets: TODO", DKWARN);
	}
	if(DK_Id(event, "Run App")){
		OS = DKWidget_GetValue("OSList");
		if(DK_GetOS() == "Win32" || DK_GetOS() == "Win64"){
			if(OS == "win32"){
				DK_Run(DKPATH+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+".exe");
				DK_Run(DKPATH+"/USER/DKApps/"+APP+"/"+OS+"/Release/"+APP+".exe");
			}
			if(OS == "win64"){
				DK_Run(DKPATH+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+"_64.exe");
				DK_Run(DKPATH+"/USER/DKApps/"+APP+"/"+OS+"/Release/"+APP+"_64.exe");
			}
			if(OS == "android"){
				DKLog("TODO: Run android from Windows \n", DKDEBUG);
			}
		}
		if(DK_GetOS() == "Mac"){
			if(OS == "mac"){
				DKLog("TODO: Run mac apps from OSX \n", DKDEBUG);
			}
			if(OS = "ios"){
				DKLog("TODO: Run iOS apps from OSX \n", DKDEBUG);
			}
			if(OS = "ios-simulator"){
				DKLog("TODO: Run iOS-simulator apps from OSX \n", DKDEBUG);
			}
		}
		if(DK_GetOS() == "Linux"){
			if(OS = "linux"){
				DKLog("TODO: Run linux apps from Linux \n", DKDEBUG);
			}
		}
	}
	
	if(DK_Id(event, "Export to Android Studio")){
		DKLog("Export to Android Studio \n", DKDEBUG);
		DKCreate("DKBuild/AndroidImport.js", function(){
			AndroidImport_Import();
		});
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "RunMenu.html")){
			return;
		}
	}
	DKClose("DKBuild/RunMenu.js");
}