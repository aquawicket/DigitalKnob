var GIT = "";

///////////////////////
function GitMenu_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKBuild/DKBuild.js", function(){});
	DKCreate("DKThreadPool");

	//DKINFO(DK_GetOS()+"\n");
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
		DKAddEvent("window", "mousedown", GitMenu_OnEvent);
		DKAddEvent("Git Update", "click", GitMenu_OnEvent);
		DKAddEvent("Git Commit", "click", GitMenu_OnEvent);
	});
}

//////////////////////
function GitMenu_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(GitMenu_OnEvent);
	DKClose("DKGit/GitMenu.html");
}

///////////////////////////////
function GitMenu_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(DK_Id(event,"Git Update")){
		DKThread_DKQueue("GitUpdate","GitMenu_GitUpdate();");
	}
	if(DK_Id(event,"Git Commit")){
		//DKThread_DKQueue("GitCommit","GitMenu_GitCommit();");
		GitMenu_GitCommit();
	}
	
	if(DK_Id(event, "window")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKGit/GitMenu.html")){
			return;
		}
	}
	DKClose("DKGit/GitMenu.js");
}

//////////////////////////////
function GitMenu_ValidateGit()
{
	DKDEBUGFUNC();
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKINFO("Looking for GIT\n");
	//DKINFO(GIT+"\n");
	if(!DKFile_Exists(GIT)){
		DKINFO("Please install GIT\n");
		GitMenu_InstallGit();
	}
	DKINFO("Found GIT\n");
	if(DK_GetOS() == "Mac"){
		GIT = "git";
	}
}

/////////////////////////////
function GitMenu_InstallGit()
{
	DKDEBUGFUNC();
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKINFO("Installing Git\n");
	var assets = DKAssets_LocalAssets();
	
	if(DK_GetOS() == "Win32"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Git-2.11.0-32-bit.exe", assets);
		DK_System(assets+"/Git-2.11.0-32-bit.exe");
	}
	else if(DK_GetOS() == "Win64"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Git-2.11.0-64-bit.exe", assets);
		DK_System(assets+"/Git-2.11.0-64-bit.exe");
	}
	else if(DK_GetOS() == "Mac"){
		//TODO
	}
	else if(DK_GetOS() == "Linux"){
		DK_Execute("sudo apt-get install git");
	}
	else{
		DKINFO("ERROR: unrecognied HOST OS: "+DK_GetOS()+"\n");
	}
}

////////////////////////////
function GitMenu_GitUpdate()
{
	DKDEBUGFUNC();
	if(DK_GetBrowser() != "CEF" && DK_GetBrowser() != "Rocket"){
		return;
	}
	
	DKINFO("Git Update DigitalKnob...\n");
	DK_Execute(GIT +" clone https://github.com/aquawicket/DigitalKnob.git "+DKPATH+"/DK");
	DKFile_ChDir(DKPATH+"/DK");
	DK_Execute(GIT +" checkout -- .");
	DK_Execute(GIT +" pull origin master");
	
	//Multipe user folders
	var contents = DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //DKINFO("files["+i+"] = "+files[i]+"\n");
		DKFile_ChDir(DKPATH);
		if(DKFile_IsDirectory(files[i])){ continue; }
		var url = DKFile_GetSetting(files[i], "[MYGIT]");
		if(url){ //DKINFO("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); //DKINFO("folder = "+folder+"\n");
			DKINFO("Git Update "+folder+"...\n");
			DK_Execute(GIT +" clone "+url+" "+DKPATH+"/"+folder);
			DK_Execute(GIT +" checkout -- .");
			DK_Execute(GIT +" pull origin master");
		}
	}
	
	if(DKAvailable("DKAudio")){
		DKCreate("DKAudio");
	}
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}

////////////////////////////
function GitMenu_GitCommit()
{
	DKDEBUGFUNC();
	if(DK_GetBrowser() != "CEF" && DK_GetBrowser() != "RML"){
		return;
	}
	
	DKINFO("Git Commit DigitalKnob...\n");
	DKFile_ChDir(DKPATH+"/DK");
	DK_Execute(GIT +" init");
	DK_Execute(GIT +" config user.name \"dkuser\"");
	DK_Execute(GIT +" config user.email \"dkuser@digitalknob.com\"");
	DK_Execute(GIT +" commit -a -m \"commit from git\"");
	DK_Execute(GIT +" config credential.helper store"); //store credentials 
	DK_Execute(GIT +" push");
	
	//Multipe user folders
	var contents = DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //DKINFO("files["+i+"] = "+files[i]+"\n");
		DKFile_ChDir(DKPATH);
		if(DKFile_IsDirectory(files[i])){ continue; }
		var url = DKFile_GetSetting(files[i], "[MYGIT]");
		if(url){ //DKINFO("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); //DKINFO("folder = "+folder+"\n");
			DKINFO("Git Commit "+folder+"...\n");
			DKFile_ChDir(DKPATH+"/"+folder);
			DK_Execute(GIT +" init");
			DK_Execute(GIT +" config user.name \"dkuser\"");
			DK_Execute(GIT +" config user.email \"dkuser@digitalknob.com\"");
			DK_Execute(GIT +" commit -a -m \"commit from git\"");
			DK_Execute(GIT +" config credential.helper store"); //store credentials 
			DK_Execute(GIT +" push");
		}
	}
	
	if(DKAvailable("DKAudio")){
		DKCreate("DKAudio");
	}
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}