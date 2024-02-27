var working = true
var UPDATE = ""
var OS     = ""
var APP    = ""
var TYPE   = ""
var LEVEL  = "RebuildAll";

function getch(){
	key = CPP_DK_getch()
	//console.log("key = "+key)
	return key
}


function DKBuildConsole_init() {
    CPP_DK_Create("DKBuild/DKBuild.js")
	CPP_DK_Create("DKGit/DKGit.js")
	//DKGit_CheckForDiff()
	while (working)
        DKBuildConsole_Process()
}

function DKBuildConsole_end() {
    CPP_DK_Close("DKBuild/DKBuild.js")
}

function DKBuildConsole_ChooseUpdate() {
	console.log("**** Update DigitalKnob ??? ****")
	console.log("    1:  Git Update")
	console.log("    2:  Git Commit")
	console.log("    3.  Push assets")
	console.log("    4.  Pull assets")
	console.log("    A:  Reset Apps")
	console.log("    P:  Reset Plugins")
	console.log("    T:  Reset 3rdParty")
	console.log("    X:  Reset Everything")
	console.log("    C:  Clear Screen")
	console.log("    S:  Clear cmake cache and .tmp files")
	const assets = CPP_DKAssets_LocalAssets()
	if(CPP_DKFile_Exists(assets+"cache.txt")){
		const cache = CPP_DKFile_FileToString(assets+"cache.txt")
		if(cache){
			const cache_json = JSON.parse(cache)
			console.log("Enter:  "+cache_json.APP+" -> "+cache_json.OS+" -> "+cache_json.TYPE+" -> "+cache_json.LEVEL)
		}
	}
	console.log("    0:  BACK")
	console.log("  Esc:  EXIT")
	console.log("        Any Other Key To Skip")
	console.log("\n")
	
	//Scan Codes - https://docs.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-6.0/aa299374(v=vs.60)?redirectedfrom=MSDN	
	var key = getch()
	
	UPDATE = 1	
	switch(key){
		case 49: //1 key
			console.log("-> Git Update")
			CPP_DK_Create("DKGit/DKGit.js")
			DKGit_GitUpdate()
			break
		case 50: //2 key
			console.log("-> Git Commit")
			CPP_DK_Create("DKGit/DKGit.js")
			DKGit_GitCommit()
			break
		case 51: //3 key
			console.log("-> Push assets")
			dk.file.pushDKAssets()
			break
		case 52: //4 key
			console.log("-> Pull assets")
			dk.file.pullDKAssets()
			break
		case 97: //A key	
			console.log("-> Reset Apps")
			DKBuild_ResetAppsPlugins()
			DKGit_GitUpdate()
			break
		case 112: //P key
			console.log("-> Reset Plugins")
			DKBuild_ResetPlugins()
			DKGit_GitUpdate()
			break
		case 116: //T key
			console.log("-> Reset 3rdParty")
			DKBuild_Reset3rdParty()
			DKGit_GitUpdate()
			break
		case 120: //X key
			console.log("-> Reset Everything")
			DKBuild_ResetEverything()
			DKGit_GitUpdate()
			break
		case 99: //C key	
			console.log("-> Clear Screen")
			if(CPP_DK_GetOS() === "Windows"){
				CPP_DK_System('cls')
			}
			else{
				CPP_DK_System('clear')
			}
			UPDATE = ""
			break
		case 115: //S key
			DKBuild_ClearCMakeCache()
			DKBuild_DeleteTmpFiles()
			UPDATE = ""
			break
		case 48: //0 key
			console.log("-> BACK")
			UPDATE = "";
			break
		case 27: //Esc key
			console.log("-> EXIT")
			CPP_DK_Exit()
			break
		case 10: //Enter key (unix)
		case 13: //Enter key (windows)
			console.log("-> Rerunning last configuration")
			OS = cache_json.OS
			APP = cache_json.APP
			TYPE = cache_json.TYPE
			LEVEL = cache_json.LEVEL
			break
		default:
			break
	}
}

function DKBuildConsole_SelectOs() {
	const OSes = [];
	if(CPP_DK_GetOS() === "Windows"){
		var arch = CPP_DK_Execute("ECHO %PROCESSOR_ARCHITECTURE%")
		//console.log("arch = "+arch)
		//if(CPP_DK_GetOSArchitecture() === "i686")
		//if(arch === "i686" || arch === "x86"){
			OSes.push("win32")
		//}
		//if(CPP_DK_GetOSArchitecture() === "x86_64")
		//if(arch === "x86_64"){
			OSes.push("win64")
		//}
		OSes.push("android_arm32")
		OSes.push("android_arm64")
		OSes.push("emscripten")
	}
	if(CPP_DK_GetOS() === "Mac"){
		var arch = CPP_DK_Execute("uname -m")
		//console.log("arch = "+arch)
		//OSes.push("mac32")
		OSes.push("mac64")
		//OSes.push("ios_arm32")
		OSes.push("ios_arm64")
		//OSes.push("iossim_x86")
		OSes.push("iossim_x86_64")
		OSes.push("android_arm32")
		OSes.push("android_arm64")
		OSes.push("emscripten")
	}
	if(CPP_DK_GetOS() === "Linux"){
		var arch = CPP_DK_Execute("uname -m")
		//console.log("arch = "+arch)
		if(arch === "i686"){
			OSes.push("linux32")
		}
		else if(arch === "x86_64"){
			OSes.push("linux64")
		}
		else{
			console.log("ERROR: Unrecognized architecture")
		}
		OSes.push("android_arm32")
		OSes.push("android_arm64")
		OSes.push("emscripten")
	}
	if(CPP_DK_GetOS() === "Raspberry"){
		var arch = CPP_DK_Execute("uname -m")
		//console.log("arch = "+arch)
		//if(arch = "amrv7l"){
			OSes.push("raspberry32")
		//}
		//else if(arch = "amrv7l64")
			//OSes.push("raspberry64")
		//}
		//OSes.push("android_arm32")
		//OSes.push("android_arm64")
		//OSes.push("emscripten")
	}
		
	console.log("\n")
	console.log("**** SELECT OS TO BUILD ****")
	for(var n=1; n<OSes.length+1; n++){
		console.log("    "+n+":  "+OSes[n-1])	
	}

	console.log("    0:  BACK")
	console.log("  Esc:  EXIT")
	console.log("\n")
		
	var key = getch()

	switch(key){
		case 48: //0
			console.log("-> BACK")
			UPDATE = ""
			break
		case 27: //Esc
			CPP_DK_Exit()
			console.log("-> EXIT")
			break
		case 49: //1
			console.log("-> "+OSes[0])
			OS = OSes[0]
			break
		case 50: //2	
			console.log("-> "+OSes[1])
			OS = OSes[1]
			break
		case 51: //3
			console.log("-> "+OSes[2])
			OS = OSes[2]
			break
		case 52: //4
			console.log("-> "+OSes[3])
			OS = OSes[3]
			break
		case 53: //5
			console.log("-> "+OSes[4])
			OS = OSes[4]
			break
		case 54: //6
			console.log("-> "+OSes[5])
			OS = OSes[5]
			break
		case 55: //7
			console.log("-> "+OSes[6])
			OS = OSes[6]
			break
		case 56: //8	
			console.log("-> "+OSes[7])
			OS = OSes[7]
			break
		case 57: //9
			console.log("-> "+OSes[8])
			OS = OSes[8]
			break
		case 58: //0
			console.log("-> "+OSes[9])
			OS = OSes[9]
			break
		default:
			console.error("("+key+")INVALID OPTION")
			OS = ""
			break
	}
}

function DKBuildConsole_SelectApp() {
	console.log("**** SELECT APP TO BUILD ****")
	DKBuild_GetAppList()
	for (var i = 0; i < APP_LIST.length; ++i)
		console.log("  "+DKBuildConsole_TranslateOption(i) + ":  " + APP_LIST[i] + "")
	console.log("   F1:  ALL APPS")
	console.log("    0:  BACK")
	console.log("  Esc:  EXIT")
	console.log("\n")
		
	var key = getch()
	
	switch(key){
		case 48: //0
			console.log("-> BACK")	
			OS = ""	
			break
		case 27:  //Esc
			console.log("-> EXIT")
			CPP_DK_Exit()
			break
		default:
			DKBuildConsole_KeyToApp(key)
			console.log("-> "+APP)
			if(APP === ""){
				console.error("("+key+")INVALID OPTION")
			}
		break
	}
}

function DKBuildConsole_SelectType() {
	console.log("**** SELECT BUILD TYPE ****")
	console.log("    1:  Debug")
	console.log("    2:  Release")
	console.log("    3:  All")
	console.log("    0:  BACK")
	console.log("  Esc:  EXIT")
	console.log("\n")
	
	var key = getch()
		
	switch(key){
		case 48: //0
			console.log("-> BACK")
			APP = ""
			break
		case 27: //Esc
			console.log("-> EXIT")
			TYPE = ""
			CPP_DK_Exit()
			break
		case 49: //1
			console.log("-> Debug")
			TYPE = "Debug"
			break
		case 50: //2
			console.log("-> Release")
			TYPE = "Release"
			break
		case 51: //3
			console.log("-> ALL")
			TYPE = "ALL"
			break
		default:
			console.error("("+key+")INVALID OPTION")
			TYPE = ""
			break
	}
}


// launch iOS simulator app: https://stackoverflow.com/a/35262865/688352
function BuildConsole_PostBuildOptions(){
	console.log("**** Post-Build Options ****")
	var num = 1
	const exe_path = DKBuildConsole_FindAppExecutablePath(OS, APP, TYPE)
	if(exe_path){
		console.log("    "+num+":  Launch "+APP+" Executable")
		num++
	}
	const solution_path = DKBuildConsole_FindAppSolutionPath(OS, APP, TYPE)
	if(solution_path){
		console.log("    "+num+":  Open Generated "+APP+" Solution")
	}
	console.log("    0:  BACK")
	console.log("  Esc:  EXIT")
	console.log("        Any Other Key To Skip") 
	console.log("\n")
	var key = getch()
		
	switch(key){
		case 48: //0
			console.log("-> BACK")
			APP = ""
			break
		case 27: //Esc
			console.log("-> EXIT")
			TYPE = ""
			CPP_DK_Exit()
			break
		case 49: //1
			console.log("-> Run "+APP+" Debug Executable")
			DKBuildConsole_RunApp(OS, APP, "Debug")
			break
		case 50: //2
			console.log("-> Open Generated "+APP+" Soluton")
			DKBuildConsole_OpenAppSolution(OS, APP)
			break
		default:
			break
	}
}

function DKBuildConsole_Process() {
	
	while(TYPE === ""){
		switch(true){
			case UPDATE === "":
				DKBuildConsole_ChooseUpdate()
				break
			case (OS === ""):
				DKBuildConsole_SelectOs()
				break
			case APP === "":
				DKBuildConsole_SelectApp()
				break
			case TYPE === "":
				DKBuildConsole_SelectType()
				break
			default:
		}
	}
		
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
		console.log("###########################")
		console.log(OS + " -> " + APP + " -> " + TYPE + "")
		console.log("###########################")
		DKBuild_DoResults()
	}
	
	BuildConsole_PostBuildOptions()
	
	UPDATE = ""
	OS     = ""	
	APP    = ""
	TYPE   = ""
	LEVEL  = "RebuildAll";
}    

function DKBuildConsole_FindAppExecutablePath(os, app, type){
	const app_path = DKBuild_FindAppPath(app)
	if(os === "win32" || os === "win64"){
		const exe_name = app+".exe"
	}
	else if(os === "linux32" || os === "linux64" || os === "raspberry32" || os === "raspberry64"){
		const exe_name = app
	}
	else if(os === "mac32" || os === "mac64"){
		const exe_name = app+".app/Contents/MacOS/wrapper"
	}
	else{
		console.log("the OS ("+os+") is not implemented")
		return false
	}
	
	if(type === "ALL")
		type = "Release"
	const exe_path = app_path+os+"/"+type+"/"+exe_name
	
	console.log("exe_path = "+exe_path)
	if(CPP_DKFile_Exists(exe_path)){
		return exe_path
	}
	return 0
}

function DKBuildConsole_FindAppSolutionPath(os, app, type){
	const app_path = DKBuild_FindAppPath(app)
	var solution_path
	if(os === "win32" || os === "win64"){
		solution_path = app_path+os+"/"+app+".sln"
	}
	else if(os === "mac32" || os === "mac64"){
		solution_path = app_path+os+"/"+app+".xcodeproj"
	}
	else if(os === "linux32" || os === "linux64" || os === "raspberry32" || os === "raspberry64"){
		//solution_path = app_path+os+"/"+app+".xcodeproj"
		console.warn("the OS ("+os+") is not implemented")
		return false
	}
	else{
		console.warn("the OS ("+os+") is not implemented")
		return false
	}
	console.log("solution_path = "+solution_path)
	if(CPP_DKFile_Exists(solution_path)){
		return solution_path
	}
}

function DKBuildConsole_RunApp(os, app, type){
	const exe_path = DKBuildConsole_FindAppExecutablePath(os, app, type)
	if(CPP_DKFile_Exists(exe_path)){
		CPP_DK_Run('\"'+exe_path+'\"',"")
		return true
	}
	console.log("ERROR: path does not exist: "+exe_path)
}

function DKBuildConsole_OpenAppSolution(os, app){
	const app_path = DKBuild_FindAppPath(app)
	if(os === "win32" || os === "win64"){
		const solution_name = app+".sln"
	}
	else if(os === "mac32" || os === "mac64" || os === "ios_arm32" || os === "ios_arm64" || os === "iossim_x86" || os === "iossim_x86_64"){
		const solution_name = app+".xcodeproj"
	}
	else{
		console.log("the OS ("+os+") is not implemented")
		return false
	}
	const solution_path = app_path+os+"/"+solution_name
	if(CPP_DKFile_Exists(solution_path)){
		CPP_DK_Run('\"'+solution_path+'\"', "")
		return true
	}
	console.log("ERROR: path does not exist: "+solution_path)
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