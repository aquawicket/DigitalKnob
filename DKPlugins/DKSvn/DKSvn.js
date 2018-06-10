var SVN = "";

/////////////////////
function DKSvn_Init()
{
	DKLog("DKSvn_Init()\n", DKINFO);
	DKCreate("DKThreadPool");

	//DKLog(DK_GetOS()+"\n");
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
	//DKLog("DKSvn_End()");
	DKRemoveEvents(DKSvn_OnEvent);
}

///////////////////////////////
function DKSvn_OnEvent(event)
{
	//DKLog("DKSvn_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
}

////////////////////////////
function DKSvn_ValidateSvn()
{
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Looking for SVN \n");
	//DKLog(SVN+"\n");
	if(!DKFile_Exists(SVN)){
		DKLog("Please install SVN \n");
		DKBuild_InstallSvn();
	}
	DKLog("Found SVN \n");
	if(DK_GetOS() == "Mac"){
		SVN = "svn";
	}
}

///////////////////////////
function DKSvn_InstallSvn()
{
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Installing Svn \n");
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
		DKLog("ERROR: unrecognied HOST OS: "+DK_GetOS(), DKINFO);
	}
}

//////////////////////////
function DKSvn_SvnUpdate()
{
	DKLog("Svn Update... \n");
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
	DKLog("Svn Commit... \n");
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
