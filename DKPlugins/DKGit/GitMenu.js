var GIT = "";

///////////////////////
function GitMenu_Init()
{
	//DKLog("GitMenu_Init()\n", DKDEBUG);
	DKCreate("DKThreadPool");

	//DKLog(DK_GetOS()+"\n");
	if(DK_GetOS() == "Win32"){
		GIT = "C:/Program Files/Git/bin/git.exe";
		GIT = DKFile_GetShortName(GIT);
	}
	if(DK_GetOS() == "Win64"){
		GIT = "C:/Program Files/Git/bin/git.exe";
		GIT = DKFile_GetShortName(GIT);
	}
	if(DK_GetOS() == "Mac"){
		GIT = "git";
	}
	if(DK_GetOS() == "Linux"){
		GIT = "/usr/bin/git";
	}

	DKCreate("DKGit/GitMenu.html", function(){
		DKAddEvent("GLOBAL", "mousedown", GitMenu_OnEvent);
		DKAddEvent("Git Update", "click", GitMenu_OnEvent);
		DKAddEvent("Git Commit", "click", GitMenu_OnEvent);
	});
}

//////////////////////
function GitMenu_End()
{
	//DKLog("GitMenu_End()");
	
	DKRemoveEvents(GitMenu_OnEvent);
	DKClose("DKBuild/GitMenu.html");
}

///////////////////////////////
function GitMenu_OnEvent(event)
{
	//DKLog("GitMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event,"Git Update")){
		DKThread_DKQueue("GitUpdate","DKBuild_GitUpdate();");
	}
	if(DK_Id(event,"Git Commit")){
		DKThread_DKQueue("GitCommit","DKBuild_GitCommit();");
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKBuild/GitMenu.html")){
			return;
		}
	}
	DKClose("DKBuild/GitMenu.js");
}