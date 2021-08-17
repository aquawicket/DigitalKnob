var working = true

function DKBuildConsole_init() {
    CPP_DK_Create("DKBuild/DKBuild.js")
	CPP_DK_Create("DKGit/DKGit.js")
	
	/*
	let contents = CPP_DKFile_DirectoryContents(DKPATH)
	let files = contents.split(",")
	for(let i=0; i<files.length; i++){ 
		if(CPP_DKFile_Exists(DKPATH+files[i]+"/DKApps")){
			CPP_DKFile_ChDir(DKPATH+files[i])
			const diff = CPP_DK_Execute("git diff")
			if(diff)
				console.log("*** THERE ARE CHANGES IN THE '"+files[i]+"' CODE BASE ***")
		}
	}
	*/
	
	//console.log(DKGit_DiffCount())
	//DKGit_CheckForDiff()
    
	while (working) {
        DKBuildConsole_Process()
    }
}

function DKBuildConsole_end() {
    CPP_DK_Close("DKBuild/DKBuild.js")
}

function DKBuildConsole_ChooseUpdate() {
	UPDATE = "1"
    console.log("\n")
    console.log("**** Update DigitalKnob ??? ****")
    console.log("Y. Update")
    console.log("C. Commit")
    console.log("R. Reset Apps and Plugins")
    console.log("X. Reset Everything")
	console.log("Z. Clear all CMake cache")
	const assets = CPP_DKAssets_LocalAssets()
	if(CPP_DKFile_Exists(assets+"cache.txt")){
		const cache = CPP_DKFile_FileToString(assets+"cache.txt")
		if(cache){
			const cache_json = JSON.parse(cache)
			console.log("ENTER: "+cache_json.APP+" -> "+cache_json.OS+" -> "+cache_json.TYPE+" -> "+cache_json.LEVEL)
		}
	}
    console.log("any other key to Skip")
    console.log("ESC. exit")
    console.log("\n")
	
	var key = 10
	//fix for linux
    while (key === 10) {
        key = CPP_DK_GetKey()
    }

    //console.log("Key pressed: "+String(key)+"")
    
	//Esc
	if (key === 27){
        CPP_DK_Exit()
		UPDATE = ""
	}
	//Spacebar
	if(key === 13){
		OS = cache_json.OS
	    APP = cache_json.APP
		TYPE = cache_json.TYPE
		LEVEL = cache_json.LEVEL
		UPDATE = ""
	}
	//y key
    if (key === 121) {
        CPP_DK_Create("DKGit/DKGit.js")
        DKGit_GitUpdate()
		UPDATE = ""
    }
	//c key
    if (key === 99) {
        CPP_DK_Create("DKGit/DKGit.js")
        DKGit_GitCommit()
		UPDATE = ""
    }
	//r key
    if (key === 114) { 
        DKBuild_ResetAppsPlugins()
        DKGit_GitUpdate()
		UPDATE = ""
    }
	//x key
    if (key === 120) {
        DKBuild_Reset3rdParty()
        DKBuild_ResetAppsPlugins()
        DKGit_GitUpdate()
		UPDATE = ""
    }
	if (key === 122){ //Clear Cmake Cache
		console.log("Clearing CMake cache . . .")
		CPP_DKFile_ChDir(DKPATH)
		if(CPP_DK_GetOS() === "Windows"){
			CPP_DK_Execute("cmd /c for /r %i in (CMakeCache.*) do del \"%i\"")
			CPP_DK_Execute("cmd /c for /d /r %i in (*CMakeFiles*) do rmdir /s /Q \"%i\"")
		}else{
			CPP_DK_Execute("find . -name \"CMakeCache.*\" -delete") 
			//CPP_DK_Execute("find . -type d -name \"CMakeFiles\" -delete")
			CPP_DK_Execute("rm -rf `find . -type d -name CMakeFiles`")
		}
		UPDATE = ""
	}
	
}

function DKBuildConsole_SelectOs() {
    console.log("\n")
    console.log("**** SELECT OS TO BUILD ****")
    console.log("1. win32")
    console.log("2. win64")
    console.log("3. mac32")
    console.log("4. mac64")
    console.log("5. linux32")
    console.log("6. linux64")
    console.log("7. ios32")
    console.log("8. ios64")
    console.log("9. iossim32")
    console.log("a. iossim64")
    console.log("b. android32")
    console.log("c. android64")
    console.log("d. raspberry32")
    console.log("e. raspberry64")
	//console.log("BCKSPC. Back")
    console.log("ESC. exit")
    console.log("\n")

    var key = 10
    while (key === 10) {
        //unix fix
        key = CPP_DK_GetKey()
    }
    //console.log("Key pressed: "+String(key)+"")
    if (key === 27)
        CPP_DK_Exit()
    if (key === 49)
        OS = "win32"
    else if (key === 50)
        OS = "win64"
    else if (key === 51)
        OS = "mac32"
    else if (key === 52)
        OS = "mac64"
    else if (key === 53)
        OS = "linux32"
    else if (key === 54)
        OS = "linux64"
    else if (key === 55)
        OS = "ios32"
    else if (key === 56)
        OS = "ios64"
    else if (key === 57)
        OS = "iossim32"
    else if (key === 97)
        OS = "iossim64"
    else if (key === 98)
        OS = "android32"
    else if (key === 99)
        OS = "android64"
    else if (key === 100)
        //FIXME: key not tested
        OS = "raspberry32"
    else if (key === 101)
        //FIXME: key not tested
        OS = "raspberry64"
    else
        console.error("INVALID OPTION")
}

function DKBuildConsole_SelectApp() {
    console.log("**** SELECT APP TO BUILD ****")
    for (var i = 0; i < APP_LIST.length; ++i) {
        console.log(DKBuildConsole_TranslateOption(i) + ":" + APP_LIST[i] + "")
    }
    console.log("ESC. exit")
    console.log("\n")
    var key = 10
    while (key === 10) {
        //unix fix
        key = CPP_DK_GetKey()
    }
    if (key === 27)
        CPP_DK_Exit()
    DKBuildConsole_KeyToApp(key)
    if (APP === "")
        console.error("INVALID OPTION")
}

function DKBuildConsole_SelectType() {
    console.log("**** SELECT BUILD TYPE ****")
    console.log("1. Debug")
    console.log("2. Release")
    console.log("3. All")
	//console.log("BCKSPC. Back")
    console.log("ESC. exit")
    console.log("\n")

    var key = 10
    while (key === 10) {
        //unix fix
        key = CPP_DK_GetKey()
    }
    //console.log("Key pressed: "+String(key)+"")
    if (key === 27)
        CPP_DK_Exit()
    if (key === 49)
        TYPE = "Debug"
    else if (key === 50)
        TYPE = "Release"
    else if (key === 51)
        TYPE = "ALL"
    else
        console.error("INVALID OPTION")
}

function DKBuildConsole_Process() {
	UPDATE = ""
    OS = ""
    APP = ""
    TYPE = ""
    LEVEL = "RebuildAll"
	while (UPDATE === "") {
        DKBuildConsole_ChooseUpdate()
    }
    if (!CPP_DKFile_Exists(DKPATH)) {
        console.error("ERROR: can't find " + DKPATH + " ")
        CPP_DK_GetKey()
        CPP_DK_Exit()
    }
    while (OS === "") {
        DKBuildConsole_SelectOs()
    }
    console.log("###########################")
    console.log(OS + " ->")
    console.log("###########################")
    DKBuild_GetAppList()
    while (APP === "") {
        DKBuildConsole_SelectApp()
    }
    console.log("###########################")
    console.log(OS + " -> " + APP + " ->")
    console.log("###########################")
    while (TYPE === "") {
        DKBuildConsole_SelectType()
    }
    console.log("###########################")
    console.log(OS + " -> " + APP + " -> " + TYPE + "")
    console.log("###########################")
    console.log("Press any key to Build")
    CPP_DK_GetKey()
    DKBuild_DoResults()
}

function DKBuildConsole_TranslateOption(num) {
    if (num === 0) {
        return "1"
    }
    if (num === 1) {
        return "2"
    }
    if (num === 2) {
        return "3"
    }
    if (num === 3) {
        return "4"
    }
    if (num === 4) {
        return "5"
    }
    if (num === 5) {
        return "6"
    }
    if (num === 6) {
        return "7"
    }
    if (num === 7) {
        return "8"
    }
    if (num === 8) {
        return "9"
    }
    if (num === 9) {
        return "a"
    }
    if (num === 10) {
        return "b"
    }
    if (num === 11) {
        return "c"
    }
    if (num === 12) {
        return "d"
    }
    if (num === 13) {
        return "e"
    }
    if (num === 14) {
        return "f"
    }
    if (num === 15) {
        return "g"
    }
    if (num === 16) {
        return "h"
    }
    if (num === 17) {
        return "i"
    }
    if (num === 18) {
        return "j"
    }
    if (num === 19) {
        return "k"
    }
    if (num === 20) {
        return "l"
    }
    if (num === 21) {
        return "m"
    }
    if (num === 22) {
        return "n"
    }
    if (num === 23) {
        return "o"
    }
    if (num === 24) {
        return "p"
    }
    if (num === 25) {
        return "q"
    }
    if (num === 26) {
        return "r"
    }
    if (num === 27) {
        return "s"
    }
    if (num === 28) {
        return "t"
    }
    if (num === 29) {
        return "u"
    }
    if (num === 30) {
        return "v"
    }
    if (num === 31) {
        return "w"
    }
    if (num === 32) {
        return "x"
    }
    if (num === 33) {
        return "y"
    }
    if (num === 34) {
        return "z"
    }
}

function DKBuildConsole_KeyToApp(key) {
    if (key === 49) {
        APP = APP_LIST[0]
    }
    //1
    if (key === 50) {
        APP = APP_LIST[1]
    }
    //2
    if (key === 51) {
        APP = APP_LIST[2]
    }
    //3 
    if (key === 52) {
        APP = APP_LIST[3]
    }
    //4
    if (key === 53) {
        APP = APP_LIST[4]
    }
    //5
    if (key === 54) {
        APP = APP_LIST[5]
    }
    //6
    if (key === 55) {
        APP = APP_LIST[6]
    }
    //7
    if (key === 56) {
        APP = APP_LIST[7]
    }
    //8
    if (key === 57) {
        APP = APP_LIST[8]
    }
    //9
    if (key === 97) {
        APP = APP_LIST[9]
    }
    //a
    if (key === 98) {
        APP = APP_LIST[10]
    }
    //b
    if (key === 99) {
        APP = APP_LIST[11]
    }
    //c
    if (key === 100) {
        APP = APP_LIST[12]
    }
    //d
    if (key === 101) {
        APP = APP_LIST[13]
    }
    //e
    if (key === 102) {
        APP = APP_LIST[14]
    }
    //f
    if (key === 103) {
        APP = APP_LIST[15]
    }
    //g
    if (key === 104) {
        APP = APP_LIST[16]
    }
    //h
    if (key === 105) {
        APP = APP_LIST[17]
    }
    //i
    if (key === 106) {
        APP = APP_LIST[18]
    }
    //j
    if (key === 107) {
        APP = APP_LIST[19]
    }
    //k
    if (key === 108) {
        APP = APP_LIST[20]
    }
    //l
    if (key === 109) {
        APP = APP_LIST[21]
    }
    //m
    if (key === 110) {
        APP = APP_LIST[22]
    }
    //n
    if (key === 111) {
        APP = APP_LIST[23]
    }
    //o
    if (key === 112) {
        APP = APP_LIST[24]
    }
    //p
    if (key === 113) {
        APP = APP_LIST[25]
    }
    //q
    if (key === 114) {
        APP = APP_LIST[26]
    }
    //r
    if (key === 115) {
        APP = APP_LIST[27]
    }
    //s
    if (key === 116) {
        APP = APP_LIST[28]
    }
    //t
    if (key === 117) {
        APP = APP_LIST[29]
    }
    //u
    if (key === 118) {
        APP = APP_LIST[30]
    }
    //v
    if (key === 119) {
        APP = APP_LIST[31]
    }
    //w
    if (key === 120) {
        APP = APP_LIST[32]
    }
    //x
    if (key === 121) {
        APP = APP_LIST[33]
    }
    //y
    if (key === 122) {
        APP = APP_LIST[34]
    }
    //z
}
