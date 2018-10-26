var SVN = "";

/////////////////////
function DKSvn_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKThreadPool");

	//DKINFO((DK_GetOS()+"\n");
	if(DK_GetOS() == "Win32"){
		//GIT = "C:/Program Files/Git/bin/git.exe";
		//GIT = DKFile_GetShortName(GIT);
	}
	if(DK_GetOS() == "Win64"){
		//GIT = "C:/Program Files/Git/bin/git.exe";
		//GIT = DKFile_GetShortName(GIT);
	}
	if(DK_GetOS() == "Mac"){
		//GIT = "git";
	}
	if(DK_GetOS() == "Linux"){
		//GIT = "/usr/bin/git";
	}
	
	DKSvn_ValidateSvn();
}

////////////////////
function DKSvn_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKSvn_OnEvent);
}

///////////////////////////////
function DKSvn_OnEvent(event)
{
	DKDEBUGFUNC(event);
}

////////////////////////////
function DKSvn_ValidateSvn()
{
	DKDEBUGFUNC();
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKINFO(("Looking for SVN\n");
	//DKINFO((SVN+"\n");
	if(!DKFile_Exists(SVN)){
		DKINFO(("Please install SVN\n");
		DKBuild_InstallSvn();
	}
	DKINFO(("Found SVN\n");
	if(DK_GetOS() == "Mac"){
		SVN = "svn";
	}
}

///////////////////////////
function DKSvn_InstallSvn()
{
	DKDEBUGFUNC();
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKINFO(("Installing Svn\n");
	var assets = DKAssets_LocalAssets();
	
	if(DK_GetOS() == "Win32"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Setup-Subversion-1.8.10.msi", assets);
		DK_System(assets+"/Setup-Subversion-1.8.10.msi");
	}
	else if(DK_GetOS() == "Win64"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Setup-Subversion-1.8.10.msi", assets);
		DK_System(assets+"/Setup-Subversion-1.8.10.msi");
	}
	else if(DK_GetOS() == "Mac"){
		//TODO
	}
	else if(DK_GetOS() == "Linux"){
		DK_Execute("sudo apt-get install subversion");
	}
	else{
		DKINFO(("ERROR: unrecognied HOST OS: "+DK_GetOS()+"\n");
	}
}

//////////////////////////
function DKSvn_SvnUpdate()
{
	DKDEBUGFUNC();
	DKINFO(("Svn Update...\n");
	DK_Execute(SVN +" cleanup "+DKPATH);
	DK_Execute(SVN +" checkout https://github.com/aquawicket/DigitalKnob/trunk/ "+DKPATH);
	
	var mysvn = DKAssets_LocalAssets()+"mysvn.txt";
	if(!DKFile_Exists(mysvn)){ mysvn = DKPATH+"/mysvn.txt"; } //check for /mysvn.txt
	
	//TODO: Multipe user folders
	
	if(DKAvailable("DKAudio")){
		DKCreate("DKAudio");
	}
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}

//////////////////////////
function DKSvn_SvnCommit()
{
	DKDEBUGFUNC();
	DKINFO(("Svn Commit...\n");
	DK_Execute(SVN +" cleanup "+DKPATH);
	DK_Execute(SVN +" commit -m update "+DKPATH);
	
	//TODO: Multipe user folders
	
	if(DKAvailable("DKAudio")){
		DKCreate("DKAudio");
	}
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}