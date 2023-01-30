//git stash -  https://opensource.com/article/21/4/git-stash

var GIT = ""

function DKGit_init() {
    DKGit_ValidateGit()
}

function DKGit_SetGitExePath() {
	/*
    if (CPP_DK_GetOS() === "Windows"){
		if(CPP_DK_GetOSArchitecture() === "32")
			GIT = CPP_DKFile_GetShortName("C:/Program Files/Git/bin/git.exe")
		if(CPP_DK_GetOSArchitecture() === "64")
			GIT = CPP_DKFile_GetShortName("C:/Program Files (x86)/Git/bin/git.exe")
	}
    if (CPP_DK_GetOS() === "Mac")
        GIT = "git"
    if (CPP_DK_GetOS() === "Linux")
        GIT = "/usr/bin/git"
    if (CPP_DK_GetOS() === "Raspberry")
        GIT = "/usr/bin/git"
	*/
	if(CPP_DKFile_Exists("C:/Program Files/Git/bin/git.exe"))
		GIT = CPP_DKFile_GetShortName("C:/Program Files/Git/bin/git.exe")
	else if(CPP_DKFile_Exists("C:/Program Files (x86)/Git/bin/git.exe"))
		GIT = CPP_DKFile_GetShortName("C:/Program Files (x86)/Git/bin/git.exe")
	else if(CPP_DKFile_Exists("/usr/bin/git"))
		GIT = "/usr/bin/git"
	else if(CPP_DKFile_Exists("/usr/local/bin/git"))
		GIT = "/usr/local/bin/git"
	else
		GIT = "git"
}

function DKGit_ValidateGit() {
    console.log("Looking for GIT\n")
	
	DKGit_SetGitExePath()
    if (!CPP_DKFile_Exists(GIT)) {
        DKGit_InstallGit()
        DKGit_SetGitExePath()
    }
}

function DKGit_InstallGit() {
    console.log("Installing Git...\n")
    var assets = CPP_DKAssets_LocalAssets()
    if (CPP_DK_GetOS() === "Windows") {
		CPP_DKCurl_Download("https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-32-bit.exe", assets)
		CPP_DK_System(assets + "/Git-2.30.1-32-bit.exe")
	} 
    else if (CPP_DK_GetOS() === "Mac") {
        //TODO
    }
    else if (CPP_DK_GetOS() === "Linux") {
        CPP_DK_Execute("sudo apt-get install git")
    }
    else if (CPP_DK_GETOS() === "Raspberry"){
        CPP_DK_Execute("sudo apt-get install git")
    }
    else {
        console.log("ERROR: unrecognied HOST OS: " + CPP_DK_GetOS() + "\n")
    }
}

function DKGit_Clone(url, directory){
	console.log("DKGit_Clone("+url+", "+directory+")")
	if(!CPP_DKFile_Exists(directory + "/.git")){
		CPP_DK_Execute(GIT+" clone "+url+" "+directory)
	}
	CPP_DKFile_ChDir(directory)
	CPP_DK_Execute(GIT + " checkout -- .")
}

function DKGit_Checkout(branch){
	//const branches = DKGit_ListLocalBranches()
	const branches = DKGit_ListRemoteBranches()
	console.log(branches)
	if(!branches.includes(branch)){
		DKGit_CreateBranch(branch)
	}
	console.log("Checking out "+branch)
	CPP_DK_Execute(GIT + " checkout "+branch)
}

// Retrieve the name of the default branch.  I.E.  main or master
function DKGit_GetDefaultBranch(){
	const ref = CPP_DK_Execute(GIT + " ls-remote --symref origin HEAD")
	const start = ref.lastIndexOf("/")
	//console.log("start = "+start)
	const end = ref.indexOf("HEAD", start)
	//console.log("end = "+end)
	const default_branch = ref.substring(start+1, end-1)
	console.log("DKGit_GetDefaultBranch() -> "+default_branch)
	return default_branch
}

function DKGit_PullBranch(branch){
	DKGit_Checkout(branch)
	CPP_DK_Execute(GIT + " pull")
	CPP_DK_Execute(GIT + " branch --set-upstream-to=origin/"+branch)
}

function DKGit_GitUpdate() {
    console.log("Git Update DigitalKnob...\n")
	DKGit_Clone("https://github.com/aquawicket/DigitalKnob.git", DIGITALKNOB+"DK")
	DKGit_PullBranch("Development")
	
    //Multipe user folders
	CPP_DKFile_ChDir(DIGITALKNOB)
    var contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
    if (contents) {
        var files = contents.split(",")
        for (var i = 0; i < files.length; i++) {
			//Look for text files that contain [MYGIT] in them. The rest of the line is the repository address
            if (CPP_DKFile_IsDirectory(DIGITALKNOB+files[i]))
                continue
			if(files[i].indexOf(".txt") <= 1)
				continue
            var url = CPP_DKFile_GetSetting(DIGITALKNOB+files[i], "[MYGIT]")
            if (url) {
				var folder = files[i].replace(".txt", "")
				DKGit_Clone(url, DIGITALKNOB+folder)
				DKGit_PullBranch("Development")
            }
        }
    }

	if (CPP_DK_GetOS() != "Windows"){
		if (CPP_DKFile_Exists(DIGITALKNOB+"/DK/build.sh"))
			CPP_DK_Execute("chmod +x "+DIGITALKNOB+"/DK/build.sh")
		if (CPP_DKFile_Exists(DIGITALKNOB+"/DK/DKCMake/dev/dkbuild.sh"))
			CPP_DK_Execute("chmod +x "+DIGITALKNOB+"/DK/DKCMake/dev/dkbuild.sh")
	}
	
    if (CPP_DK_Available("DKAudio"))
        dk.create("DKAudio")
    if (CPP_DK_Valid("DKAudioJS,DKAudioJS0"))
        DKAudio_PlaySound("DKBuild/ding.wav")
}

function DKGit_GitCommit() {
    //Multipe folders in digitalknob/
    var contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
    if (contents) {
        var files = contents.split(",")
        for (var i = 0; i < files.length; i++) {
			if(CPP_DKFile_Exists(DIGITALKNOB + files[i] + "/.git")){
				console.log("\n\n")
                console.log("### Git Commit " + files[i] + "... \n")
                CPP_DKFile_ChDir(DIGITALKNOB + files[i])
                //CPP_DK_Execute(GIT + " init")
				DKGit_SetCredentials()
				const branch = DKGit_GetCurrentBranch()
				const default_branch = DKGit_GetDefaultBranch()
				if(branch === default_branch){
				//if(branch === "master" || branch === "main"){
					console.log("You are currently checked out to the default branch of the repository")
					console.log("We don't feel comfortable writing to the main/master. please switch to, or create a development branch")
					console.log("Switch to Existing:  >  git checkout <branch_name>")
					console.log("Create new branch:   >  git checkout -b <branch_name> main & git push")
					console.log("aborting commit")
					CPP_DK_Execute("pause")
					return;
				}
				//CPP_DK_Execute(GIT + " diff git diff --color-words & echo. & echo. & echo Press any key to proceed with commit")
				
				console.log("\n########## Changed Files ##########")
				CPP_DK_Execute(GIT + " diff --stat --color-words", "r", 0)
				
				/*
				console.log("\nPress c to proceed with the commit,     Press any other key to cancel")
				var key = getch()
				if(key !== 99){ // the c key
					console.log("COMMIT CANCELED\n\n\n")
					return;
				}
				*/

				CPP_DK_Execute(GIT + " commit -a -m \"commit from git\"", "r", 0)
                CPP_DK_Execute(GIT + " push", "r", 0)
            }
        }
    }
    if (CPP_DK_Available("DKAudio"))
        dk.create("DKAudio")
    if (CPP_DK_Valid("DKAudioJS,DKAudioJS0"))
        DKAudio_PlaySound("DKBuild/ding.wav")
}

function DKGit_ListCommits(){
	CPP_DK_Execute(GIT + " log --oneline")
}

function DKGit_UpdateLastCommitMessage(message){
	CPP_DK_Execute(GIT + " commit --amend -m \""+message+"\"")
}

function DKGit_SetCredentials(){
	CPP_DK_Execute(GIT + " config user.email \"aquawicket@hotmail.com\"")
    CPP_DK_Execute(GIT + " config user.name \"aquawicket\"")
    //CPP_DK_Execute(GIT + " config credential.helper store")
}

function DKGit_CreateBranch(name){
	console.debug("DKGit_CreateBranch("+name+")")
	const default_branch = DKGit_GetDefaultBranch()
	CPP_DK_Execute(GIT + " checkout -b "+name+" "+default_branch)
	DKGit_PushNewBranch(name)
}

function DKGit_PushNewBranch(name){
	console.debug(" DKGit_PushNewBranch("+name+")")
	CPP_DK_Execute(GIT + " push --set-upstream origin "+name)
}

function DKGit_GetCurrentBranch(){
	return CPP_DK_Execute(GIT + " rev-parse --abbrev-ref HEAD", "rt")
}

function DKGit_SwitchBranch(branch){
	return CPP_DK_Execute(GIT + " checkout "+branch)
}

function DKGit_ListLocalBranches(){
	return CPP_DK_Execute(GIT + " branch")
}

function DKGit_ListRemoteBranches(){
	return CPP_DK_Execute(GIT + " branch -r")
}

function DKGit_ListAllBranches(){
	return CPP_DK_Execute(GIT + " branch -a")
}

function DKGit_DeleteLocalBranch(branch){
	CPP_DK_Execute(GIT + " branch -d "+branch)
}

// https://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git
// https://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git#comment20583319_12791408
// the total number of "different" commits between the current branch and server branch
function DKGit_CheckForDiff(){
	//console.log("DKGit_CheckForDiff()")
	var contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
	var files = contents.split(",")
	for(var i=0; i<files.length; i++){ 
		if(CPP_DKFile_Exists(DIGITALKNOB+files[i]+"/DKApps")){
				CPP_DKFile_ChDir(DIGITALKNOB + files[i])
				console.log("Checking "+files[i]+" . . . ")
				
				CPP_DK_Execute(GIT + " commit -a -m \"commit from git\"")
				CPP_DK_Execute(GIT + " fetch")
				const upstream = "@{u}"
				const local = CPP_DK_Execute(GIT + " rev-parse @", "rr")
				const remote = CPP_DK_Execute(GIT + " rev-parse " + upstream, "rt")
				const base = CPP_DK_Execute(GIT + " merge-base @ " + upstream, "rt")
				if(local === remote)
					console.log("UP TO DATE")
				else if(local === base)
					console.log("NEED TO PULL")
				else if(remote === base)
					console.log("NEED TO PUSH")
				else
					console.log("BRANCHES HAVE DIVERGED")
		}
	}
}

function DKGit_DiffCount(){
	console.log("DKGit_DiffCount()")
	var contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
	var files = contents.split(",")
	for(var i=0; i<files.length; i++){ 
		if(CPP_DKFile_Exists(DIGITALKNOB+files[i]+"/DKApps")){
			CPP_DKFile_ChDir(DIGITALKNOB + "/" + files[i])
			const default_branch = DKGit_GetDefaultBranch()
			const result = CPP_DK_Execute(GIT + " rev-list HEAD...origin/"+default_branch+" --count", "rt")
			//const result = CPP_DK_Execute(GIT + " rev-list HEAD...origin/master --count", "rt")
			console.log(result)
		}
	}
}

function DKGit_ForcePull(){
	console.log("DKGit_ForcePull()")
	CPP_DK_Execute(GIT + " stash")
	CPP_DK_Execute(GIT + " pull")
}

function DKGit_CleanFolder(path){
	console.log("cleaning "+path)
	CPP_DKFile_ChDir(path)
	DKGit_DeleteUntrackedFiles()
}

function DKGit_ShowUntrackedFiles(){
	//console.log("DKGit_ShowUntrackedFiles()")
	CPP_DK_Execute(GIT + " clean -n -d") //Shows what will be deleted
}

function DKGit_DeleteUntrackedFiles(){
	CPP_DK_Execute(GIT + " clean -f -d") //Actually deletes
}

function DKGit_UnaddFile(filename){
	console.log("DKGit_UnaddFile("+filename+")")
	CPP_DK_Execute(GIT + " rm –cached "+filename)
}

function DKGit_ResetLocalChanges(){
	console.log("DKGit_ResetLocalChanges()")
	CPP_DK_Execute(GIT + " reset")
}

function DKGit_UndoMerge(id){
	console.log("DKGit_UndoMerge("+id+")")
	CPP_DK_Execute(GIT + " log –oneline")
	CPP_DK_Execute(GIT + " revert -m 1 "+id)
	CPP_DK_Execute(GIT + " commit -m \"reverted merge "+id+"\"")
	CPP_DK_Execute(GIT + " push")
}

function DKGit_RemoveFile(filename){
	console.log("DKGit_RemoveFile("+filename+")")
	CPP_DK_Execute(GIT + " rm "+filename)
	CPP_DK_Execute(GIT + " commit -m \"removed "+filename+"\"")
	CPP_DK_Execute(GIT + " push")
}

function DKGit_UndoLastCommit(){
	console.log("DKGit_UndoLastCommit()")
	CPP_DK_Execute(GIT +" reset –soft HEAD^")
	CPP_DK_Execute(GIT +" status")
}

function DKGit_CompairBranches(branchA, branchB){
	console.log("DKGit_CompairBranches("+branchA+", "+branchB+")")
	CPP_DK_Execute(GIT +" diff "+branchA+".."+branchB)
}

function DKGit_CreateTag(tagName){
	console.log("DKGit_CreateTag("+tagName+")")
	CPP_DK_Execute(GIT + " tag "+tagName)
	CPP_DK_Execute(GIT + " push origin "+tagName)
}

function DKGit_DeleteLocalTag(tagName){
	CPP_DK_Execute(GIT + " tag -d "+tagName)
}

function DKGit_RenameBranch(oldName, newName){
	console.log("DKGit_RenameBranch("+oldName+", "+newName+")")
	CPP_DK_Execute(GIT + " checkout "+oldName)
	CPP_DK_Execute(GIT + " branch -m "+newName)
	CPP_DK_Execute(GIT + " push origin :"+oldName+" "+newName) //Delete old branch from remote
	CPP_DK_Execute(GIT + " push origin -u "+newName) //Reset the upstream branch for the new branch name
}

function DKGit_Rename(oldName, newName){
	CPP_DK_Execute(GIT + " mv "+oldName+" tmp")
	CPP_DK_Execute(GIT + " mv tmp "+newName)
}
















function DKGit_DeleteRemoteTag(tagName){
	console.log("This section of code is for reference. These actions must be preformed manually")	
	return;
	
	/*
	CPP_DK_Execute(GIT + " push origin :refs/tags/"+tagName)
	*/
}

function DKGit_DeleteRemoteBranch(branch){
	console.log("This section of code is for reference. These actions must be preformed manually")	
	return;
	
	/*
	CPP_DK_Execute(GIT + " push origin --delete "+branch)
	*/
}

function DKGit_DeleteLastCommit(){
	console.log("This section of code is for reference. These actions must be preformed manually")	
	return;
	
	/*
	CPP_DK_Execute(GIT +" reset -–hard HEAD^")
	CPP_DK_Execute(GIT +" status")
	*/
}

function DKGit_RevertToCommit(tag){
	console.log("This section of code is for reference. These actions must be preformed manually")	
	return;
	
	//NOTE: need to be on the branch you want to revert
	
	//git reset --hard <tag>  //tag = revision_id_of_last_known_good_commit
	//git push --force
}

// https://stackoverflow.com/a/5608860/688352
// https://www.atlassian.com/git/tutorials/merging-vs-rebasing
function DKGit_MergeBranchAndPush(branch){
	console.log("This section of code is for reference. These actions must be preformed manually")	
	return;
	
	/*
	console.log("Merging "+branch+" into main and pushing to remote")
	CPP_DK_Execute(GIT + " checkout "+branch)
	CPP_DK_Execute(GIT + " pull")
	CPP_DK_Execute(GIT + " checkout main")
	CPP_DK_Execute(GIT + " pull origin main")
	CPP_DK_Execute(GIT + " merge --no-ff --no-commit "+branch)
	//CPP_DK_Execute(GIT + " merge "+branch)
	//CPP_DK_Execute(GIT + " merge --squash "+branch)
	
	// If there are conflicts
	//CPP_DK_Execute(GIT + " git status")

	//After conflicts resolved
	CPP_DK_Execute(GIT + " commit -a -m \"Merge Development branch in to main\"")
	CPP_DK_Execute(GIT + " push origin main")
	*/
}

// https://stackoverflow.com/a/29048781/688352
// https://www.atlassian.com/git/tutorials/merging-vs-rebasing
function DKGit_RebaseBranchAndPush(branch){
	console.log("This section of code is for reference. These actions must be preformed manually")	
	return;
	/*
	console.log("Rebasing "+branch+" into main and pushing to remote")
	CPP_DK_Execute(GIT + " checkout main")
	CPP_DK_Execute(GIT + " pull")
	CPP_DK_Execute(GIT + " checkout "+branch)
	CPP_DK_Execute(GIT + " pull")
	CPP_DK_Execute(GIT + " rebase -i main")
	CPP_DK_Execute(GIT + " checkout main")
	CPP_DK_Execute(GIT + " merge "+branch)
	*/
}

//https://gist.github.com/heiswayi/350e2afda8cece810c0f6116dadbe651
function DKGit_ResetRepository(){
	console.log("This section of code is for reference. These actions must be preformed manually")	
	return;
	
	/*
	//Check out to a temporary branch:
	CPP_DK_Execute(GIT + " checkout --orphan TEMP_BRANCH")

	//Add all the files:
	CPP_DK_Execute(GIT + " add -A")

	//Commit the changes:
	CPP_DK_Execute(GIT + " commit -am \"Initial commit\"")

	//Delete the old branch:
	CPP_DK_Execute(GIT + " branch -D main")

	//Rename the temporary branch to main:
	CPP_DK_Execute(GIT + " branch -m main")

	//Finally, force update to our repository:
	CPP_DK_Execute(GIT + " push -f origin main")
	*/
}

//https://www.git-tower.com/learn/git/faq/git-rename-master-to-main
function DKGit_RenameMasterToMain(){
	CPP_DK_Execute(GIT + " branch -m master main")   //rename local master branch to main
	CPP_DK_Execute(GIT + " push -u origin main")   //push main to server
	
	//https://stackoverflow.com/questions/67870769/cant-change-git-default-branch-to-main-on-the-command-line    //Set the default branch to main
	//CPP_DK_Execute(GIT + " git push origin --delete master")   //Delete the master branch from server
}


DKGit_init()
