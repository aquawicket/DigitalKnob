var GIT = "";

/////////////////////
function DKGit_Init()
{	
	DKGit_SetGitPath()
	DKGit_ValidateGit();
}

////////////////////
function DKGit_End()
{

}

///////////////////////////////
function DKGit_OnEvent(event)
{

}

///////////////////////////
function DKGit_SetGitPath()
{
	if(CPP_DKDuktape_GetOS() === "Win32" || CPP_DKDuktape_GetOS() === "Win64"){
		GIT = "C:/Program Files/Git/bin/git.exe";
		GIT = CPP_DKFile_GetShortName(GIT);
		console.log("GIT: "+GIT);
	}
	if(CPP_DKDuktape_GetOS() === "Mac"){
		GIT = "git";
	}
	if(CPP_DKDuktape_GetOS() === "Linux"){
		GIT = "/usr/bin/git";
	}
}

////////////////////////////
function DKGit_ValidateGit()
{
	//if(CPP_DKDuktape_GetBrowser() !== "RML"){ return; }
	console.log("Looking for GIT\n");
	if(!CPP_DKFile_Exists(GIT)){
		DKGit_InstallGit();
		DKGit_SetGitPath();
	}
}

///////////////////////////
function DKGit_InstallGit()
{
	//if(CPP_DKDuktape_GetBrowser() !== "RML"){ return; }
	console.log("Installing Git...\n");
	var assets = CPP_DKAssets_LocalAssets();
	
	if(CPP_DKDuktape_GetOS() === "Win32"){
		CPP_DKCurl_Download("https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-32-bit.exe", assets);
		CPP_DKDuktape_System(assets+"/Git-2.30.1-32-bit.exe");
	}
	else if(CPP_DKDuktape_GetOS() === "Win64"){
		CPP_DKCurl_Download("https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-64-bit.exe", assets);
		CPP_DKDuktape_System(assets+"/Git-2.30.1-64-bit.exe");
	}
	else if(CPP_DKDuktape_GetOS() === "Mac"){
		//TODO
	}
	else if(CPP_DKDuktape_GetOS() === "Linux"){
		CPP_DKDuktape_Execute("sudo apt-get install git");
	}
	else{
		console.log("ERROR: unrecognied HOST OS: "+CPP_DKDuktape_GetOS()+"\n");
	}
}

//////////////////////////
function DKGit_GitUpdate()
{
	//if(CPP_DKDuktape_GetBrowser() !== "CEF" && CPP_DKDuktape_GetBrowser() !== "RML"){
	//	console.error("DKGit_GitUpdate(): Incompatable browser");
	//	return;
	//}
	
	console.log("Git Update DigitalKnob...\n");
	CPP_DKDuktape_Execute(GIT +" clone https://github.com/aquawicket/DigitalKnob.git "+DKPATH+"/DK");
	CPP_DKFile_ChDir(DKPATH+"/DK");
	CPP_DKDuktape_Execute(GIT +" checkout -- .");
	CPP_DKDuktape_Execute(GIT +" pull origin master");
	
	//Multipe user folders
	var contents = CPP_DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //console.log("files["+i+"] = "+files[i]+"\n");
		CPP_DKFile_ChDir(DKPATH);
		if(CPP_DKFile_IsDirectory(files[i])){ continue; }
		var url = CPP_DKFile_GetSetting(files[i], "[MYGIT]");
		if(url){ //console.log("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); //console.log("folder = "+folder+"\n");
			console.log("Git Update "+folder+"...\n");
			CPP_DKFile_ChDir(DKPATH+"/"+folder);
			CPP_DKDuktape_Execute(GIT +" clone "+url+" "+DKPATH+"/"+folder);
			CPP_DKDuktape_Execute(GIT +" checkout -- .");
			CPP_DKDuktape_Execute(GIT +" pull origin master");
		}
	}
	
	if(CPP_DKDuktape_Available("DKAudio")){
		DK_Create("DKAudio");
	}
	if(CPP_DKDuktape_Valid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}

//////////////////////////
function DKGit_GitCommit()
{
	//if(CPP_DKDuktape_GetBrowser() !== "CEF" && CPP_DKDuktape_GetBrowser() !== "RML"){
	//	console.error("DKGit_GitCommit(): Incompatable browser");
	//	return;
	//}
	
	console.log("Git Commit DigitalKnob...\n");
	CPP_DKFile_ChDir(DKPATH+"/DK");
	CPP_DKDuktape_Execute(GIT +" init");
	CPP_DKDuktape_Execute(GIT +" config user.name \"dkuser\"");
	CPP_DKDuktape_Execute(GIT +" config user.email \"dkuser@digitalknob.com\"");
	CPP_DKDuktape_Execute(GIT +" commit -a -m \"commit from git\"");
	CPP_DKDuktape_Execute(GIT +" config credential.helper store"); //store credentials 
	CPP_DKDuktape_Execute(GIT +" push");
	
	//Multipe user folders
	var contents = CPP_DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //console.log("files["+i+"] = "+files[i]+"\n");
		CPP_DKFile_ChDir(DKPATH);
		if(CPP_DKFile_IsDirectory(files[i])){ continue; }
		var url = CPP_DKFile_GetSetting(files[i], "[MYGIT]");
		if(url){ //console.log("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); //console.log("folder = "+folder+"\n");
			console.log("Git Commit "+folder+"... \n");
			CPP_DKFile_ChDir(DKPATH+"/"+folder);
			CPP_DKDuktape_Execute(GIT +" init");
			CPP_DKDuktape_Execute(GIT +" config user.name \"dkuser\"");
			CPP_DKDuktape_Execute(GIT +" config user.email \"dkuser@digitalknob.com\"");
			CPP_DKDuktape_Execute(GIT +" commit -a -m \"commit from git\"");
			CPP_DKDuktape_Execute(GIT +" config credential.helper store"); //store credentials 
			CPP_DKDuktape_Execute(GIT +" push");
		}
	}
	
	/*
	if(CPP_DKDuktape_Available("DKAudio")){
		DK_Create("DKAudio");
	}
	if(CPP_DKDuktape_Valid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
	*/
}

///////////////////////////////
function DKGit_GitCredentials()
{
	//TODO
	//how do we let git remember our login for repositories
	//we don't want to have to log in every time we need to commit.
}
