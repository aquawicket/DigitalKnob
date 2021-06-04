var GIT = "";

function DKGit_init() {
    DKGit_SetGitPath()
    DKGit_ValidateGit();
}

function DKGit_end() {}

function DKGit_OnEvent(event) {}

function DKGit_SetGitPath() {
    if (CPP_DK_GetOS() === "Windows") {
        GIT = "C:/Program Files/Git/bin/git.exe";
        GIT = CPP_DKFile_GetShortName(GIT);
        console.log("GIT: " + GIT);
    }
    if (CPP_DK_GetOS() === "Mac") {
        GIT = "git";
    }
    if (CPP_DK_GetOS() === "Linux") {
        GIT = "/usr/bin/git";
    }
    if (CPP_DK_GetOS() === "Raspberry") {
        GIT = "/usr/bin/git";
    }
}

function DKGit_ValidateGit() {
    //if(CPP_DK_GetBrowser() !== "Rml"){ return; }
    console.log("Looking for GIT\n");
    if (!CPP_DKFile_Exists(GIT)) {
        DKGit_InstallGit();
        DKGit_SetGitPath();
    }
}

function DKGit_InstallGit() {
    //if(CPP_DK_GetBrowser() !== "Rml"){ return; }
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
    //if(CPP_DK_GetBrowser() !== "Cef" && CPP_DK_GetBrowser() !== "Rml"){
    //	console.error("DKGit_GitUpdate(): Incompatable browser");
    //	return;
    //}

    console.log("Git Update DigitalKnob...\n");
    CPP_DK_Execute(GIT + " clone https://github.com/aquawicket/DigitalKnob.git " + DKPATH + "/DK");
    CPP_DKFile_ChDir(DKPATH + "/DK");
    CPP_DK_Execute(GIT + " checkout -- .");
    CPP_DK_Execute(GIT + " pull origin master");

    //Multipe user folders
    var contents = CPP_DKFile_DirectoryContents(DKPATH);
    if (contents) {
        var files = contents.split(",");
        for (var i = 0; i < files.length; i++) {
            //console.log("files["+i+"] = "+files[i]+"\n");
            CPP_DKFile_ChDir(DKPATH);
            if (CPP_DKFile_IsDirectory(files[i]))
                continue;
            var url = CPP_DKFile_GetSetting(files[i], "[MYGIT]");
            if (url) {
                //console.log("url = "+url+"\n");
                var folder = files[i].replace(".txt", "");
                //console.log("folder = "+folder+"\n");
                console.log("Git Update " + folder + "...\n");
                CPP_DKFile_ChDir(DKPATH + "/" + folder);
                CPP_DK_Execute(GIT + " clone " + url + " " + DKPATH + "/" + folder);
                CPP_DK_Execute(GIT + " checkout -- .");
                CPP_DK_Execute(GIT + " pull origin master");
            }
        }
    }

    if (CPP_DK_Available("DKAudio"))
        dk.create("DKAudio");
    if (CPP_DK_Valid("DKAudioJS,DKAudioJS0"))
        DKAudio_PlaySound("DKBuild/ding.wav");
}

function DKGit_GitCommit() {
    //if(CPP_DK_GetBrowser() !== "Cef" && CPP_DK_GetBrowser() !== "Rml"){
    //	console.error("DKGit_GitCommit(): Incompatable browser");
    //	return;
    //}

    console.log("Git Commit DigitalKnob...\n");
    CPP_DKFile_ChDir(DKPATH + "/DK");
    CPP_DK_Execute(GIT + " init");
    CPP_DK_Execute(GIT + " config user.name \"dkuser\"");
    CPP_DK_Execute(GIT + " config user.email \"dkuser@digitalknob.com\"");
    CPP_DK_Execute(GIT + " commit -a -m \"commit from git\"");
    CPP_DK_Execute(GIT + " config credential.helper store");
    //store credentials 
    CPP_DK_Execute(GIT + " push");

    //Multipe user folders
    var contents = CPP_DKFile_DirectoryContents(DKPATH);
    if (contents) {
        var files = contents.split(",");
        for (var i = 0; i < files.length; i++) {
            //console.log("files["+i+"] = "+files[i]+"\n");
            CPP_DKFile_ChDir(DKPATH);
            if (CPP_DKFile_IsDirectory(files[i])) {
                continue;
            }
            var url = CPP_DKFile_GetSetting(files[i], "[MYGIT]");
            if (url) {
                //console.log("url = "+url+"\n");
                var folder = files[i].replace(".txt", "");
                //console.log("folder = "+folder+"\n");
                console.log("Git Commit " + folder + "... \n");
                CPP_DKFile_ChDir(DKPATH + "/" + folder);
                CPP_DK_Execute(GIT + " init");
                CPP_DK_Execute(GIT + " config user.name \"dkuser\"");
                CPP_DK_Execute(GIT + " config user.email \"dkuser@digitalknob.com\"");
                CPP_DK_Execute(GIT + " commit -a -m \"commit from git\"");
                CPP_DK_Execute(GIT + " config credential.helper store");
                //store credentials 
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
