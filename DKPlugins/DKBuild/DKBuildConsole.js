var working = true

function DKBuildConsole_init() {
    CPP_DK_Create("DKBuild/DKBuild.js")
	CPP_DK_Create("DKGit/DKGit.js")
	
	/*
	let contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
	let files = contents.split(",")
	for(let i=0; i<files.length; i++){ 
		if(CPP_DKFile_Exists(DIGITALKNOB+files[i]+"/DKApps")){
			CPP_DKFile_ChDir(DIGITALKNOB+files[i])
			const diff = CPP_DK_Execute("git diff")
			if(diff)
				console.log("*** THERE ARE CHANGES IN THE '"+files[i]+"' CODE BASE ***")
		}
	}
	*/
	
	//console.log(DKGit_DiffCount())
	//DKGit_CheckForDiff()
    
	while (working)
        DKBuildConsole_Process()
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
	
	//UNIX FIX
	var key = 10
    while(key === 10 || key === 0)
        key = CPP_DK_GetKey()
	
    console.log("key = "+key)
	//Esc
	if (key === 27){
        CPP_DK_Exit()
		//UPDATE = ""
	}
	//Spacebar
	else if(key === 13){
		OS = cache_json.OS
	    APP = cache_json.APP
		TYPE = cache_json.TYPE
		LEVEL = cache_json.LEVEL
		//UPDATE = ""
	}
	//y key
    else if (key === 121) {
        CPP_DK_Create("DKGit/DKGit.js")
        DKGit_GitUpdate()
		//UPDATE = ""
    }
	//c key
    else if (key === 99) {
        CPP_DK_Create("DKGit/DKGit.js")
        DKGit_GitCommit()
		//UPDATE = ""
    }
	//r key
    else if (key === 114) { 
        DKBuild_ResetAppsPlugins()
        DKGit_GitUpdate()
		//UPDATE = ""
    }
	//x key
    else if (key === 120) {
        DKBuild_Reset3rdParty()
        DKBuild_ResetAppsPlugins()
        DKGit_GitUpdate()
		//UPDATE = ""
    }
}

function DKBuildConsole_SelectOs() {
	const OSes = [];
	if(CPP_DK_GetOS() === "Windows"){
		OSes.push("win32")
		OSes.push("win64")
		OSes.push("android32")
		OSes.push("android64")
	}
	if(CPP_DK_GetOS() === "Mac"){
		OSes.push("mac32")
		OSes.push("mac64")
		OSes.push("ios32")
		OSes.push("ios64")
		OSes.push("iossim32")
		OSes.push("iossim64")
	}
	if(CPP_DK_GetOS() === "Linux"){
		OSes.push("linux32")
		OSes.push("linux64")
	}
	if(CPP_DK_GetOS() === "Raspberry"){
		OSes.push("raspberry32")
		OSes.push("raspberry64")
	}
	
	console.log("\n")
    console.log("**** SELECT OS TO BUILD ****")
	for(let n=1; n<OSes.length+1; n++){
		console.log(n+". "+OSes[n-1])	
	}

    console.log("ESC. exit")
    console.log("\n")
    
	//UNIX FIX
	var key = 10
    while(key === 10 || key === 0)
        key = CPP_DK_GetKey()
	
	//console.log("key = "+key)
    if (key === 27) //Esc
        CPP_DK_Exit()
	else if (key === 49) //1
		OS = OSes[0]
	else if (key === 50) //2	
		OS = OSes[1]
	else if (key === 51) //3
		OS = OSes[2]
	else if (key === 52) //4	
		OS = OSes[3]
	else if (key === 53) //5	
		OS = OSes[4]
	else if (key === 54) //6	
		OS = OSes[5]
	else if (key === 55) //7	
		OS = OSes[6]
	else if (key === 56) //8	
		OS = OSes[7]
	else if (key === 57) //9	
		OS = OSes[8]
    else
        console.error("INVALID OPTION")
}

function DKBuildConsole_SelectApp() {
    console.log("**** SELECT APP TO BUILD ****")
	console.log("F1. ALL APPS")
    for (var i = 0; i < APP_LIST.length; ++i)
        console.log(DKBuildConsole_TranslateOption(i) + ":" + APP_LIST[i] + "")
    console.log("ESC. exit")
    console.log("\n")
    
	//UNIX FIX
	var key = 10
    while(key === 10 || key === 0)
        key = CPP_DK_GetKey()
	
	console.log("key = "+key)
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
    
	//UNIX FIX
	var key = 10
    while(key === 10 || key === 0)
        key = CPP_DK_GetKey()
	
	console.log("key = "+key)
    if (key === 27)
        CPP_DK_Exit()
    else if (key === 49)
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
	while (UPDATE === "")
        DKBuildConsole_ChooseUpdate()
    if (!CPP_DKFile_Exists(DIGITALKNOB)) {
        console.error("ERROR: can't find " + DIGITALKNOB + " ")
        CPP_DK_GetKey()
        CPP_DK_Exit()
    }
    while (OS === "")
        DKBuildConsole_SelectOs()
    console.log("###########################")
    console.log(OS + " ->")
    console.log("###########################")
    DKBuild_GetAppList()
    while (APP === "")
        DKBuildConsole_SelectApp()
    console.log("###########################")
    console.log(OS + " -> " + APP + " ->")
    console.log("###########################")
    while (TYPE === "")
        DKBuildConsole_SelectType()
    console.log("###########################")
    console.log(OS + " -> " + APP + " -> " + TYPE + "")
    console.log("###########################")
    //console.log("Press any key to Build")
    //CPP_DK_GetKey()
	if(APP == "ALLAPPS"){
		for (var i = 0; i < APP_LIST.length; ++i){
		    APP = APP_LIST[i]
			console.log("###########################")
			console.log(OS + " -> " + APP + " -> " + TYPE + "")
			console.log("###########################")
			DKBuild_DoResults()
		}
	}
	else{
		DKBuild_DoResults()
	}
    
}

function DKBuildConsole_TranslateOption(num) {
    if (num === 0)
        return "1"
    if (num === 1)
        return "2"
    if (num === 2)
        return "3"
    if (num === 3)
        return "4"
    if (num === 4)
        return "5"
    if (num === 5)
        return "6"
    if (num === 6)
        return "7"
    if (num === 7)
        return "8"
    if (num === 8)
        return "9"
    if (num === 9)
        return "a"
    if (num === 10)
        return "b"
    if (num === 11)
        return "c"
    if (num === 12)
        return "d"
    if (num === 13)
        return "e"
    if (num === 14)
        return "f"
    if (num === 15)
        return "g"
    if (num === 16)
        return "h"
    if (num === 17)
        return "i"
    if (num === 18)
        return "j"
    if (num === 19)
        return "k"
    if (num === 20)
        return "l"
    if (num === 21)
        return "m"
    if (num === 22)
        return "n"
    if (num === 23)
        return "o"
    if (num === 24)
        return "p"
    if (num === 25)
        return "q"
    if (num === 26)
        return "r"
    if (num === 27)
        return "s"
    if (num === 28)
        return "t"
    if (num === 29)
        return "u"
    if (num === 30)
        return "v"
    if (num === 31)
        return "w"
    if (num === 32)
        return "x"
    if (num === 33)
        return "y"
    if (num === 34)
        return "z"
}

function DKBuildConsole_KeyToApp(key) {
	if(CPP_DK_GetOS() === "Linux" || CPP_DK_GetOS() === "Mac"){
		//F1 Unix
		if (key === 80)
			APP = "ALLAPPS"
		//F2 = 82... etc.
	}
	else{
		//F1 Windows
		if (key === 59)
			APP = "ALLAPPS"
	}
    if (key === 49)
        APP = APP_LIST[0] //1
    if (key === 50)
        APP = APP_LIST[1] //2
    if (key === 51)
        APP = APP_LIST[2] //3 
    if (key === 52)
        APP = APP_LIST[3] //4
    if (key === 53)
        APP = APP_LIST[4] //5
    if (key === 54)
        APP = APP_LIST[5] //6
    if (key === 55)
        APP = APP_LIST[6] //7
    if (key === 56)
        APP = APP_LIST[7] //8
    if (key === 57)
        APP = APP_LIST[8] //9
    if (key === 97)
        APP = APP_LIST[9] //a
    if (key === 98)
        APP = APP_LIST[10] //b
    if (key === 99)
        APP = APP_LIST[11] //c
    if (key === 100)
        APP = APP_LIST[12] //d
    if (key === 101)
        APP = APP_LIST[13] //e
    if (key === 102)
        APP = APP_LIST[14] //f
    if (key === 103)
        APP = APP_LIST[15] //g
    if (key === 104)
        APP = APP_LIST[16] //h
    if (key === 105)
        APP = APP_LIST[17] //i
    if (key === 106)
        APP = APP_LIST[18] //j
    if (key === 107)
        APP = APP_LIST[19] //k
    if (key === 108)
        APP = APP_LIST[20] //l
    if (key === 109)
        APP = APP_LIST[21] //m
    if (key === 110)
        APP = APP_LIST[22] //n
    if (key === 111)
        APP = APP_LIST[23] //o
    if (key === 112)
        APP = APP_LIST[24] //p
    if (key === 113)
        APP = APP_LIST[25] //q
    if (key === 114)
        APP = APP_LIST[26] //r
    if (key === 115)
        APP = APP_LIST[27] //s
    if (key === 116)
        APP = APP_LIST[28] //t
    if (key === 117)
        APP = APP_LIST[29] //u
    if (key === 118)
        APP = APP_LIST[30] //v
    if (key === 119)
        APP = APP_LIST[31] //w
    if (key === 120)
        APP = APP_LIST[32] //x
    if (key === 121)
        APP = APP_LIST[33] //y
    if (key === 122)
        APP = APP_LIST[34] //z
}

DKBuildConsole_init()