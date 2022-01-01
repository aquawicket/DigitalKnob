//CPP_DK_Execute("cmd /c echo press and key to continue && timeout /t 60 > nul") //Wait for key or 1 minute
let UPDATE = "" //allow the first screen to loop
let OS = ""   //win32,win64,mac32,mac64,linux32,linux64,ios32,ios64,iossim32,iossim64,android32,android64,raspberry32,raspberry64 
let APP = ""  //DKAppname
let TYPE = ""  //Debug, Release, ALL
let LINK = "Static" //, Dynamic
let LEVEL = ""  //Build, Rebuild, RebuildAll
let DIGITALKNOB = ""
let DKDOWNLOAD = ""
let CMAKE = ""
let ANDROIDNDK = ""  //filled by DKBuild_ValidateNDK()
//let VISUALSTUDIO_VERSION = "2019"
let VISUALSTUDIO_VERSION = "2022"
let VISUALSTUDIO = ""
//let VS_GENERATOR = "Visual Studio 16 2019"
let VS_GENERATOR = "Visual Studio 17 2022"
let MSBUILD = ""
let GCC = ""
let XCODE = ""
let APP_LIST = []

const USERNAME = CPP_DK_GetUsername()
if(!USERNAME){
	console.error("! could not get the current username !")
}
console.log("username was set to: "+USERNAME)

function DKBuild_GetDKMakeVariable(file, variable){
	const str = CPP_DKFile_FileToString(file)
	if(!str)
		return null;
	str = str.split("dkset(").join("set(")
	str = str.split("DKSET(").join("set(")
	str = str.split("SET(").join("set(")
	let index = str.indexOf("set("+variable+" ")
	let pos = index	
	let marker = 0
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
	
	DKDOWNLOAD = DIGITALKNOB+"Download"
	CPP_DKFile_MkDir(DKDOWNLOAD) //FIXME: code DKCurl to create directories automatically
}

function DKBuild_end(){
	CPP_DKFile_Copy(CPP_DKFile_GetExePath(), DIGITALKNOB+CPP_DKFile_GetExeName(), true)
}

//This is and alternative way to get windows short paths
function DKBuild_GetShortPath(fullPath){
	let getShortPath = DIGITALKNOB+"DK/DKPlugins/DKFile/getShortPath.cmd"
	let shortPath = CPP_DK_Execute(getShortPath+' "'+fullPath+'"')
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
    //GOAL: Eventually we'll use the DKMAKE.cmake script to install
	const ANDROIDNDK_BUILD = DKBuild_GetDKMakeVariable(DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/android-ndk/DKMAKE.cmake", "ANDROIDNDK_BUILD")
	const ANDROIDNDK_DL = DKBuild_GetDKMakeVariable(DIGITALKNOB+"DK/3rdParty/_DKIMPORTS/android-ndk/DKMAKE.cmake", "ANDROIDNDK_DL")
	ANDROIDNDK = DIGITALKNOB+"DK/3rdParty/android-sdk/ndk/"+ANDROIDNDK_BUILD
	
	//set environment variables
	if(ANDROIDNDK !== CPP_DK_Execute("echo %VS_NdkRoot%", "rt"))
		CPP_DK_Execute("setx VS_NdkRoot "+ANDROIDNDK) //https://stackoverflow.com/a/54350289/688352
		
	// Validate install
	if(!CPP_DKFile_Exists(ANDROIDNDK+"/installed")){
		console.log("Installing Android NDK "+ANDROIDNDK_BUILD+" . . .")
		CPP_DKCurl_Download(ANDROIDNDK_DL, DKDOWNLOAD)
		const index = ANDROIDNDK_DL.lastIndexOf("/")
		const filename = ANDROIDNDK_DL.substring(index+1)
		CPP_DKArchive_Extract(DKDOWNLOAD+"/"+filename, DIGITALKNOB+"DK/3rdParty/android-sdk/ndk")
		CPP_DKFile_Rename(DIGITALKNOB+"DK/3rdParty/android-sdk/ndk/android-ndk-r22b", ANDROIDNDK, true)
		CPP_DKFile_StringToFile(ANDROIDNDK_BUILD, ANDROIDNDK+"/installed")
	}
}

function DKBuild_ResetAppsPlugins(){
	console.log("Deleting Apps and Plugins... ")
	
	// Delete everything in DKApps except DKBuild
	let apps = CPP_DKFile_DirectoryContents(DIGITALKNOB+"DK/DKApps")
	if(!apps)
		console.error("DKBuild_ResetAppsPlugins(): apps invalid")
	let list = apps.split(',')
	for(let i=0; i<list.length; ++i){
		if(list[i] === "DKBuilder"){ continue }
		CPP_DKFile_Delete(DIGITALKNOB+"DK/DKApps/"+list[i])
	}
	
	//Multipe user folders
	let contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
	let files = contents.split(",")
	for(let i=0; i<files.length; i++){
		if(files[i].indexOf(".txt") <=1){ continue }
		let url = CPP_DKFile_GetSetting(files[i], "[MYGIT]")
		if(url){
			let folder = files[i].replace(".txt","")
			CPP_DKFile_Delete(DIGITALKNOB+folder)
		}
	}
	
	// Delete DKPlugins
	CPP_DKFile_Delete(DIGITALKNOB+"DK/DKPlugins")
}

function DKBuild_Reset3rdParty(){
	//TODO
	console.log("Deleting 3rdParty... ")
	console.log("Please wait. ")
	CPP_DKFile_Delete(DIGITALKNOB+"DK/3rdParty")
}

function DKBuild_GetAppList(){
	
	APP_LIST = []
	let contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
	let items = contents.split(",")
	for(let i=0; i<items.length; i++){
		if(CPP_DKFile_Exists(DIGITALKNOB+items[i]+"/DKApps")){
		if(CPP_DKFile_IsDirectory(DIGITALKNOB+items[i]+"/DKApps")){
			let dkApps = CPP_DKFile_DirectoryContents(DIGITALKNOB+items[i]+"/DKApps")
			let dkAppsArray = dkApps.split(",")
			for(let nn=0; nn < dkAppsArray.length; nn++){
				if(CPP_DKFile_Exists(DIGITALKNOB+items[i]+"/DKApps/"+dkAppsArray[nn]+"/DKMAKE.cmake")){
					APP_LIST.push(dkAppsArray[nn])
				}
			}
		}
		}
	}
}

function DKBuild_FindAppPath(name){
	let contents = CPP_DKFile_DirectoryContents(DIGITALKNOB)
	let files = contents.split(",")
	for(let i=0; i<files.length; i++){ 
		if(CPP_DKFile_Exists(DIGITALKNOB+files[i]+"/DKApps/"+name+"/DKMAKE.cmake"))
			return DIGITALKNOB+files[i]+"/DKApps/"+name+"/"
	}
	return 0;
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
	let cmake_string = ""
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
	
	////// WIN32 /////
	if(OS === "win32"){
		DKBuild_ValidateVC2019()
		CPP_DKFile_MkDir(app_path+OS)
		CPP_DKFile_ChDir(app_path+OS)
		const cmake_command = CMAKE+" -G \""+VS_GENERATOR+"\" -A Win32 "+cmake_string+DIGITALKNOB+"DK/DKCMake"
		console.log(cmake_command)
		let rtvalue = CPP_DK_Execute(cmake_command)
		if(TYPE === "Debug" || TYPE === "ALL")
			CPP_DK_Execute(MSBUILD+" "+app_path+OS+"/"+APP+".sln /p:Configuration=Debug")
		if(TYPE === "Release" || TYPE === "ALL")
			CPP_DK_Execute(MSBUILD+" "+app_path+OS+"/"+APP+".sln /p:Configuration=Release")
	}
	
	////// WIN64 /////
	if(OS === "win64"){
		DKBuild_ValidateVC2019()
		CPP_DKFile_MkDir(app_path+OS)
		CPP_DKFile_ChDir(app_path+OS)
		const cmake_command = CMAKE+" -G \""+VS_GENERATOR+"\" -A x64 "+cmake_string+DIGITALKNOB+"DK/DKCMake"
		console.log(cmake_command)
		let rtvalue = CPP_DK_Execute(cmake_command)
		if(TYPE === "Debug" || TYPE === "ALL")
			CPP_DK_Execute(MSBUILD+" "+app_path+OS+"/"+APP+".sln /p:Configuration=Debug")
		if(TYPE === "Release" || TYPE === "ALL")
			CPP_DK_Execute(MSBUILD+" "+app_path+OS+"/"+APP+".sln /p:Configuration=Release")
	}
	
	///// MAC32 ////
	if(OS === "mac32"){
		//Copy from mac64
	}
	
	///// MAC64 ////
	if(OS === "mac64"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(app_path+OS)
		CPP_DKFile_ChDir(app_path+OS)
		const cmake_command = CMAKE+" -G \"Xcode\" -DCMAKE_OSX_ARCHITECTURES=x86_64 "+cmake_string+DIGITALKNOB+"DK/DKCMake"
		console.log(cmake_command)
		let rtvalue = CPP_DK_Execute(cmake_command)
		if(TYPE === "Debug" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build")
		if(TYPE === "Release" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build")
	}
	
	///// IOS32 ////
	if(OS === "ios32"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(app_path+OS)
		CPP_DKFile_ChDir(app_path+OS)
		const cmake_command = CMAKE+" -G \"Xcode\" "+cmake_string+" -DCMAKE_TOOLCHAIN_FILE="+DIGITALKNOB+"DK/DKCMake/ios.toolchain.cmake -DIOS_PLATFORM=OS -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "+DIGITALKNOB+"DK/DKCMake"
		console.log(cmake_command)
		let rtvalue = CPP_DK_Execute(cmake_command)
		if(TYPE === "Debug" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build") //-arch \"armv7 armv7s\"")
		if(TYPE === "Release" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build") //-arch \"armv7 armv7s\"")
	}
	
	///// IOS64 ////
	if(OS === "ios64"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(app_path+OS)
		CPP_DKFile_ChDir(app_path+OS)
		const cmake_command = CMAKE+" -G \"Xcode\" "+cmake_string+" -DCMAKE_TOOLCHAIN_FILE="+DIGITALKNOB+"DK/DKCMake/ios.toolchain.cmake -DPLATFORM=OS64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "+DIGITALKNOB+"DK/DKCMake"
		console.log(cmake_command)
		let rtvalue = CPP_DK_Execute(cmake_command)
		if(TYPE === "Debug" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build")
		if(TYPE === "Release" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build")
	}
	
	///// IOSSIM32 //////
	if(OS === "iossim32"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(app_path+OS)
		CPP_DKFile_ChDir(app_path+OS)
		const cmake_command = CMAKE+" -G \"Xcode\" "+cmake_string+" -DCMAKE_TOOLCHAIN_FILE="+DIGITALKNOB+"DK/DKCMake/ios.toolchain.cmake -DIOS_PLATFORM=SIMULATOR -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "+DIGITALKNOB+"DK/DKCMake"
		console.log(cmake_command)
		let rtvalue = CPP_DK_Execute(cmake_command)
		if(TYPE === "Debug" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build")
		if(TYPE === "Release" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build")
	}
	
	///// IOSSIM64 //////
	if(OS === "iossim64"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(app_path+OS)
		CPP_DKFile_ChDir(app_path+OS)
		const cmake_command = (CMAKE+" -G \"Xcode\" "+cmake_string+" -DCMAKE_TOOLCHAIN_FILE="+DIGITALKNOB+"DK/DKCMake/ios.toolchain.cmake -DPLATFORM=SIMULATOR64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "+DIGITALKNOB+"DK/DKCMake")
		console.log(cmake_command)
		let rtvalue = CPP_DK_Execute(cmake_command)
		if(TYPE === "Debug" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build")
		if(TYPE === "Release" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build")
	}
	
	//// LINUX32 ///////
	if(OS === "linux32"){
		DKBuild_ValidateGcc()
		CPP_DKFile_MkDir(app_path+OS)
		CPP_DKFile_ChDir(app_path+OS)
		if(TYPE === "Debug" || TYPE === "ALL"){
			cmake_string = cmake_string.replace("-DDEBUG=OFF", "-DDEBUG=ON");
			cmake_string = cmake_string.replace("-DRELEASE=ON", "-DRELEASE=OFF");
			CPP_DKFile_MkDir(app_path+OS+"/Debug")
			CPP_DKFile_ChDir(app_path+OS+"/Debug")
			const cmake_command = CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DIGITALKNOB+"DK/DKCMake"
			console.log(cmake_command)
			let rtvalue = CPP_DK_Execute(cmake_command)
			CPP_DK_Execute("make "+APP)
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			cmake_string = cmake_string.replace("-DDEBUG=ON", "-DDEBUG=OFF");
			cmake_string = cmake_string.replace("-DRELEASE=OFF", "-DRELEASE=ON");
			CPP_DKFile_MkDir(app_path+OS+"/Release")
			CPP_DKFile_ChDir(app_path+OS+"/Release")
			const cmake_command = CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DIGITALKNOB+"DK/DKCMake"
			console.log(cmake_command)
			let rtvalue = CPP_DK_Execute(cmake_command)
			CPP_DK_Execute("make "+APP)
		}
	}
	
	//// LINUX64 ///////
	if(OS === "linux64"){
		DKBuild_ValidateGcc()
		CPP_DKFile_MkDir(app_path+OS)
		CPP_DKFile_ChDir(app_path+OS)
		if(TYPE === "Debug" || TYPE === "ALL"){
			cmake_string = cmake_string.replace("-DDEBUG=OFF", "-DDEBUG=ON");
			cmake_string = cmake_string.replace("-DRELEASE=ON", "-DRELEASE=OFF");
			console.log("cmake_string = "+cmake_string+"\n");
			CPP_DKFile_MkDir(app_path+OS+"/Debug")
			CPP_DKFile_ChDir(app_path+OS+"/Debug")
			const cmake_command = CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DIGITALKNOB+"DK/DKCMake"
			console.log(cmake_command)
			let rtvalue = CPP_DK_Execute(cmake_command)
			CPP_DK_Execute("make "+APP)
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			cmake_string = cmake_string.replace("-DDEBUG=ON", "-DDEBUG=OFF");
			cmake_string = cmake_string.replace("-DRELEASE=OFF", "-DRELEASE=ON");
			console.log("cmake_string = "+cmake_string+"\n");
			CPP_DKFile_MkDir(app_path+OS+"/Release")
			CPP_DKFile_ChDir(app_path+OS+"/Release")
			const cmake_command = CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DIGITALKNOB+"DK/DKCMake"
			console.log(cmake_command)
			let rtvalue = CPP_DK_Execute(cmake_command)
			CPP_DK_Execute("make "+APP)
		}
	}
	
	//// RASPBERRY32 ///////
	if(OS === "raspberry32"){
		DKBuild_ValidateGcc()
		CPP_DKFile_MkDir(app_path+OS)
		if(TYPE === "Debug" || TYPE === "ALL"){
			cmake_string = cmake_string.replace("-DDEBUG=OFF", "-DDEBUG=ON");
			cmake_string = cmake_string.replace("-DRELEASE=ON", "-DRELEASE=OFF");
			CPP_DKFile_MkDir(app_path+OS+"/Debug")
			CPP_DKFile_ChDir(app_path+OS+"/Debug")
			const cmake_command = CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DIGITALKNOB+"DK/DKCMake"
			console.log(cmake_command)
			let rtvalue = CPP_DK_Execute(cmake_command)
			CPP_DK_Execute("make "+APP)
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			cmake_string = cmake_string.replace("-DDEBUG=ON", "-DDEBUG=OFF");
			cmake_string = cmake_string.replace("-DRELEASE=OFF", "-DRELEASE=ON");
			CPP_DKFile_MkDir(app_path+OS+"/Release")
			CPP_DKFile_ChDir(app_path+OS+"/Release")
			const cmake_command = CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DIGITALKNOB+"DK/DKCMake"
			console.log(cmake_command)
			let rtvalue = CPP_DK_Execute(cmake_command)
			CPP_DK_Execute("make "+APP)
		}
	}
	
	//// RASPBERRY64 ///////
	if(OS === "raspberry64"){
		DKBuild_ValidateGcc()
		CPP_DKFile_MkDir(app_path+OS)
		if(TYPE === "Debug" || TYPE === "ALL"){
			cmake_string = cmake_string.replace("-DDEBUG=OFF", "-DDEBUG=ON");
			cmake_string = cmake_string.replace("-DRELEASE=ON", "-DRELEASE=OFF");
			CPP_DKFile_MkDir(app_path+OS+"/Debug")
			CPP_DKFile_ChDir(app_path+OS+"/Debug")
			const cmake_command = CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DIGITALKNOB+"DK/DKCMake"
			console.log(cmake_command);
			let rtvalue = CPP_DK_Execute(cmake_command)
			CPP_DK_Execute("make "+APP)
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			cmake_string = cmake_string.replace("-DDEBUG=ON", "-DDEBUG=OFF");
			cmake_string = cmake_string.replace("-DRELEASE=OFF", "-DRELEASE=ON");
			CPP_DKFile_MkDir(app_path+OS+"/Release")
			CPP_DKFile_ChDir(app_path+OS+"/Release")
			const cmake_command = CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DIGITALKNOB+"DK/DKCMake"
			console.log(cmake_command);
			let rtvalue = CPP_DK_Execute(cmake_command)
			CPP_DK_Execute("make "+APP)
		}
	}
	
	////// ANDROID32 /////
	if(OS === "android32"){
		DKBuild_ValidateNDK()
		DKBuild_ValidateVC2019()
		CPP_DKFile_MkDir(app_path+"android32")
		CPP_DKFile_ChDir(app_path+"android32")
		if(CPP_DK_GetOS() === "Windows"){
			const cmake_command = CMAKE+" -G \""+VS_GENERATOR+"\" -A ARM -DCMAKE_TOOLCHAIN_FILE="+ANDROIDNDK+"/build/cmake/android.toolchain.cmake -DANDROIDNDK="+ANDROIDNDK+" -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=26 -DCMAKE_CXX_FLAGS=-std=c++1z "+cmake_string+DIGITALKNOB+"DK/DKCMake"
			console.log(cmake_command)
			let rtvalue = CPP_DK_Execute(cmake_command)
		}
		else if(CPP_DK_GetOS() === "Linux" || CPP_DK_GetOS() === "Mac")
			let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DIGITALKNOB+"DK/DKCMake")
		if(TYPE === "Debug" || TYPE === "ALL")
			CPP_DK_Execute(MSBUILD+" "+app_path+OS+"/"+APP+".sln /p:Configuration=Debug")
		if(TYPE === "Release" || TYPE === "ALL")
			CPP_DK_Execute(MSBUILD+" "+app_path+OS+"/"+APP+".sln /p:Configuration=Release")
		/*
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DKFile_MkDir(app_path+"android32/Debug")
			CPP_DKFile_ChDir(app_path+"android32/Debug")
			//CPP_DK_Execute(ANDROIDNDK+"/ndk-build.cmd NDK_DEBUG=1 NDKLOG=1")
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DKFile_MkDir(app_path+"android32/Release")
			CPP_DKFile_ChDir(app_path+"android32/Release")
			//CPP_DK_Execute(ANDROIDNDK+"/ndk-build.cmd NDK_DEBUG=0 NDKLOG=1")
		}
		*/
	}
	
	////// ANDROID64 /////
	if(OS === "android64"){
		DKBuild_ValidateNDK()
		DKBuild_ValidateVC2019()
		CPP_DKFile_MkDir(app_path+"android64")
		CPP_DKFile_ChDir(app_path+"android64")
		if(CPP_DK_GetOS() === "Windows"){
			const cmake_command = CMAKE+" -G \""+VS_GENERATOR+"\" -A ARM64 -DCMAKE_TOOLCHAIN_FILE="+ANDROIDNDK+"/build/cmake/android.toolchain.cmake -DANDROIDNDK="+ANDROIDNDK+" -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=26 -DCMAKE_CXX_FLAGS=-std=c++1z "+cmake_string+DIGITALKNOB+"DK/DKCMake"
			console.log(cmake_command)
			let rtvalue = CPP_DK_Execute(cmake_command)
		}
		else if(CPP_DK_GetOS() === "Linux" || CPP_DK_GetOS() === "Mac")
			rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DIGITALKNOB+"DK/DKCMake")
		if(TYPE === "Debug" || TYPE === "ALL")
			CPP_DK_Execute(MSBUILD+" "+app_path+OS+"/"+APP+".sln /p:Configuration=Debug")
		if(TYPE === "Release" || TYPE === "ALL")
			CPP_DK_Execute(MSBUILD+" "+app_path+OS+"/"+APP+".sln /p:Configuration=Release")
		/*
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DKFile_MkDir(app_path+"android64/Debug")
			CPP_DKFile_ChDir(app_path+"android64/Debug")
			//CPP_DK_Execute(ANDROIDNDK+"/ndk-build.cmd NDK_DEBUG=1 NDKLOG=1")
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DKFile_MkDir(app_path+"android64/Release")
			CPP_DKFile_ChDir(app_path+"android64/Release")
			//CPP_DK_Execute(ANDROIDNDK+"/ndk-build.cmd NDK_DEBUG=0 NDKLOG=1")
		}
		*/
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
