var SVN = "";

/////////////////////
function DKSvn_Init()
{
	DK_Create("DKThreadPool");

	//console.log((DK_GetOS()+"\n");
	if(DK_GetOS() === "Win32"){
		//GIT = "C:/Program Files/Git/bin/git.exe";
		//GIT = DKFile_GetShortName(GIT);
	}
	if(DK_GetOS() === "Win64"){
		//GIT = "C:/Program Files/Git/bin/git.exe";
		//GIT = DKFile_GetShortName(GIT);
	}
	if(DK_GetOS() === "Mac"){
		//GIT = "git";
	}
	if(DK_GetOS() === "Linux"){
		//GIT = "/usr/bin/git";
	}
	
	DKSvn_ValidateSvn();
}

////////////////////
function DKSvn_End()
{

}

///////////////////////////////
function DKSvn_OnEvent(event)
{

}

////////////////////////////
function DKSvn_ValidateSvn()
{
	if(DK_GetBrowser() !== "RML"){ return; }
	console.log(("Looking for SVN\n");
	//console.log((SVN+"\n");
	if(!DKFile_Exists(SVN)){
		console.log(("Please install SVN\n");
		DKBuild_InstallSvn();
	}
	console.log(("Found SVN\n");
	if(DK_GetOS() === "Mac"){
		SVN = "svn";
	}
}

///////////////////////////
function DKSvn_InstallSvn()
{
	if(DK_GetBrowser() !== "RML"){ return; }
	console.log(("Installing Svn\n");
	var assets = DKAssets_LocalAssets();
	
	if(DK_GetOS() === "Win32"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Setup-Subversion-1.8.10.msi", assets);
		DK_System(assets+"/Setup-Subversion-1.8.10.msi");
	}
	else if(DK_GetOS() === "Win64"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Setup-Subversion-1.8.10.msi", assets);
		DK_System(assets+"/Setup-Subversion-1.8.10.msi");
	}
	else if(DK_GetOS() === "Mac"){
		//TODO
	}
	else if(DK_GetOS() === "Linux"){
		DK_Execute("sudo apt-get install subversion");
	}
	else{
		console.log(("ERROR: unrecognied HOST OS: "+DK_GetOS()+"\n");
	}
}

//////////////////////////
function DKSvn_SvnUpdate()
{
	console.log(("Svn Update...\n");
	DK_Execute(SVN +" cleanup "+DKPATH);
	DK_Execute(SVN +" checkout https://github.com/aquawicket/DigitalKnob/trunk/ "+DKPATH);
	
	var mysvn = DKAssets_LocalAssets()+"mysvn.txt";
	if(!DKFile_Exists(mysvn)){ mysvn = DKPATH+"/mysvn.txt"; } //check for /mysvn.txt
	
	//TODO: Multipe user folders
	
	if(CPP_DK_Available("DKAudio")){
		DK_Create("DKAudio");
	}
	if(CPP_DK_Valid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}

//////////////////////////
function DKSvn_SvnCommit()
{
	console.log(("Svn Commit...\n");
	DK_Execute(SVN +" cleanup "+DKPATH);
	DK_Execute(SVN +" commit -m update "+DKPATH);
	
	//TODO: Multipe user folders
	
	if(CPP_DK_Available("DKAudio")){
		DK_Create("DKAudio");
	}
	if(CPP_DK_Valid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}