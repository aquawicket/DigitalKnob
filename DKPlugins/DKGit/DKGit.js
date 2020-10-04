var GIT = "";

/////////////////////
function DKGit_Init()
{
	//DKCreate("DKThreadPool");
	//console.log(DK_GetOS()+"\n");
	if(DK_GetOS() === "Win32"){
		GIT = "C:/Program Files/Git/bin/git.exe";
		GIT = DKCPP_DKFile_GetShortName(GIT);
	}
	if(DK_GetOS() === "Win64"){
		GIT = "C:/Program Files/Git/bin/git.exe";
		GIT = DKCPP_DKFile_GetShortName(GIT);
	}
	if(DK_GetOS() === "Mac"){
		GIT = "git";
	}
	if(DK_GetOS() === "Linux"){
		GIT = "/usr/bin/git";
	}
	
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

////////////////////////////
function DKGit_ValidateGit()
{
	if(DK_GetBrowser() !== "RML"){ return; }
	console.log("Looking for GIT\n");
	if(!DKCPP_DKFile_Exists(GIT)){
		DKGit_InstallGit();
	}
	console.log("Found GIT\n");
	if(DK_GetOS() === "Mac"){
		GIT = "git";
	}
}

///////////////////////////
function DKGit_InstallGit()
{
	if(DK_GetBrowser() !== "RML"){ return; }
	console.log("Installing Git...\n");
	var assets = DKAssets_LocalAssets();
	
	if(DK_GetOS() === "Win32"){
		DKCurl_Download("https://github.com/git-for-windows/git/releases/download/v2.26.2.windows.1/Git-2.26.2-32-bit.exe", assets);
		//DKCurl_Download("http://DigitalKnob.com/Download/Tools/Git-2.26.2-32-bit.exe", assets);
		DK_System(assets+"/Git-2.26.2-32-bit.exe");
	}
	else if(DK_GetOS() === "Win64"){
		DKCurl_Download("https://github.com/git-for-windows/git/releases/download/v2.26.2.windows.1/Git-2.26.2-64-bit.exe", assets);
		//DKCurl_Download("http://DigitalKnob.com/Download/Tools/Git-2.26.2-64-bit.exe", assets);
		DK_System(assets+"/Git-2.26.2-64-bit.exe");
	}
	else if(DK_GetOS() === "Mac"){
		//TODO
	}
	else if(DK_GetOS() === "Linux"){
		DK_Execute("sudo apt-get install git");
	}
	else{
		console.log("ERROR: unrecognied HOST OS: "+DK_GetOS()+"\n");
	}
}

//////////////////////////
function DKGit_GitUpdate()
{
	if(DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML"){
		return;
	}
	
	console.log("Git Update DigitalKnob...\n");
	DK_Execute(GIT +" clone https://github.com/aquawicket/DigitalKnob.git "+DKPATH+"/DK");
	DKFile_ChDir(DKPATH+"/DK");
	DK_Execute(GIT +" checkout -- .");
	DK_Execute(GIT +" pull origin master");
	
	//Multipe user folders
	var contents = DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //console.log("files["+i+"] = "+files[i]+"\n");
		DKFile_ChDir(DKPATH);
		if(DKFile_IsDirectory(files[i])){ continue; }
		var url = DKFile_GetSetting(files[i], "[MYGIT]");
		if(url){ //console.log("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); //console.log("folder = "+folder+"\n");
			console.log("Git Update "+folder+"...\n");
			DKFile_ChDir(DKPATH+"/"+folder);
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

//////////////////////////
function DKGit_GitCommit()
{
	if(DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML"){
		return;
	}
	
	console.log("Git Commit DigitalKnob...\n");
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
	for(var i=0; i<files.length; i++){ //console.log("files["+i+"] = "+files[i]+"\n");
		DKFile_ChDir(DKPATH);
		if(DKFile_IsDirectory(files[i])){ continue; }
		var url = DKFile_GetSetting(files[i], "[MYGIT]");
		if(url){ //console.log("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); //console.log("folder = "+folder+"\n");
			console.log("Git Commit "+folder+"... \n");
			DKFile_ChDir(DKPATH+"/"+folder);
			DK_Execute(GIT +" init");
			DK_Execute(GIT +" config user.name \"dkuser\"");
			DK_Execute(GIT +" config user.email \"dkuser@digitalknob.com\"");
			DK_Execute(GIT +" commit -a -m \"commit from git\"");
			DK_Execute(GIT +" config credential.helper store"); //store credentials 
			DK_Execute(GIT +" push");
		}
	}
	
	/*
	if(DKAvailable("DKAudio")){
		DKCreate("DKAudio");
	}
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
	*/
}

///////////////////////////////
function DKGit_GitCredentials()
{
	//TODO
	//how do we let git remember out login for repositories
	//we don't want to have to log in on every commit.
}
