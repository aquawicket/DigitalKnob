var GIT = "";

function DKGit_init() {
    DKGit_SetGitExePath()
    DKGit_ValidateGit();
}

function DKGit_SetGitExePath() {
    if (CPP_DK_GetOS() === "Windows")
        GIT = CPP_DKFile_GetShortName("C:/Program Files/Git/bin/git.exe");
    if (CPP_DK_GetOS() === "Mac")
        GIT = "git";
    if (CPP_DK_GetOS() === "Linux")
        GIT = "/usr/bin/git";
    if (CPP_DK_GetOS() === "Raspberry")
        GIT = "/usr/bin/git";
}

function DKGit_ValidateGit() {
    console.log("Looking for GIT\n");
    if (!CPP_DKFile_Exists(GIT)) {
        DKGit_InstallGit();
        DKGit_SetGitExePath();
    }
}

function DKGit_InstallGit() {
    console.log("Installing Git...\n");
    var assets = CPP_DKAssets_LocalAssets();

    if (CPP_DK_GetOS() === "Windows") {
		if(CPP_DK_GetOSArchitecture() === "32"){
			CPP_DKCurl_Download("https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-32-bit.exe", assets);
			CPP_DK_System(assets + "/Git-2.30.1-32-bit.exe");
		}
		if(CPP_DK_GetOSArchitecture() === "64"){
			CPP_DKCurl_Download("https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-64-bit.exe", assets);
			CPP_DK_System(assets + "/Git-2.30.1-64-bit.exe");
		}
	} 
    else if (CPP_DK_GetOS() === "Mac") {
        //TODO
    }
    else if (CPP_DK_GetOS() === "Linux") {
        CPP_DK_Execute("sudo apt-get install git");
    }
    else if (CPP_DK_GETOS() === "Raspberry"){
        CPP_DK_Execute("sudo apt-get install git");
    }
    else {
        console.log("ERROR: unrecognied HOST OS: " + CPP_DK_GetOS() + "\n");
    }
}

function DKGit_GitUpdate() {
    console.log("Git Update DigitalKnob...\n");
	if(!CPP_DKFile_Exists(DKPATH + "DK/.git")){
		CPP_DK_Execute(GIT + " clone https://github.com/aquawicket/DigitalKnob.git " + DKPATH + "DK");
		CPP_DKFile_ChDir(DKPATH + "DK");
		CPP_DK_Execute(GIT + " checkout -- .");
		CPP_DK_Execute(GIT + " pull origin master");
	}
	else{
		CPP_DKFile_ChDir(DKPATH + "DK");
		CPP_DK_Execute(GIT + " checkout -- .");
		CPP_DK_Execute(GIT + " pull");
	}

    //Multipe user folders
    var contents = CPP_DKFile_DirectoryContents(DKPATH);
    if (contents) {
        var files = contents.split(",");
        for (var i = 0; i < files.length; i++) {
            //console.log("files["+i+"] = "+files[i]+"\n");
            
			//Look for text files that contain [MYGIT] in them
			//The rest of the line is the repository address
			CPP_DKFile_ChDir(DKPATH);
            if (CPP_DKFile_IsDirectory(files[i]))
                continue;
            var url = CPP_DKFile_GetSetting(files[i], "[MYGIT]");
            if (url) {
				var folder = files[i].replace(".txt", "");
				if(!CPP_DKFile_Exists(DKPATH + folder + "/.git")){
					CPP_DK_Execute(GIT + " clone " + url + " " + DKPATH + folder);
					CPP_DKFile_ChDir(DKPATH + folder);
					CPP_DK_Execute(GIT + " checkout -- .");
					CPP_DK_Execute(GIT + " pull origin master");
				}
				else{
					CPP_DKFile_ChDir(DKPATH + folder);
					CPP_DK_Execute(GIT + " checkout -- .");
					CPP_DK_Execute(GIT + " pull");
				}
            }
        }
    }

    if (CPP_DK_Available("DKAudio"))
        dk.create("DKAudio");
    if (CPP_DK_Valid("DKAudioJS,DKAudioJS0"))
        DKAudio_PlaySound("DKBuild/ding.wav");
}

function DKGit_GitCommit() {
    console.log("Git Commit DigitalKnob...\n");
    CPP_DKFile_ChDir(DKPATH + "/DK");
    CPP_DK_Execute(GIT + " init");
    CPP_DK_Execute(GIT + " config user.name \"aquawicket\"");
    CPP_DK_Execute(GIT + " config user.email \"aquawicket@digitalknob.com\"");
    CPP_DK_Execute(GIT + " commit -a -m \"commit from git\"");
    CPP_DK_Execute(GIT + " config credential.helper store");
    //store credentials 
    CPP_DK_Execute(GIT + " push");

    //Multipe user folders
    var contents = CPP_DKFile_DirectoryContents(DKPATH);
    if (contents) {
        var files = contents.split(",");
        for (var i = 0; i < files.length; i++) {
			if(CPP_DKFile_Exists(DKPATH + files[i] + "/.git")){
				console.log("\n\n")
                console.log("### Git Commit " + files[i] + "... \n");
                CPP_DKFile_ChDir(DKPATH + files[i]);
                CPP_DK_Execute(GIT + " init");
				//store credentials 
                CPP_DK_Execute(GIT + " config user.name \"aquawicket\"");
                CPP_DK_Execute(GIT + " config user.email \"aquawicket@digitalknob.com\"");
                CPP_DK_Execute(GIT + " commit -a -m \"commit from git\"");
                CPP_DK_Execute(GIT + " config credential.helper store");
                CPP_DK_Execute(GIT + " push");
            }
        }
    }
    if (CPP_DK_Available("DKAudio"))
        dk.create("DKAudio");
    if (CPP_DK_Valid("DKAudioJS,DKAudioJS0"))
        DKAudio_PlaySound("DKBuild/ding.wav");
}

function DKGit_GitCredentials() {//TODO
//how do we let git remember our login for repositories
//we don't want to have to log in every time we need to commit.
}


// https://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git
// https://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git#comment20583319_12791408
// the total number of "different" commits between the current branch and server branch
function DKGit_CheckForDiff(){
	//console.log("DKGit_CheckForDiff()")
	let contents = CPP_DKFile_DirectoryContents(DKPATH);
	let files = contents.split(",");
	for(let i=0; i<files.length; i++){ 
		if(CPP_DKFile_Exists(DKPATH+files[i]+"/DKApps")){
				CPP_DKFile_ChDir(DKPATH + files[i])
				console.log("Checking "+files[i]+" . . . ")
				
				CPP_DK_Execute(GIT + " commit -a -m \"commit from git\"")
				CPP_DK_Execute(GIT + " fetch")
				const upstream = "@{u}"
				const local = CPP_DK_Execute(GIT + " rev-parse @")
				const remote = CPP_DK_Execute(GIT + " rev-parse " + upstream)
				const base = CPP_DK_Execute(GIT + " merge-base @ " + upstream)
				if(local === remote)
					console.log("UP TO DATE")
				else if(local === base)
					console.log("NEED TO PULL");
				else if(remote === base)
					console.log("NEED TO PUSH")
				else
					console.log("BRANCHES HAVE DIVERGED");
		}
	}
}

function DKGit_DiffCount(){
	console.log("DKGit_DiffCount()")
	let contents = CPP_DKFile_DirectoryContents(DKPATH);
	let files = contents.split(",");
	for(let i=0; i<files.length; i++){ 
		if(CPP_DKFile_Exists(DKPATH+files[i]+"/DKApps")){
			CPP_DKFile_ChDir(DKPATH + "/" + files[i])
			const result = CPP_DK_Execute(GIT + " rev-list HEAD...origin/master --count");
			console.log(result);
		}
	}
}
