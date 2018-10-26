///////////////////////
function RunMenu_Init()
{
	DKLog("RunMenu_Init()", DKDEBUG);
	DKCreate("DKBuild/RunMenu.html");
	DKAddEvent("GLOBAL", "mousedown", RunMenu_OnEvent);
	DKAddEvent("Build App", "click", RunMenu_OnEvent);
	DKAddEvent("Rebuild App", "click", RunMenu_OnEvent);
	DKAddEvent("Rebuild All", "click", RunMenu_OnEvent);
	DKAddEvent("Copy Assets", "click", RunMenu_OnEvent);
	DKAddEvent("Run App", "click", RunMenu_OnEvent);
	DKAddEvent("Generate Docs", "click", RunMenu_OnEvent);
	DKAddEvent("Export to Android Studio", "click", RunMenu_OnEvent);
}

//////////////////////
function RunMenu_End()
{
	DKLog("RunMenu_End()", DKDEBUG);
	DKRemoveEvents(RunMenu_OnEvent);
	DKClose("DKBuild/RunMenu.html");
}

///////////////////////////////
function RunMenu_OnEvent(event)
{
	DKLog("RunMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
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
		APP = DKWidget_GetValue("AppList");
		if(DK_GetOS() == "Win32" || DK_GetOS() == "Win64"){
			if(OS == "win32"){
				DK_Run(DKPATH+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+".exe");
				var contents = DKFile_DirectoryContents(DKPATH);
				var files = contents.split(",");
				for(var i=0; i<files.length; i++){
					if(DKFile_Exists(DKPATH+"/"+files[i]+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+".exe")){
						//DKLog(DKPATH+"/"+files[i]+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+".exe\n");
						DK_Run(DKPATH+"/"+files[i]+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+".exe");
						return;
					}
				}
			}
			if(OS == "win64"){
				DK_Run(DKPATH+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+"_64.exe");
				DK_Run(DKPATH+"/USER/DKApps/"+APP+"/"+OS+"/Release/"+APP+"_64.exe");
				
				DK_Run(DKPATH+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+"_64.exe");
				var contents = DKFile_DirectoryContents(DKPATH);
				var files = contents.split(",");
				for(var i=0; i<files.length; i++){
					if(DKFile_Exists(DKPATH+"/"+files[i]+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+"_64.exe")){
						//DKLog(DKPATH+"/"+files[i]+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+"_64.exe\n");
						DK_Run(DKPATH+"/"+files[i]+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+"_64.exe");
						return;
					}
				}
			}
			if(OS == "android"){
				DKLog("TODO: Run android from Windows \n");
			}
		}
		if(DK_GetOS() == "Mac"){
			if(OS == "mac"){
				DKLog("TODO: Run mac apps from OSX \n");
			}
			if(OS = "ios"){
				DKLog("TODO: Run iOS apps from OSX \n");
			}
			if(OS = "ios-simulator"){
				DKLog("TODO: Run iOS-simulator apps from OSX \n");
			}
		}
		if(DK_GetOS() == "Linux"){
			//if(OS == "linux64"){
				//DKLog("TODO: Run linux apps from Linux \n");
				if(DKFile_Exists(DKPATH+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+".desktop")){
					DK_Run(DKPATH+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+".desktop");
				}
				var contents = DKFile_DirectoryContents(DKPATH);
				var files = contents.split(",");
				for(var i=0; i<files.length; i++){
					if(DKFile_Exists(DKPATH+"/"+files[i]+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+".desktop")){
						//DKLog(DKPATH+"/"+files[i]+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+".desktop\n");
						DK_Run(DKPATH+"/"+files[i]+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+".desktop");
						return;
					}
				}
			//}
		}
	}
	
	//TODO
	if(DK_Id(event, "Generate Docs")){
		DKLog("Generate Docs: TODO \n");
		var doxy_path = "C:/Program Files/doxygen/bin/doxygen.exe";
		var doxy_file = DKPATH+"/DKDocs/Doxyfile";
		var doxy_exe = DKFile_GetShortName(doxy_path);
		DKFile_ChDir(DKPATH+"/DKDocs/"); 
		DK_Execute(doxy_exe+" "+doxy_file);		
	}
	
	if(DK_Id(event, "Export to Android Studio")){
		DKLog("Export to Android Studio \n");
		DKCreate("DKBuild/AndroidImport.js", function(){
			AndroidImport_Import();
		});
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(!DKWidget_GetHoverElement()){ return; }
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKBuild/RunMenu.html")){
			return;
		}
	}
	DKClose("DKBuild/RunMenu.js");
}