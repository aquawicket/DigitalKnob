var SVN = "";

function SvnMenu_init(){
	dk.create("DKThreadPool");

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

	dk.create("DKGit/SvnMenu.html", function(){
		document.addEventListener("mousedown", SvnMenu_onevent);
		byId("Git Update").addEventListener("click", SvnMenu_onevent);
		byId("Git Commit").addEventListener("click", SvnMenu_onevent);
	});
}

function SvnMenu_end(){
	document.removeEventListener("mousedown", SvnMenu_onevent);
	byId("Git Update").removeEventListener("click", SvnMenu_onevent);
	byId("Git Commit").removeEventListener("click", SvnMenu_onevent);
	dk.close("DKGit/SvnMenu.html");
}

function SvnMenu_OnEvent(event){
	if(event.currentTarget.id === "Git Update"){
		DKThread_DKQueue("GitUpdate","SvnMenu_GitUpdate();");
	}
	if(event.currentTarget.id === "Git Commit"){
		DKThread_DKQueue("GitCommit","SvnMenu_GitCommit();");
	}
	
	if(event.currentTarget === document){
		if(byId("DKGit/SvnMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){	
			return;
		}
	}
	dk.close("DKGit/SvnMenu.js");
}

function SvnMenu_ValidateGit(){
	if(DK_GetBrowser() !== "Rml"){ return; }
	SVN("Looking for SVN\n");
	//SVN(SVN+"\n");
	if(!dk.file.extist(SVN)){
		SVN("Please install SVN\n");
		SvnMenu_InstallGit();
	}
	SVN("Found SVN\n");
	if(DK_GetOS() === "Mac"){
		SVN = "git";
	}
}

function SvnMenu_InstallGit(){
	if(DK_GetBrowser() !== "Rml"){ return; }
	SVN("Installing Git\n");
	var assets = DKAssets_LocalAssets();
	
	if(DK_GetOS() === "Win32"){
		DKCurl_Download("http://TODO.com/Git-2.11.0-32-bit.exe", assets);
		DK_System(assets+"Git-2.11.0-32-bit.exe");
	}
	else if(DK_GetOS() === "Win64"){
		DKCurl_Download("http://TODO.com/Git-2.11.0-64-bit.exe", assets);
		DK_System(assets+"Git-2.11.0-64-bit.exe");
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

function SvnMenu_GitUpdate(){
	if(DK_GetBrowser() !== "Cef" && DK_GetBrowser() !== "Rml"){
		return;
	}
	
	SVN("Git Update DigitalKnob...\n");
	DK_Execute(SVN +" clone https://github.com/aquawicket/DigitalKnob.git "+DIGITALKNOB+"/DK");
	DKFile_ChDir(DIGITALKNOB+"/DK");
	DK_Execute(SVN +" checkout -- .");
	DK_Execute(SVN +" pull origin master");
	
	//Multipe user folders
	var contents = DKFile_DirectoryContents(DIGITALKNOB);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //SVN("files["+i+"] = "+files[i]+"\n");
		DKFile_ChDir(DIGITALKNOB);
		if(DKFile_IsDirectory(files[i])){ continue; }
		var url = DKFile_GetSetting(files[i], "[MYSVN]");
		if(url){ //SVN("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); //SVN("folder = "+folder+"\n");
			SVN("Git Update "+folder+"...\n");
			DK_Execute(SVN +" clone "+url+" "+DIGITALKNOB+"/"+folder);
			DK_Execute(SVN +" checkout -- .");
			DK_Execute(SVN +" pull origin master");
		}
	}
	
	if(CPP_DK_Available("DKAudio")){
		dk.create("DKAudio");
	}
	if(CPP_DK_Valid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}

function SvnMenu_GitCommit(){
	if(DK_GetBrowser() !== "Cef" && DK_GetBrowser() !== "Rml"){
		return;
	}
	
	SVN("Git Commit DigitalKnob...\n");
	DKFile_ChDir(DIGITALKNOB+"/DK");
	DK_Execute(SVN +" init");
	DK_Execute(SVN +" config user.name \"dkuser\"");
	DK_Execute(SVN +" config user.email \"dkuser@TODO.com\"");
	DK_Execute(SVN +" commit -a -m \"commit from git\"");
	DK_Execute(SVN +" config credential.helper store"); //store credentials 
	DK_Execute(SVN +" push");
	
	//Multipe user folders
	var contents = DKFile_DirectoryContents(DIGITALKNOB);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //SVN("files["+i+"] = "+files[i]+"\n");
		DKFile_ChDir(DIGITALKNOB);
		if(DKFile_IsDirectory(files[i])){ continue; }
		var url = DKFile_GetSetting(files[i], "[MYSVN]");
		if(url){ //SVN("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); //SVN("folder = "+folder+"\n");
			SVN("Git Commit "+folder+"...\n");
			DKFile_ChDir(DIGITALKNOB+"/"+folder);
			DK_Execute(SVN +" init");
			DK_Execute(SVN +" config user.name \"dkuser\"");
			DK_Execute(SVN +" config user.email \"dkuser@TODO.com\"");
			DK_Execute(SVN +" commit -a -m \"commit from git\"");
			DK_Execute(SVN +" config credential.helper store"); //store credentials 
			DK_Execute(SVN +" push");
		}
	}
	
	if(CPP_DK_Available("DKAudio")){
		dk.create("DKAudio");
	}
	if(CPP_DK_Valid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}