//CPP_DK_Execute("cmd /c echo press and key to continue && timeout /t 60 > nul") //Wait for key or 1 minute
var UPDATE = "" //allow the first screen to loop
var OS = ""   //win32,win64,mac32,mac64,linux32,linux64,ios_arm32,ios_arm64,iossim32,iossim64,android_arm32,android_arm64,raspberry32,raspberry64 
var APP = ""  //DKAppname
var TYPE = ""  //Debug, Release, ALL
var LINK = "Static" //, Dynamic
var LEVEL = ""  //Build, Rebuild, RebuildAll
var DIGITALKNOB = ""
var DKDOWNLOAD = ""
var CMAKE = ""
var ANDROID_NDK = ""  //filled by DKBuild_ValidateNDK()
var VISUALSTUDIO_VERSION = "2022"
var VISUALSTUDIO = ""
var VS_GENERATOR = "Visual Studio 17 2022"
var MSBUILD = ""
var GCC = ""
var XCODE = ""
var APP_LIST = []

const USERNAME = CPP_DK_GetUsername()
if(!USERNAME){
	console.error("! could not get the current username !")
}
console.log("username was set to: "+USERNAME)

function DKBuild_GetDKMakeVariable(file, variable){
	// TEST: Throw error if variable is not found
	const str = CPP_DKFile_FileToString(file)
	if(!str){
		console.error("DKBuild_GetDKMakeVariable(): str invalid!")
		return null;
	}
	str = str.split("dkset(").join("set(")
	str = str.split("DKSET(").join("set(")
	str = str.split("SET(").join("set(")
	var index = str.indexOf("set("+variable+" ")
	var pos = index	
	var marker = 0
	while(index > -1 && pos > -1){
		if(str.charAt(pos) === '\n' || pos === 0){
			marker = str.indexOf(" ", index)
			const endIndex = str.indexOf(")", marker)
			if(endIndex === -1){
				console.error("set( missing closing bracket")
				return null
			}
			const value = str.substring(marker+1, endIndex)
			return value
		}
		if(str.charAt(pos) === '#'){
			marker = index+1
			index = str.indexOf("set("+variable+" ", marker)
			pos = index
		}else{
			pos--
		}
	}
	console.error("DKBuild_GetDKMakeVariable("+file+","+variable+"): "+variable+" not found!")
	return null
}

function DKBuild_init(){
	CPP_DK_Create("DKCurl")
	CPP_DK_Create("DKArchive")

	if(CPP_DK_GetOS() === "Windows"){
		DIGITALKNOB = "C:/Users/"+USERNAME+"/digitalknob/"
		if(CPP_DK_GetOSArchitecture() === "32"){
			CMAKE = "C:/Program Files/CMake/bin/cmake.exe"
			VISUALSTUDIO = "C:/Program Files/Microsoft Visual Studio/"+VISUALSTUDIO_VERSION
		}
		if(CPP_DK_GetOSArchitecture() === "64"){
			CMAKE = "C:/Program Files (x86)/CMake/bin/cmake.exe"
			VISUALSTUDIO = "C:/Program Files/Microsoft Visual Studio/"+VISUALSTUDIO_VERSION
		}
		//CMAKE = CPP_DKFile_GetShortName(CMAKE)
		CMAKE = DKBuild_GetShortPath(CMAKE)
		MSBUILD = VISUALSTUDIO+"/Community/MSBuild/Current/Bin/MSBuild.exe"
		MSBUILD = CPP_DKFile_GetShortName(MSBUILD)
	}
	if(CPP_DK_GetOS() === "Mac"){
		DIGITALKNOB = "/Users/"+USERNAME+"/digitalknob/"
		CMAKE = "/Applications/CMake.app/Contents/bin/cmake"
		XCODE = "/Applications/Xcode.app"
	}
	if(CPP_DK_GetOS() === "Linux"){
		DIGITALKNOB = "/home/"+USERNAME+"/digitalknob/"
		CMAKE = "/usr/bin/cmake"
		GCC = "/usr/bin/g++"
	}
	if(CPP_DK_GetOS() === "Raspberry"){
		DIGITALKNOB = "/home/"+USERNAME+"/digitalknob/"
		CMAKE = "/usr/bin/cmake"
		GCC = "/usr/bin/g++"
	}
	
	DKDOWNLOAD = DIGITALKNOB+"download"
	CPP_DKFile_MkDir(DKDOWNLOAD) //FIXME: code DKCurl to create directories automatically
	
	/* Error handling example 
	const rtn = CPP_DK_Execute("cd TestError")
	if(rtn.error)
		console.error("\n\n "+rtn.command+" \n   ERROR:("+rtn.code+"): "+rtn.error)
	*/
}

function DKBuild_end(){
	CPP_DKFile_Copy(CPP_DKFile_GetExePath(), DIGITALKNOB+CPP_DKFile_GetExeName(), true)
}

//This is and alternative way to get windows short paths
function DKBuild_GetShortPath(fullPath){
	if(CPP_DK_GetOS() !== "Windows")
		return fullPath;
	const assets = CPP_DKAssets_LocalAssets()
	var getShortPath = assets+"/DKFile/getShortPath.cmd"
	var shortPath = CPP_DK_Execute(getShortPath+' "'+fullPath+'"')
	//shortPath = shortPath.slice(0, -1)
	while(shortPath.includes("\\")){
		shortPath = shortPath.replace("\\","/")
	}
	return shortPath
}

function DKBuild_ClearCMakeCache(){
	console.log("Clearing CMake cache . . .")
	CPP_DKFile_ChDir(DIGITALKNOB)
	if(CPP_DK_GetOS() === "Windows"){
		CPP_DK_Execute("cmd /c for /r %i in (CMakeCache.*) do del \"%i\"")
		CPP_DK_Execute("cmd /c for /d /r %i in (*CMakeFiles*) do rmdir /s /Q \"%i\"")
	}else{
		CPP_DK_Execute("find . -name \"CMakeCache.*\" -delete") 
		CPP_DK_Execute("rm -rf `find . -type d -name CMakeFiles`")
	}
}

function DKBuild_DeleteTmpFiles(){
	console.log("Deleting .TMP files . . .")
	CPP_DKFile_ChDir(DIGITALKNOB)
	if(CPP_DK_GetOS() === "Windows"){
		// FIXME: this will also delete *.tmpl files, etc.
		// 		  this should be reworked to ONLY delete matching .tmp files
		CPP_DK_Execute("cmd /c for /r %i in (*.tmp) do del \"%i\"")
		CPP_DK_Execute("cmd /c for /r %i in (*.TMP) do del \"%i\"")
	}else{
		CPP_DK_Execute("find . -name \"*.tmp\" -delete") 
		CPP_DK_Execute("find . -name \"*.TMP\" -delete") 
	}
}

function DKBuild_ValidateCmake(){
	console.log("Looking for CMake")
	if(!CPP_DKFile_Exists(CMAKE))
		DKBuild_InstallCmake()
	if(CPP_DKFile_Exists(CMAKE))
		console.log("Found CMake")
	if(CPP_DK_GetOS() === "Mac")
		CMAKE = "cmake"
}

function DKBuild_InstallCmake(){
	console.log("Installing CMake")
	if(CPP_DK_GetOS() === "Windows"){
		if(CPP_DK_GetOSArchitecture() === "32"){
			if(!CPP_DKFile_Exists(DKDOWNLOAD+"/cmake-3.19.4-win32-x86.msi"))
				CPP_DKCurl_Download("https://cmake.org/files/v3.19/cmake-3.19.4-win32-x86.msi", DKDOWNLOAD)
			CPP_DK_System(DKDOWNLOAD+"/cmake-3.19.4-win32-x86.msi")
		}
		if(CPP_DK_GetOSArchitecture() === "64"){
			if(!CPP_DKFile_Exists(DKDOWNLOAD+"/cmake-3.19.4-win32-x86.msi"))
				CPP_DKCurl_Download("https://cmake.org/files/v3.19/cmake-3.19.4-win32-x86.msi", DKDOWNLOAD)
			CPP_DK_System(DKDOWNLOAD+"/cmake-3.19.4-win32-x86.msi")
		}
	}
	if(CPP_DK_GetOS() === "Mac"){
		//TODO
	}
	if(CPP_DK_GetOS() === "Linux")
		CPP_DK_Execute("sudo apt-get install cmake")
	if(CPP_DK_GetOS() === "Raspberry")
		CPP_DK_Execute("sudo apt-get install cmake")
}

function DKBuild_ValidateVC2019(){
	if(CPP_DK_GetOS() !== "Windows"){
		console.log("Visual Studio is for Windows only. skipping...")
		return;
	}
	console.log("Looking for Visual Studio")
	if(!CPP_DKFile_Exists(VISUALSTUDIO))
		DKBuild_InstallVC2019()
	if(CPP_DKFile_Exists(VISUALSTUDIO))
		console.log("Found Visual Studio")
}

function DKBuild_InstallVC2019(){
	console.log("Installing Visual Studio")
	CPP_DKCurl_Download("https://download.visualstudio.microsoft.com/download/pr/5e397ebe-38b2-4e18-a187-ac313d07332a/169156e6e9a005d49b357c42240184dc1e3ccc28ebc777e70d49257c074f77e8/vs_Community.exe", DKDOWNLOAD)
	CPP_DK_System(DKDOWNLOAD+"/vs_Community.exe")
}

function DKBuild_ValidateGcc(){
	console.log("Looking for GCC")
	if(!CPP_DKFile_Exists(GCC))
		DKBuild_InstallGcc()
	if(CPP_DKFile_Exists(GCC))
		console.log("Found Gcc")
}

function DKBuild_InstallGcc(){
	console.log("Installing Gcc")
	CPP_DK_Execute("sudo apt-get update && sudo apt-get install build-essential")
}

function DKBuild_ValidateXcode(){
	console.log("Looking for Xcode")
	if(!CPP_DKFile_Exists(XCODE))
		DKBuild_InstallXcode()
	if(CPP_DKFile_Exists(XCODE))
		console.log("Found Xcode")
}

function DKBuild_InstallXcode(){
	console.log("Installing Xcode")
	//CPP_DKCurl_Download("http://TODO.com/xcode4630916281a.dmg", DKDOWNLOAD)
	//TODO - Install Xcode
}

function DKBuild_ValidateNDK(){
	const ANDROID_NDK_BUILD = DKBuild_GetDKMakeVariable(DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/android-ndk/DKMAKE.cmake", "ANDROID-NDK_BUILD")
	var ANDROID_NDK_DL = ""
	if(CPP_DK_GetOS() === "Windows")
		ANDROID_NDK_DL = DKBuild_GetDKMakeVariable(DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/android-ndk/DKMAKE.cmake", "ANDROID-NDK_WIN_DL")
	if(CPP_DK_GetOS() === "Mac")
		ANDROID_NDK_DL = DKBuild_GetDKMakeVariable(DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/android-ndk/DKMAKE.cmake", "ANDROID-NDK_MAC_DL")
	if(CPP_DK_GetOS() === "Linux")
		ANDROID_NDK_DL = DKBuild_GetDKMakeVariable(DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/android-ndk/DKMAKE.cmake", "ANDROID-NDK_LINUX_DL")
	ANDROID_NDK = DIGITALKNOB+"DK/3rdParty/android-sdk/ndk/"+ANDROID_NDK_BUILD
	
	//set environment variables
	if(CPP_DK_GetOS() === "Windows"){
		if(ANDROID_NDK !== CPP_DK_Execute("echo %VS_NdkRoot%", "rt"))
			CPP_DK_Execute("setx VS_NdkRoot "+ANDROID_NDK) //https://stackoverflow.com/a/54350289/688352
	}
	else{
		console.warn("setting environment variables not implemented on this OS");
	}
		
	// Validate install
	if(!CPP_DKFile_Exists(ANDROID_NDK+"/installed")){
		console.log("Installing Android NDK "+ANDROID_NDK_BUILD+" . . .")
		CPP_DKCurl_Download(ANDROID_NDK_DL, DKDOWNLOAD)
		const index = ANDROID_NDK_DL.lastIndexOf("/")
		const filename = ANDROID_NDK_DL.substring(index+1)
		CPP_DKArchive_Extract(DKDOWNLOAD+"/"+filename, DIGITALKNOB+"DK/3rdParty/android-sdk/ndk")
		CPP_DKFile_Rename(DIGITALKNOB+"DK/3rdParty/android-sdk/ndk/android-ndk-r22b", ANDROID_NDK, true)
		CPP_DKFile_Rename(DIGITALKNOB+"DK/3rdParty/android-sdk/ndk/android-ndk-r23b", ANDROID_NDK, true)
		CPP_DKFile_Copy(DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/android-ndk/", ANDROID_NDK, true)
		CPP_DKFile_Delete(ANDROID_NDK+"/DKMAKE.cmake")
		CPP_DKFile_StringToFile(ANDROID_NDK_BUILD, ANDROID_NDK+"/installed")
	}
}

function DKBuild_ValidateEMSDK(){
	console.log("Looking for Emscripten SDK . . .")
	const EMMAKE = DKBuild_GetDKMakeVariable(DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/emsdk/DKMAKE.cmake", "EMMAKE")
	if(!CPP_DKFile_Exists(EMMAKE))
		DKBuild_InstallEMSDK()
	if(CPP_DKFile_Exists(EMMAKE))
		console.log("Found Emscripten SDK")
}

function DKBuild_InstallEMSDK(){
	CPP_DKFile_MkDir(DIGITALKNOB+"DK/3rdParty/emsdk-main")
	CPP_DKFile_ChDir(DIGITALKNOB+"DK/3rdParty/emsdk-main")
	const EMSDK_GIT = "https://github.com/emscripten-core/emsdk.git"
	if(!CPP_DKFile_Exists(DIGITALKNOB+"DK/3rdParty/emsdk-main/.git"))
		CPP_DK_Execute("git clone "+EMSDK_GIT+" "+DIGITALKNOB+"DK/3rdParty/emsdk-main")
	CPP_DK_Execute("git checkout -- .")
	CPP_DK_Execute("git checkout main")
	CPP_DK_Execute("git pull")
	
	CPP_DK_Execute(DIGITALKNOB+"DK/3rdParty/emsdk-main/emsdk install latest")
	CPP_DK_Execute(DIGITALKNOB+"DK/3rdParty/emsdk-main/emsdk activate latest")
	if(CPP_DK_GetOS() === "Windows"){
		CPP_DK_Execute(DIGITALKNOB+"DK/3rdParty/emsdk-main/emsdk install mingw-4.6.2-32bit")
		CPP_DK_Execute(DIGITALKNOB+"DK/3rdParty/emsdk-main/emsdk activate mingw-4.6.2-32bit")
	}
	if(CPP_DK_GetOS() !== "Windows")
		CPP_DK_Execute("chmod 777 "+DIGITALKNOB+"DK/3rdParty/emsdk-main/emsdk_env.sh")
}
	
function DKBuild_ResetApps(){
	var contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
	var items = contents.split(",")
	for(var n=0; n<items.length; n++){
		if(CPP_DKFile_Exists(DIGITALKNOB+items[n]+"/.git")){
			if(CPP_DKFile_Exists(DIGITALKNOB+items[n]+"/DKApps")){
				var app_contents = CPP_DKFile_DirectoryContents(DIGITALKNOB+items[n]+"/DKApps")
				var apps = app_contents.split(",")
				for(var nn=0; nn<apps.length; nn++){
					if(CPP_DKFile_IsDirectory(DIGITALKNOB+items[n]+"/DKApps/"+apps[nn])){
						if(apps[nn] !== "DKBuilder")
							DKGit_CleanFolder(DIGITALKNOB+items[n]+"/DKApps/"+apps[nn])
					}
				}
			}
		}
	}
}

function DKBuild_ResetPlugins(){
	var contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
	var items = contents.split(",")
	for(var n=0; n<items.length; n++){
		if(CPP_DKFile_Exists(DIGITALKNOB+items[n]+"/.git")){
			if(CPP_DKFile_Exists(DIGITALKNOB+items[n]+"/DKPlugins"))
				DKGit_CleanFolder(DIGITALKNOB+items[n]+"/DKPlugins")
		}
	}
}

function DKBuild_Reset3rdParty(){
	var contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
	var items = contents.split(",")
	for(var n=0; n<items.length; n++){
		if(CPP_DKFile_Exists(DIGITALKNOB+items[n]+"/.git")){
			if(CPP_DKFile_Exists(DIGITALKNOB+items[n]+"/3rdPatry"))
				DKGit_CleanFolder(DIGITALKNOB+items[n]+"/3rdParty")
		}
	}
}

function DKBuild_ResetEverything(){
	var contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
	var items = contents.split(",")
	for(var n=0; n<items.length; n++){
		if(CPP_DKFile_Exists(DIGITALKNOB+items[n]+"/.git")){
			DKGit_CleanFolder(DIGITALKNOB+items[n])
		}
	}
}

function DKBuild_GetAppList(){
	APP_LIST = []
	var contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
	var items = contents.split(",")
	for(var i=0; i<items.length; i++){
		if(CPP_DKFile_Exists(DIGITALKNOB+items[i]+"/DKApps")){
			if(CPP_DKFile_IsDirectory(DIGITALKNOB+items[i]+"/DKApps")){
				var dkApps = CPP_DKFile_DirectoryContents(DIGITALKNOB+items[i]+"/DKApps")
				var dkAppsArray = dkApps.split(",")
				for(var nn=0; nn < dkAppsArray.length; nn++){
					if(CPP_DKFile_Exists(DIGITALKNOB+items[i]+"/DKApps/"+dkAppsArray[nn]+"/DKMAKE.cmake")){
						APP_LIST.push(dkAppsArray[nn])
					}
				}
			}
		}
	}
}

function DKBuild_FindAppPath(name){
	var contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
	var files = contents.split(",")
	for(var i=0; i<files.length; i++){ 
		if(CPP_DKFile_Exists(DIGITALKNOB+files[i]+"/DKApps/"+name+"/DKMAKE.cmake"))
			return DIGITALKNOB+files[i]+"/DKApps/"+name+"/"
	}
	return 0;
}


function DKBuild_Command(command){
	const result = CPP_DK_Execute(command)
	if(result.error){
		//console.log("DKBuild_Command() -> ERROR:("+result.code+"):  "+result.message);
		return false; //currently c++ displays output. Need to make an on/off for that and print here if desired.
	}
	console.log("DKBuild_Command("+command+") -> "+result+"\n")
	return true;
}


function DKBuild_DoResults(){
	console.log("DKBuild_DoResults(): OS="+OS+" APP="+APP+" TYPE="+TYPE+" LEVEL="+LEVEL)
	
	DKBuild_ClearCMakeCache()
	DKBuild_DeleteTmpFiles()
	
	//save configuration to cache
	const cache = {"OS":OS, "APP":APP, "TYPE":TYPE, "LEVEL":LEVEL}
	const cache_json = JSON.stringify(cache)
	const assets = CPP_DKAssets_LocalAssets()
	CPP_DKFile_StringToFile(cache_json, assets+"cache.txt")
	
	DKBuild_ValidateCmake()
	
	////// Create the cmake string
	var cmake_string = ""
	//cmake_string = cmake_string+"--warn-uninitialized "
	if(TYPE === "Debug" || TYPE === "ALL")
		cmake_string = cmake_string+"-DDEBUG=ON "
	if(TYPE === "Release" || TYPE === "ALL")
		cmake_string = cmake_string+"-DRELEASE=ON "
	if(LEVEL === "Build")
		cmake_string = cmake_string+"-DBUILD=ON "
	if(LEVEL === "Rebuild")
		cmake_string = cmake_string+"-DREBUILD=ON "
	if(LEVEL === "RebuildAll")
		cmake_string = cmake_string+"-DREBUILDALL=ON "
	if(LINK.indexOf("Static") !== -1)
		cmake_string = cmake_string+"-DSTATIC=ON "
	if(LINK.indexOf("Shared") !== -1)
		cmake_string = cmake_string+"-DSHARED=ON "
	cmake_string = cmake_string.replace("  "," ")
	const app_path = DKBuild_FindAppPath(APP)
	
	////// WIN x86 /////
	if(OS === "win32"){
		DKBuild_ValidateVC2019()
		CPP_DKFile_MkDir(app_path+OS)
		if(!DKBuild_Command(CMAKE+" -G \""+VS_GENERATOR+"\" -A Win32 "+cmake_string+" -S"+DIGITALKNOB+"DK/DKCMake -B"+app_path+OS))
			return false
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Debug"))
				return false
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Release"))
				return false
		}
	}
	
	////// WIN x86_64 /////
	if(OS === "win64"){
		DKBuild_ValidateVC2019()
		CPP_DKFile_MkDir(app_path+OS)
		if(!DKBuild_Command(CMAKE+" -G \""+VS_GENERATOR+"\" -A x64 "+cmake_string+" -S"+DIGITALKNOB+"DK/DKCMake -B"+app_path+OS))
			return false

		if(TYPE === "Debug" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Debug"))
				return false
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Release"))
				return false
		}
	}
	
	///// MAC32 ////
	if(OS === "mac32"){
		//Copy from mac64
	}
	
	///// MAC x86_64 ////
	if(OS === "mac64"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(app_path+OS)
		if(!DKBuild_Command(CMAKE+" -G \"Xcode\" -T buildsystem=1 -DCMAKE_OSX_ARCHITECTURES=x86_64 "+cmake_string+" -S"+DIGITALKNOB+"DK/DKCMake -B"+app_path+OS))
			return false
		//CPP_DKFile_ChDir(app_path+OS)
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Debug"))	
				return false
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Release"))
				return false
		}
	}
	
	///// IOS_ARM32 ///////
	if(OS === "ios_arm32"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(app_path+OS)
		if(!DKBuild_Command(CMAKE+" -G \"Xcode\" "+cmake_string+" -DCMAKE_TOOLCHAIN_FILE="+DIGITALKNOB+"DK/DKCMake/ios.toolchain.cmake -DPLATFORM=OS -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 -S"+DIGITALKNOB+"DK/DKCMake -B"+app_path+OS))
			return false

		//CPP_DKFile_ChDir(app_path+OS)
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Debug"))	
				return false				
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Release"))
				return false
		}
	}
	
	///// IOS_ARM64 ///////
	if(OS === "ios_arm64"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(app_path+OS)
		if(!DKBuild_Command(CMAKE+" -G \"Xcode\" "+cmake_string+" -DCMAKE_TOOLCHAIN_FILE="+DIGITALKNOB+"DK/DKCMake/ios.toolchain.cmake -DPLATFORM=OS64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 -S"+DIGITALKNOB+"DK/DKCMake -B"+app_path+OS))
			return false
		//CPP_DKFile_ChDir(app_path+OS)
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Debug"))	
				return false
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Release"))
				return false
		}
	}
	
	///// IOSSIM32 //////
	if(OS === "iossim32"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(app_path+OS)
		if(!DKBuild_Command(CMAKE+" -G \"Xcode\" "+cmake_string+" -DCMAKE_TOOLCHAIN_FILE="+DIGITALKNOB+"DK/DKCMake/ios.toolchain.cmake -DPLATFORM=SIMULATOR -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 -S"+DIGITALKNOB+"DK/DKCMake -B"+app_path+OS))
			return false
		//CPP_DKFile_ChDir(app_path+OS)
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Debug"))	
				return false
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Release"))
				return false
		}
	}
	
	///// IOSSIM64 ///////
	if(OS === "iossim64"){
		DKBuild_ValidateXcode()
		if(!DKBuild_Command(CMAKE+" -G \"Xcode\" "+cmake_string+" -DCMAKE_TOOLCHAIN_FILE="+DIGITALKNOB+"DK/DKCMake/ios.toolchain.cmake -DPLATFORM=SIMULATOR64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 -S"+DIGITALKNOB+"DK/DKCMake -B"+app_path+OS))
			return false
		//CPP_DKFile_ChDir(app_path+OS)
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Debug"))	
				return false
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target "+APP+"_APP --config Release"))
				return false
		}
	}
	
	//////// LINUX,  RASPBERRY //////////////////////////////////////////////////////////////
	if(OS === "linux32" || OS === "linux64" || OS === "raspberry32" || OS === "raspberry64"){
		DKBuild_ValidateGcc()
		CPP_DKFile_MkDir(app_path+OS)
		if(TYPE === "Debug" || TYPE === "ALL"){
			cmake_string = cmake_string.replace("-DDEBUG=OFF", "-DDEBUG=ON");
			cmake_string = cmake_string.replace("-DRELEASE=ON", "-DRELEASE=OFF");
			CPP_DKFile_MkDir(app_path+OS+"/Debug")
			CPP_DKFile_ChDir(app_path+OS+"/Debug")
			if(!DKBuild_Command(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+""+DIGITALKNOB+"DK/DKCMake"))
				return false
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+"/Debug --target "+APP+"_APP --config Debug"))	
				return false
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			cmake_string = cmake_string.replace("-DDEBUG=ON", "-DDEBUG=OFF");
			cmake_string = cmake_string.replace("-DRELEASE=OFF", "-DRELEASE=ON");
			CPP_DKFile_MkDir(app_path+OS+"/Release")
			CPP_DKFile_ChDir(app_path+OS+"/Release")
			if(!DKBuild_Command(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+""+DIGITALKNOB+"DK/DKCMake"))
				return false
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+"/Release --target "+APP+"_APP --config Release"))
				return false
		}
	}
	
	////// ANDROID armeabi-v7a //////
	if(OS === "android_arm32"){
		DKBuild_ValidateNDK()
		DKBuild_ValidateVC2019()
		CPP_DKFile_MkDir(app_path+OS)
		const ANDROID_API = DKBuild_GetDKMakeVariable(DIGITALKNOB+"DK/DKCMake/DKBuildFlags.cmake", "ANDROID_API")
		
		if(CPP_DK_GetOS() === "Windows"){
			if(!DKBuild_Command(DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/openjdk/registerJDK.cmd"))
				return false
			if(!DKBuild_Command(CMAKE+" -G \""+VS_GENERATOR+"\" -A ARM -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM="+ANDROID_API+" -DANDROID-NDK="+ANDROID_NDK+" -DCMAKE_TOOLCHAIN_FILE="+ANDROID_NDK+"/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS=\"-std=c++1z -frtti -fexceptions\" -DCMAKE_ANDROID_STL_TYPE=c++_static "+cmake_string+" -S"+DIGITALKNOB+"DK/DKCMake -B"+app_path+"android_arm32"))
				return false
		}
		else{
			if(!DKBuild_Command(CMAKE+" -G \"Unix Makefiles\" -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM="+ANDROID_API+" -DANDROID-NDK="+ANDROID_NDK+" -DCMAKE_TOOLCHAIN_FILE="+ANDROID_NDK+"/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS=\"-std=c++1z -frtti -fexceptions\" -DCMAKE_ANDROID_STL_TYPE=c++_static "+cmake_string+" -S"+DIGITALKNOB+"DK/DKCMake -B"+app_path+"android_arm32"))
				return false
		}
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target main --config Debug"))	
				return false
		}
		else if(TYPE === "Release" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target main --config Release"))
				return false
		}
		
		/*
		if(CPP_DK_GetOS() === "Windows"){
			if(!DKBuild_Command(DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/openjdk/registerJDK.cmd"))
				return false
		}
		if(CPP_DK_GetOS() !== "Windows"){
			if(!DKBuild_Command("chmod 777 "+app_path+OS+"/gradlew"))
				return false;
		}
		if(!DKBuild_Command(app_path+OS+"/gradlew --project-dir "+app_path+OS+" --info clean build"))
			return false
		
		if(CPP_DK_GetOS() === "Windows"){
			if(!DKBuild_Command(app_path+OS+"/___Install.cmd"))
				return false
		}
		*/
	}
	
	////// ANDROID6 arm64-v8a/////
	if(OS === "android_arm64"){
		DKBuild_ValidateNDK()
		DKBuild_ValidateVC2019()
		CPP_DKFile_MkDir(app_path+OS)
		const ANDROID_API = DKBuild_GetDKMakeVariable(DIGITALKNOB+"DK/DKCMake/DKBuildFlags.cmake", "ANDROID_API")
		
		if(CPP_DK_GetOS() === "Windows"){
			if(!DKBuild_Command(DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/openjdk/registerJDK.cmd"))
				return false
		}
		if(CPP_DK_GetOS() === "Windows"){
			//if(!DKBuild_Command(CMAKE+" -G \""+VS_GENERATOR+"\" -A ARM64 -DCMAKE_C_COMPILER_WORKS=1 -DCMAKE_CXX_COMPILER_WORKS=1 -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=26 -DANDROID-NDK="+ANDROID_NDK+" -DCMAKE_TOOLCHAIN_FILE="+ANDROID_NDK+"/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS=-std=c++1z "+cmake_string+" -S"+DIGITALKNOB+"DK/DKCMake -B"+app_path+"android_arm64"))
			if(!DKBuild_Command(CMAKE+" -G \""+VS_GENERATOR+"\" -A ARM64 -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM="+ANDROID_API+" -DANDROID-NDK="+ANDROID_NDK+" -DCMAKE_TOOLCHAIN_FILE="+ANDROID_NDK+"/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS=\"-std=c++1z -frtti -fexceptions\" -DCMAKE_ANDROID_STL_TYPE=c++_static "+cmake_string+" -S"+DIGITALKNOB+"DK/DKCMake -B"+app_path+"android_arm64"))
				return false
		}
		else{
			if(!DKBuild_Command(CMAKE+" -G \"Unix Makefiles\" -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM="+ANDROID_API+" -DANDROID-NDK="+ANDROID_NDK+" -DCMAKE_TOOLCHAIN_FILE="+ANDROID_NDK+"/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS=\"-std=c++1z -frtti -fexceptions\" -DCMAKE_ANDROID_STL_TYPE=c++_static "+cmake_string+" -S"+DIGITALKNOB+"DK/DKCMake -B"+app_path+"android_arm64"))
				return false
		}
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target main --config Debug"))	
				return false
		}
		else if(TYPE === "Release" || TYPE === "ALL"){
			if(!DKBuild_Command(CMAKE+" --build "+app_path+OS+" --target main --config Release"))
				return false
		}
		
		/*
		if(CPP_DK_GetOS() === "Windows"){
			if(!DKBuild_Command(DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/openjdk/registerJDK.cmd"))
				return false
		}
		if(CPP_DK_GetOS() !== "Windows"){
			// FIXME: Setting JAVA_HOME not working on UNIX
			//if(!DKBuild_Command("chmod 777 "+DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/openjdk/registerJDK.sh"))
			//	return false;
			//if(!DKBuild_Command(DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/openjdk/registerJDK.sh"))
			//	return false
			if(!DKBuild_Command("chmod 777 "+app_path+OS+"/gradlew"))
				return false;
		}
		if(!DKBuild_Command(app_path+OS+"/gradlew --project-dir "+app_path+OS+" --info clean build"))
			return false
		if(CPP_DK_GetOS() === "Windows"){
			if(!DKBuild_Command(app_path+OS+"/___Install.cmd"))
				return false
		}
		*/
	}
	
	//////// EMSCRIPTEN //////////////////////////////////////////////////////////////
	if(OS === "emscripten"){
		const EMSDK = DIGITALKNOB+"/Development/3rdParty/emsdk-main"
		const EMSDK_ENV = EMSDK+"/emsdk_env"
		const EMSDK_TOOLCHAIN_FILE = EMSDK+"/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake"
		DKBuild_ValidateEMSDK()
		CPP_DKFile_MkDir(app_path+OS)
		if(TYPE === "Debug" || TYPE === "ALL"){
			cmake_string = cmake_string.replace("-DDEBUG=OFF", "-DDEBUG=ON");
			cmake_string = cmake_string.replace("-DRELEASE=ON", "-DRELEASE=OFF");
			CPP_DKFile_MkDir(app_path+OS+"/Debug")
			CPP_DKFile_ChDir(app_path+OS+"/Debug")
			if(CPP_DK_GetOS() === "Windows"){
				if(!DKBuild_Command(EMSDK_ENV+".bat & "+CMAKE+" -G \"MinGW Makefiles\" -DCMAKE_TOOLCHAIN_FILE=\""+EMSDK_TOOLCHAIN_FILE+"\" "+cmake_string+""+DIGITALKNOB+"DK/DKCMake"))
					return false
			}
			else{
				if(!DKBuild_Command(EMSDK_ENV+".sh & "+CMAKE+" -G \"Unix Makefiles\" -DCMAKE_TOOLCHAIN_FILE=\""+EMSDK_TOOLCHAIN_FILE+"\" "+cmake_string+""+DIGITALKNOB+"DK/DKCMake"))
					return false
			}
			if(CPP_DK_GetOS() === "Windows"){
				if(!DKBuild_Command(EMSDK_ENV+".bat & "+CMAKE+" --build "+app_path+OS+"/Debug --target "+APP+"_APP --config Debug"))	
					return false
			}
			else{
				if(!DKBuild_Command(EMSDK_ENV+".sh & "+CMAKE+" --build "+app_path+OS+"/Debug --target "+APP+"_APP --config Debug"))	
					return false
			}
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			cmake_string = cmake_string.replace("-DDEBUG=ON", "-DDEBUG=OFF");
			cmake_string = cmake_string.replace("-DRELEASE=OFF", "-DRELEASE=ON");
			CPP_DKFile_MkDir(app_path+OS+"/Release")
			CPP_DKFile_ChDir(app_path+OS+"/Release")
			if(CPP_DK_GetOS() === "Windows"){
				if(!DKBuild_Command(EMSDK_ENV+".bat & "+CMAKE+" -G \"MinGW Makefiles\" -DCMAKE_TOOLCHAIN_FILE=\""+EMSDK_TOOLCHAIN_FILE+"\" "+cmake_string+""+DIGITALKNOB+"DK/DKCMake"))
					return false
			}
			else{
				if(!DKBuild_Command(EMSDK_ENV+".sh & "+CMAKE+" -G \"Unix Makefiles\" -DCMAKE_TOOLCHAIN_FILE=\""+EMSDK_TOOLCHAIN_FILE+"\" "+cmake_string+""+DIGITALKNOB+"DK/DKCMake"))
					return false
			}
			if(CPP_DK_GetOS() === "Windows"){
				if(!DKBuild_Command(EMSDK_ENV+".bat & "+CMAKE+" --build "+app_path+OS+"/Release --target "+APP+"_APP --config Release"))
					return false
			}
			else{
				if(!DKBuild_Command(EMSDK_ENV+".sh & "+CMAKE+" --build "+app_path+OS+"/Release --target "+APP+"_APP --config Release"))
					return false
			}
		}
	}
	
	
	console.log("\n")
	console.log("********************************************")
	console.log("********************************************")
	console.log("   DONE BUILDING "+APP+" "+OS+" "+TYPE)
	console.log("********************************************")
	console.log("********************************************")
	
	/*
	if(CPP_DK_Available("DKAudio")){
		CPP_DK_Create("DKAudio")
	}
	if(CPP_DK_Valid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav")
	}
	*/
	
	//Refresh Icons on Windows
	//CPP_DK_Execute("ie4uinit.exe -ClearIconCache")
    //CPP_DK_Execute("ie4uinit.exe -show") //Windows 10
}

DKBuild_init()
