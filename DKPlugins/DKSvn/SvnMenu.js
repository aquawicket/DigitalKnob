var SVN = "";

///////////////////////
function SvnMenu_Init()
{
	DK_Create("DKThreadPool");

	//SVN(DK_GetOS()+"\n");
	if(DK_GetOS() === "Win32"){
		SVN = "C:/Program Files/Git/bin/git.exe";
		SVN = DKFile_GetShortName(SVN);
	}
	if(DK_GetOS() === "Win64"){
		SVN = "C:/Program Files/Git/bin/git.exe";
		SVN = DKFile_GetShortName(SVN);
	}
	if(DK_GetOS() === "Mac"){
		SVN = "git";
	}
	if(DK_GetOS() === "Linux"){
		SVN = "/usr/bin/git";
	}

	DK_Create("DKGit/SvnMenu.html", function(){
		window.addEventListener("mousedown", SvnMenu_OnEvent);
		byId("Git Update").addEventListener("click", SvnMenu_OnEvent);
		byId("Git Commit").addEventListener("click", SvnMenu_OnEvent);
	});
}

//////////////////////
function SvnMenu_End()
{
	window.removeEventListener("mousedown", SvnMenu_OnEvent);
	byId("Git Update").removeEventListener("click", SvnMenu_OnEvent);
	byId("Git Commit").removeEventListener("click", SvnMenu_OnEvent);
	DK_Close("DKGit/SvnMenu.html");
}

///////////////////////////////
function SvnMenu_OnEvent(event)
{
	if(event.currentTarget.id === "Git Update"){
		DKThread_DKQueue("GitUpdate","SvnMenu_GitUpdate();");
	}
	if(event.currentTarget.id === "Git Commit"){
		DKThread_DKQueue("GitCommit","SvnMenu_GitCommit();");
	}
	
	if(event.currentTarget === window){
		if(byId("DKGit/SvnMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){	
			return;
		}
	}
	DK_Close("DKGit/SvnMenu.js");
}

//////////////////////////////
function SvnMenu_ValidateGit()
{
	if(DK_GetBrowser() !== "RML"){ return; }
	SVN("Looking for SVN\n");
	//SVN(SVN+"\n");
	if(!DKFile_Exists(SVN)){
		SVN("Please install SVN\n");
		SvnMenu_InstallGit();
	}
	SVN("Found SVN\n");
	if(DK_GetOS() === "Mac"){
		SVN = "git";
	}
}

/////////////////////////////
function SvnMenu_InstallGit()
{
	if(DK_GetBrowser() !== "RML"){ return; }
	SVN("Installing Git\n");
	var assets = DKAssets_LocalAssets();
	
	if(DK_GetOS() === "Win32"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Git-2.11.0-32-bit.exe", assets);
		DK_System(assets+"/Git-2.11.0-32-bit.exe");
	}
	else if(DK_GetOS() === "Win64"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Git-2.11.0-64-bit.exe", assets);
		DK_System(assets+"/Git-2.11.0-64-bit.exe");
	}
	else if(DK_GetOS() === "Mac"){
		//TODO
	}
	else if(DK_GetOS() === "Linux"){
		DK_Execute("sudo apt-get install git");
	}
	else{
		SVN("ERROR: unrecognied HOST OS: "+DK_GetOS()+"\n");
	}
}

////////////////////////////
function SvnMenu_GitUpdate()
{
	if(DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML"){
		return;
	}
	
	SVN("Git Update DigitalKnob...\n");
	DK_Execute(SVN +" clone https://github.com/aquawicket/DigitalKnob.git "+DKPATH+"/DK");
	DKFile_ChDir(DKPATH+"/DK");
	DK_Execute(SVN +" checkout -- .");
	DK_Execute(SVN +" pull origin master");
	
	//Multipe user folders
	var contents = DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //SVN("files["+i+"] = "+files[i]+"\n");
		DKFile_ChDir(DKPATH);
		if(DKFile_IsDirectory(files[i])){ continue; }
		var url = DKFile_GetSetting(files[i], "[MYSVN]");
		if(url){ //SVN("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); //SVN("folder = "+folder+"\n");
			SVN("Git Update "+folder+"...\n");
			DK_Execute(SVN +" clone "+url+" "+DKPATH+"/"+folder);
			DK_Execute(SVN +" checkout -- .");
			DK_Execute(SVN +" pull origin master");
		}
	}
	
	if(CPP_DKDuktape_Available("DKAudio")){
		DK_Create("DKAudio");
	}
	if(CPP_DKDuktape_Valid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}

////////////////////////////
function SvnMenu_GitCommit()
{
	if(DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML"){
		return;
	}
	
	SVN("Git Commit DigitalKnob...\n");
	DKFile_ChDir(DKPATH+"/DK");
	DK_Execute(SVN +" init");
	DK_Execute(SVN +" config user.name \"dkuser\"");
	DK_Execute(SVN +" config user.email \"dkuser@digitalknob.com\"");
	DK_Execute(SVN +" commit -a -m \"commit from git\"");
	DK_Execute(SVN +" config credential.helper store"); //store credentials 
	DK_Execute(SVN +" push");
	
	//Multipe user folders
	var contents = DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //SVN("files["+i+"] = "+files[i]+"\n");
		DKFile_ChDir(DKPATH);
		if(DKFile_IsDirectory(files[i])){ continue; }
		var url = DKFile_GetSetting(files[i], "[MYSVN]");
		if(url){ //SVN("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); //SVN("folder = "+folder+"\n");
			SVN("Git Commit "+folder+"...\n");
			DKFile_ChDir(DKPATH+"/"+folder);
			DK_Execute(SVN +" init");
			DK_Execute(SVN +" config user.name \"dkuser\"");
			DK_Execute(SVN +" config user.email \"dkuser@digitalknob.com\"");
			DK_Execute(SVN +" commit -a -m \"commit from git\"");
			DK_Execute(SVN +" config credential.helper store"); //store credentials 
			DK_Execute(SVN +" push");
		}
	}
	
	if(CPP_DKDuktape_Available("DKAudio")){
		DK_Create("DKAudio");
	}
	if(CPP_DKDuktape_Valid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}