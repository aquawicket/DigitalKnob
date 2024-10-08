var SVN = "";

/////////////////////
function DKSvn_init()
{
	dk.create("DKThreadPool");

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
function DKSvn_end()
{

}

///////////////////////////////
function DKSvn_OnEvent(event)
{

}

////////////////////////////
function DKSvn_ValidateSvn()
{
	if(DK_GetBrowser() !== "Rml"){ return; }
	console.log(("Looking for SVN\n");
	//console.log((SVN+"\n");
	if(!dk.file.extist(SVN)){
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
	if(DK_GetBrowser() !== "Rml"){ return; }
	console.log(("Installing Svn\n");
	var assets = DKAssets_LocalAssets();
	
	if(DK_GetOS() === "Win32"){
		//DKCurl_Download("http://Setup-Subversion-1.8.10.msi", assets);
		DK_System(assets+"/Setup-Subversion-1.8.10.msi");
	}
	else if(DK_GetOS() === "Win64"){
		//DKCurl_Download("http://Setup-Subversion-1.8.10.msi", assets);
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
	DK_Execute(SVN +" cleanup "+DIGITALKNOB_DIR);
	DK_Execute(SVN +" checkout https://github.com/aquawicket/DigitalKnob/trunk/ "+DIGITALKNOB_DIR);
	
	var mysvn = DKAssets_LocalAssets()+"mysvn.txt";
	if(!dk.file.extist(mysvn)){ mysvn = DIGITALKNOB_DIR+"/mysvn.txt"; } //check for /mysvn.txt
	
	//TODO: Multipe user folders
	
	if(CPP_DK_Available("DKAudio")){
		dk.create("DKAudio");
	}
	if(CPP_DK_Valid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}

//////////////////////////
function DKSvn_SvnCommit()
{
	console.log(("Svn Commit...\n");
	DK_Execute(SVN +" cleanup "+DIGITALKNOB_DIR);
	DK_Execute(SVN +" commit -m update "+DIGITALKNOB_DIR);
	
	//TODO: Multipe user folders
	
	if(CPP_DK_Available("DKAudio")){
		dk.create("DKAudio");
	}
	if(CPP_DK_Valid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}