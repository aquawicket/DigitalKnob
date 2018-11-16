var GIT = "";

/////////////////////
function DKGit_Init()
{
	DKDEBUGFUNC();
	//DKCreate("DKThreadPool");
	//console.log(DK_GetOS()+"\n");
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
	
	DKGit_ValidateGit();
}

////////////////////
function DKGit_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKGit_OnEvent);
}

///////////////////////////////
function DKGit_OnEvent(event)
{
	DKDEBUGFUNC(event);
}

////////////////////////////
function DKGit_ValidateGit()
{
	DKDEBUGFUNC();
	if(DK_GetBrowser() != "Rocket"){ return; }
	console.log("Looking for GIT\n");
	//console.log(GIT+"\n");
	if(!DKFile_Exists(GIT)){
		console.log("Please install GIT\n");
		GitMenu_InstallGit();
	}
	console.log("Found GIT\n");
	if(DK_GetOS() == "Mac"){
		GIT = "git";
	}
}

///////////////////////////
function DKGit_InstallGit()
{
	DKDEBUGFUNC();
	if(DK_GetBrowser() != "Rocket"){ return; }
	console.log("Installing Git\n");
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
		console.log("ERROR: unrecognied HOST OS: "+DK_GetOS()+"\n");
	}
}

//////////////////////////
function DKGit_GitUpdate()
{
	DKDEBUGFUNC();
	if(DK_GetBrowser() != "CEF" && DK_GetBrowser() != "Rocket"){
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
	DKDEBUGFUNC();
	if(DK_GetBrowser() != "CEF" && DK_GetBrowser() != "Rocket"){
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
	
	if(DKAvailable("DKAudio")){
		DKCreate("DKAudio");
	}
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}

///////////////////////////////
function DKGit_GitCredentials()
{
	DKDEBUGFUNC();
	//TODO
	//how do we let git remember out login for repositories
	//we don't want to have to log in on every commit.
}