let USERNAME = CPP_DK_GetUsername()
if(!USERNAME){
	console.error("! could not get the current username !")
	USERNAME = "aquawicket"
	if(CPP_DK_GetOS() === "Raspberry")
		USERNAME = "pi"
}
console.log("username was set to: "+USERNAME)


function DKBuild_GetDKMakeVariable(file, variable){
	const str = CPP_DKFile_FileToString(file)
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

let OS = ""   //win32,win64,mac32,mac64,linux32,linux64,ios32,ios64,iossim32,iossim64,android32,android64,raspberry32,raspberry64 
let APP = ""  //DKAppname
let TYPE = ""  //Debug, Release, ALL
let LINK = ""  //Static, Dynamic
let LEVEL = ""  //Build, Rebuild, RebuildAll
let DKPATH = ""
let DKDOWNLOAD = ""
let CMAKE = ""
let NDK_VERSION = "r21e"
let NDK = ""
let VISUALSTUDIO_VERSION = "2019"
let VISUALSTUDIO = ""
let MSBUILD = ""
let GCC = ""
let XCODE = ""
let APP_LIST = []
 

function DKBuild_init(){
	CPP_DK_Create("DKCurl")
	CPP_DK_Create("DKArchive")

	if(CPP_DK_GetOS() === "Windows"){
		DKPATH = "C:/Users/"+USERNAME+"/digitalknob/"
		if(CPP_DK_GetOSArchitecture() === "32"){
			CMAKE = "C:/Program Files/CMake/bin/cmake.exe"
			VISUALSTUDIO = "C:/Program Files/Microsoft Visual Studio/"+VISUALSTUDIO_VERSION
		}
		if(CPP_DK_GetOSArchitecture() === "64"){
			CMAKE = "C:/Program Files (x86)/CMake/bin/cmake.exe"
			VISUALSTUDIO = "C:/Program Files (x86)/Microsoft Visual Studio/"+VISUALSTUDIO_VERSION
		}
		CMAKE = CPP_DKFile_GetShortName(CMAKE)
		MSBUILD = VISUALSTUDIO+"/Community/MSBuild/Current/Bin/MSBuild.exe"
		MSBUILD = CPP_DKFile_GetShortName(MSBUILD)
		NDK = DKPATH+"DK/3rdParty/android-ndk-"+NDK_VERSION+"-windows-x86_64"
		NDK = CPP_DKFile_GetShortName(NDK)
	}
	if(CPP_DK_GetOS() === "Mac"){
		DKPATH = "/Users/"+USERNAME+"/digitalknob/"
		CMAKE = "/Applications/CMake.app/Contents/bin/cmake"
		XCODE = "/Applications/Xcode.app"
		NDK = DKPATH+"DK/3rdParty/android-ndk-"+NDK_VERSION+"-darwin-x86_64"
	}
	if(CPP_DK_GetOS() === "Linux"){
		DKPATH = "/home/"+USERNAME+"/digitalknob/"
		CMAKE = "/usr/bin/cmake"
		GCC = "/usr/bin/g++"
		NDK = DKPATH+"DK/3rdParty/android-ndk-"+NDK_VERSION+"-linux-x86_64"
	}
	if(CPP_DK_GetOS() === "Raspberry"){
		DKPATH = "/home/"+USERNAME+"/digitalknob/"
		CMAKE = "/usr/bin/cmake"
		GCC = "/usr/bin/g++"
		NDK = DKPATH+"DK/3rdParty/android-ndk-"+NDK_VERSION+"-linux-x86_64"
	}
	DKDOWNLOAD = DKPATH+"DK/Download"
	//CPP_DKFile_MkDir(DKDOWNLOAD)
	if(!NDK_VERSION)
		NDK_VERSION = DKBuild_GetDKMakeVariable(DKPATH+"DK/3rdParty/_DKIMPORTS/android-ndk/DKMake.cmake", "NDK_VERSION")
}

//This is and alternative way to get windows short paths
function DKBuild_GetShortPath(fullPath){
	let getShortPath = DKPATH+"DK/DKPlugins/DKFile/getShortPath.cmd"
	let shortPath = CPP_DK_Execute(getShortPath+' "'+fullPath+'"')
	shortPath = shortPath.slice(0, -1)
	while(shortPath.includes("\\")){
		shortPath = shortPath.replace("\\","/")
	}
	return shortPath
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
	console.log("Looking for Visual Studio 2019")
	if(!CPP_DKFile_Exists(VISUALSTUDIO))
		DKBuild_InstallVC2019()
	if(CPP_DKFile_Exists(VISUALSTUDIO))
	console.log("Found Visual Studio 2019")
}

function DKBuild_InstallVC2019(){
	console.log("Installing Visual Studio 2019")
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
	CPP_DKCurl_Download("http://DigitalKnob.com/Download/Tools/xcode4630916281a.dmg", DKDOWNLOAD)
	//TODO - Install Xcode
}

function DKBuild_ValidateNDK(){
	console.log("Looking for Android NDK")
	if(!CPP_DKFile_Exists(NDK+"/installed"))
		DKBuild_InstallNDK()
	if(CPP_DKFile_Exists(NDK))
		console.log("Found NDK")
}

function DKBuild_InstallNDK(){
	console.log("Installing Android NDK")
	
	if(!NDK_VERSION)
		NDK_VERSION = DKBuild_GetDKMakeVariable("C:/Users/aquawicket/digitalknob/DK/3rdParty/_DKIMPORTS/android-ndk/DKMake.cmake", "NDK_VERSION")
			
	if(CPP_DK_GetOS() === "Windows"){
		console.log("Downloading NDK to "+DKDOWNLOAD)
		if(!CPP_DKFile_Exists(DKDOWNLOAD+"/android-ndk-"+NDK_VERSION+"-windows-x86_64.zip")){
			CPP_DKCurl_Download("https://dl.google.com/android/repository/android-ndk-"+NDK_VERSION+"-windows-x86_64.zip", DKDOWNLOAD)
		}
		CPP_DKArchive_Extract(DKDOWNLOAD+"/android-ndk-"+NDK_VERSION+"-windows-x86_64.zip", DKPATH+"DK/3rdParty")
		CPP_DKFile_Rename(DKPATH+"DK/3rdParty/android-ndk-"+NDK_VERSION, DKPATH+"DK/3rdParty/android-ndk-"+NDK_VERSION+"-windows-x86_64", true)
		CPP_DKFile_StringToFile("android-ndk-"+NDK_VERSION+"-windows-x86_64", DKPATH+"DK/3rdParty/android-ndk-"+NDK_VERSION+"-windows-x86_64/installed");
	}
	if(CPP_DK_GetOS() === "Mac"){
		CPP_DKCurl_Download("https://dl.google.com/android/repository/android-ndk-"+NDK_VERSION+"-darwin-x86_64.zip", DKDOWNLOAD)
		CPP_DKArchive_Extract(DKDOWNLOAD+"/android-ndk-"+NDK_VERSION+"-darwin-x86_64.zip", DKPATH+"DK/3rdParty")
		CPP_DKFile_Rename(DKPATH+"DK/3rdParty/android-ndk-"+NDK_VERSION, DKPATH+"DK/3rdParty/android-ndk-"+NDK_VERSION+"-darwin-x86_64", true)
	}
	if(CPP_DK_GetOS() === "Linux"){
		CPP_DKCurl_Download("https://dl.google.com/android/repository/android-ndk-"+NDK_VERSION+"-linux-x86_64.zip", DKDOWNLOAD)
		CPP_DKArchive_Extract(DKDOWNLOAD+"/android-ndk-"+NDK_VERSION+"-linux-x86_64.zip", DKPATH+"DK/3rdParty")
		CPP_DKFile_Rename(DKPATH+"DK/3rdParty/android-ndk-"+NDK_VERSION, DKPATH+"DK/3rdParty/android-ndk-"+NDK_VERSION+"-linux-x86_64", true)
	}
}

function DKBuild_OsCheck(){
	if(CPP_DK_GetOS() === "Windows"){
		if(CPP_DK_GetOSArchitecture() === "32"){
			if(OS === "win64"){
				console.error(OS+" can only be build from a WIN64 machine") 
				return false
			}
		}
		if(OS === "mac"){
			console.error(OS+" can only be build from an OSX machine") 
			return false
		}
		if(OS === "ios"){
			console.error(OS+" can only be build from an OSX machine") 
			return false
		}
		if(OS === "ios-simulator"){
			console.error(OS+" can only be build from an OSX machine") 
			return false
		}
		if(OS === "linux"){
			console.error(OS+" can only be build from a LINUX machine") 
			return false
		}
		if(OS === "raspberry"){
			console.error(OS+" can only be build from a Raspberry machine") 
			return false
		}
	}
	if(CPP_DK_GetOS() === "Mac"){
		if(OS === "win32"){
			console.error(OS+" can only be build from a Windows machine") 
			return false
		}
		if(OS === "win64"){
			console.error(OS+" can only be build from an Windows x64 machine") 
			return false
		}
		if(OS === "linux"){
			console.error(OS+" can only be build from a linux machine") 
			return false
		}
		if(OS === "linux32"){
			console.error(OS+" can only be build from a linux machine") 
			return false
		}
		if(OS === "linux64"){
			console.error(OS+" can only be build from a linux machine") 
			return false
		}
		if(OS === "raspberry"){
			console.error(OS+" can only be build from a Raspberry machine") 
			return false
		}
	}
	if(CPP_DK_GetOS() === "Linux"){
		if(OS === "win32"){
			console.error(OS+" can only be build from a Windows machine") 
			return false
		}
		if(OS === "win64"){
			console.error(OS+" can only be build from an WIN64 machine") 
			return false
		}
		if(OS === "mac"){
			console.error(OS+" can only be build from an OSX machine") 
			return false
		}
		if(OS === "ios"){
			console.error(OS+" can only be build from an OSX machine") 
			return false
		}
		if(OS === "ios-simulator"){
			console.error(OS+" can only be build from an OSX machine") 
			return false
		}
		if(OS === "raspberry"){
			console.error(OS+" can only be build from a Raspberry machine") 
			return false
		}
	}
	if(CPP_DK_GetOS() === "Raspberry"){
		if(OS === "win32"){
			console.error(OS+" can only be build from a Windows machine") 
			return false
		}
		if(OS === "win64"){
			console.error(OS+" can only be build from an WIN64 machine") 
			return false
		}
		if(OS === "mac"){
			console.error(OS+" can only be build from an OSX machine") 
			return false
		}
		if(OS === "ios"){
			console.error(OS+" can only be build from an OSX machine") 
			return false
		}
		if(OS === "ios-simulator"){
			console.error(OS+" can only be build from an OSX machine") 
			return false
		}
	}
	if(CPP_DK_GetOS() === "Android"){
		console.error("Android is not capable of compiling Apps..  please use a desktop system") 
		return false
	}
	if(CPP_DK_GetOS() === "iOS"){
		console.error("iOS is not capable of compiling Apps..  please use a desktop system") 
		return false
	}
	return true
}

function DKBuild_ResetAppsPlugins(){
	console.log("Deleting Apps and Plugins... ")
	
	// Delete everything in DKApps except DKBuild
	let apps = CPP_DKFile_DirectoryContents(DKPATH+"DK/DKApps")
	let list = apps.split(',')
	for(let i=0; i<list.length; ++i){
		if(list[i] === "DKBuilder"){ continue }
		CPP_DKFile_Delete(DKPATH+"DK/DKApps/"+list[i])
	}
	
	//Multipe user folders
	let contents = CPP_DKFile_DirectoryContents(DKPATH)
	let files = contents.split(",")
	for(let i=0; i<files.length; i++){
		let url = CPP_DKFile_GetSetting(files[i], "[MYGIT]")
		if(url){
			let folder = files[i].replace(".txt","")
			CPP_DKFile_Delete(DKPATH+folder)
		}
	}
	
	// Delete DKPlugins
	CPP_DKFile_Delete(DKPATH+"DK/DKPlugins")
}

function DKBuild_Reset3rdParty(){
	//TODO
	console.log("Deleting 3rdParty... ")
	console.log("Please wait. ")
	CPP_DKFile_Delete(DKPATH+"DK/3rdParty")
}

function DKBuild_GetAppList(){
	//DKApps folder
	let apps = CPP_DKFile_DirectoryContents(DKPATH+"DK/DKApps")
	if(!apps){ return }
	APP_LIST = apps.split(",")
	for(let i=0; i<APP_LIST.length; i++){
		if(!CPP_DKFile_IsDirectory(DKPATH+"DK/DKApps/"+APP_LIST[i]) || APP_LIST[i] === ".svn"){
			APP_LIST.splice(i, 1)
			i=0
		}
	}

	//User DKApps folders
	let contents = CPP_DKFile_DirectoryContents(DKPATH)
	let files = contents.split(",")
	for(let i=0; i<files.length; i++){ 
		if(files[i].indexOf(".txt") <=1){ continue }
		let url = CPP_DKFile_GetSetting(DKPATH+files[i], "[MYGIT]")
		if(url){ 
			let folder = files[i].replace(".txt","") 
			let apps2 = CPP_DKFile_DirectoryContents(DKPATH+folder+"/DKApps")
			if(apps2){
				let APP_LIST2 = apps2.split(",")
				for(let b=0; b<APP_LIST2.length; b++){
					if(!CPP_DKFile_IsDirectory(DKPATH+folder+"/DKApps/"+APP_LIST2[b]) || APP_LIST2[b] === ".svn" || APP_LIST2[b] === ".git"){
						APP_LIST2.splice(b, 1)
						b=0
					}
				}
				APP_LIST = APP_LIST.concat(APP_LIST2)
			}
		}
	}
}

function DKBuild_DoResults(){
	console.log("DKBuild_DoResults(): OS="+OS+" APP="+APP+" TYPE="+TYPE+" LEVEL="+LEVEL)
	if(!DKBuild_OsCheck()){ 
		console.log("DKBuild_OsCheck failed")
		return 
	}
	DKBuild_ValidateCmake()
	
	////// Create the cmake string
	let cmake_string = ""
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
	if(LINK === "Shared")
		cmake_string = cmake_string+"-DSHARED=ON "
	else
		cmake_string = cmake_string+"-DSTATIC=ON "
	
	let appdir = "DKApps"
	
	let contents = CPP_DKFile_DirectoryContents(DKPATH)
	let files = contents.split(",")
	for(let i=0; i<files.length; i++){ 
		if(CPP_DKFile_Exists(DKPATH+files[i]+"/DKApps/"+APP))
			appdir = files[i]+"/DKApps"
	}
	
	// NOTE: This was moved into DKCMake build scripts
	/*
	//// Create Icons
	if(CPP_DK_GetOS() === "Windows"){
		CPP_DK_Create("DKBuild/IconMaker.js")
		IconMaker_Create(DKPATH+appdir+"/"+APP)
	}
	*/
	
	////// WIN32 /////
	if(OS === "win32"){
		DKBuild_ValidateVC2019()
		if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
			CPP_DKFile_Delete(DKPATH+appdir+"/"+APP+"/win32/CMakeFiles")
			CPP_DKFile_Delete(DKPATH+appdir+"/"+APP+"/win32/"+APP+".dir")
			CPP_DKFile_Delete(DKPATH+appdir+"/"+APP+"/win32/Win32")
			CPP_DKFile_Delete(DKPATH+appdir+"/"+APP+"/win32/CMakeCache.txt")	
		}
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/win32")
		CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/win32")
		
		const command = CMAKE+" -G \"Visual Studio 16 2019\" -A Win32 "+cmake_string+DKPATH+"DK"
		console.log("COMMAND -->  "+command)
		let rtvalue = CPP_DK_Execute(command)
		if(rtvalue.indexOf("errors occurred!") > -1) 
			return
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DKFile_Rename(DKPATH+appdir+"/"+APP+"/"+OS+"/Debug/"+APP+".exe", DKPATH+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_old.exe", true)	
			CPP_DK_Execute(MSBUILD+" "+DKPATH+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Debug")
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DKFile_Rename(DKPATH+appdir+"/"+APP+"/"+OS+"/Release/"+APP+".exe", DKPATH+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_old.exe", true)
			CPP_DK_Execute(MSBUILD+" "+DKPATH+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Release")
		}
		
		//copy .pdb file to assets
		//CPP_DKFile_Copy(DKPATH+appdir+"/"+APP+"/"+OS+"/Release/"+APP+".pdb", DKPATH+appdir+"/"+APP+"/assets/"+APP+".pdb", true)
		
		//upx compress the exe file
		/*
		if(CPP_DKFile_Exists(DKPATH+"DK/3rdParty/upx-3.95-win64/upx.exe")){
			console.warn("UPX compressing exe... please wait")
			CPP_DK_Execute(DKPATH+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+DKPATH+appdir+"/"+APP+"/win32/Release/"+APP+".exe")
		}
		else
			console.warn("DKBuild_DoResults(): UPX does not exists")
		*/
	}
	
	////// WIN64 /////
	if(OS === "win64"){
		DKBuild_ValidateVC2019()
		if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
			CPP_DKFile_Delete(DKPATH+appdir+"/"+APP+"/win64/CMakeFiles")
			CPP_DKFile_Delete(DKPATH+appdir+"/"+APP+"/win64/"+APP+".dir")
			CPP_DKFile_Delete(DKPATH+appdir+"/"+APP+"/win64/Win32")
			CPP_DKFile_Delete(DKPATH+appdir+"/"+APP+"/win64/CMakeCache.txt")
		}
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/win64")
		CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/win64")
		let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Visual Studio 16 2019\" -A x64 "+cmake_string+DKPATH+"DK")
		if(rtvalue.indexOf("errors occurred!") > -1) 
			return
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DKFile_Rename(DKPATH+appdir+"/"+APP+"/"+OS+"/Debug/"+APP+"_64.exe", DKPATH+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_64_old.exe", true)
			CPP_DK_Execute(MSBUILD+" "+DKPATH+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Debug")
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DKFile_Rename(DKPATH+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_64.exe", DKPATH+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_64_old.exe", true)
			CPP_DK_Execute(MSBUILD+" "+DKPATH+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Release")
		}
		
		//copy .pdb file to assets
		//CPP_DKFile_Copy(DKPATH+appdir+"/"+APP+"/"+OS+"/Release/"+APP+".pdb", DKPATH+appdir+"/"+APP+"/assets/"+APP+".pdb", true)
		
		//upx compress the exe file
		/*
		if(CPP_DKFile_Exists(DKPATH+"3rdParty/upx-3.95-win64/upx.exe")){
			console.warn("UPX compressing exe... please wait")
			CPP_DK_Execute(DKPATH+"3rdParty/upx-3.95-win64/upx.exe -9 -v "+DKPATH+appdir+"/"+APP+"/win64/Release/"+APP+".exe")
		}
		else{
			console.warn("DKBuild_DoResults(): UPX does not exists")
		}
		*/
	}
	
	///// MAC32 ////
	if(OS === "mac32"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/mac32")
		CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/mac32")
		let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Xcode\" -DCMAKE_OSX_ARCHITECTURES=i386 "+cmake_string+DKPATH+"DK")
		if(rtvalue.indexOf("errors occurred!") > -1){ return }
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build")
			//update the info.plist in include the logo icon
			let info_plist = CPP_DKFile_FileToString(DKPATH+appdir+"/"+APP+"/mac32/Debug/"+APP+".app/Contents/info.plist")
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>")
			CPP_DKFile_StringToFile(info_plist, DKPATH+appdir+"/"+APP+"/mac32/Debug/"+APP+".app/Contents/info.plist")
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build")
			//update the info.plist in include the logo icon
			let info_plist = CPP_DKFile_FileToString(DKPATH+appdir+"/"+APP+"/mac32/Release/"+APP+".app/Contents/info.plist")
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>")
			CPP_DKFile_StringToFile(info_plist, DKPATH+appdir+"/"+APP+"/mac32/Release/"+APP+".app/Contents/info.plist")
			//update install_name_tool if cef present
			//TODO
		}
	}
	
	///// MAC64 ////
	if(OS === "mac64"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/mac64")
		CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/mac64")
		let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Xcode\" -DCMAKE_OSX_ARCHITECTURES=x86_64 "+cmake_string+DKPATH+"DK")
		if(rtvalue.indexOf("errors occurred!") > -1){ return }
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build")
			//update the info.plist in include the logo icon
			let info_plist = CPP_DKFile_FileToString(DKPATH+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/info.plist")
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>")
			CPP_DKFile_StringToFile(info_plist, DKPATH+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/info.plist")
			
			//update install_name_tool if cef present
			if(CPP_DKFile_Exists(DKPATH+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/Frameworks/Chromium Embedded Framework.framework")){
				console.log("USING CHROMIUM EMBEDDED FRAMEWORK")
				
				let command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\""
				console.log(command)
				CPP_DK_Execute(command)
				
				command = "install_name_tool -add_rpath \"@executable_path/../../../../\" \""+DKPATH+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\""
				console.log(command)
				CPP_DK_Execute(command)
				
				command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+"\""
				console.log(command)
				CPP_DK_Execute(command)
				
				command = "install_name_tool -add_rpath \"@executable_path/../\" \""+DKPATH+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/MacOS/"+APP+"\""
				console.log(command)
				CPP_DK_Execute(command)
			}
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build")
			
			//update the info.plist in include the logo icon
			let info_plist = CPP_DKFile_FileToString(DKPATH+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/info.plist")
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>")
			CPP_DKFile_StringToFile(info_plist, DKPATH+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/info.plist")
			
			//update install_name_tool if cef present
			if(CPP_DKFile_Exists(DKPATH+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/Frameworks/Chromium Embedded Framework.framework")){
				console.log("USING CHROMIUM EMBEDDED FRAMEWORK")
				
				let command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\""
				console.log(command)
				CPP_DK_Execute(command)
				
				command = "install_name_tool -add_rpath \"@executable_path/../../../../\" \""+DKPATH+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\""
				console.log(command)
				CPP_DK_Execute(command)
				
				command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+"\""
				console.log(command)
				CPP_DK_Execute(command)
				
				command = "install_name_tool -add_rpath \"@executable_path/../\" \""+DKPATH+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/MacOS/"+APP+"\""
				console.log(command)
				CPP_DK_Execute(command)
			}
		}
	}
	
	///// IOS32 ////
	if(OS === "ios32"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/ios32")
		CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/ios32")
		let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"DKCMake/iOS.cmake -DIOS_PLATFORM=OS "+DKPATH+"DK")
		if(rtvalue.indexOf("errors occurred!") > -1) 
			return 
		if(TYPE === "Debug" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -arch \"armv7 armv7s\"")
		if(TYPE === "Release" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build -arch \"armv7 armv7s\"")
	}
	
	///// IOS64 ////
	if(OS === "ios64"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/ios64")
		CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/ios64")
		let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"DKCMake/iOS.cmake -DIOS_PLATFORM=OS "+DKPATH+"DK")
		if(rtvalue.indexOf("errors occurred!") > -1)
			return
		if(TYPE === "Debug" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -arch \"armv7 armv7s\"")
		if(TYPE === "Release" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build -arch \"armv7 armv7s\"")
	}
	
	///// IOSSIM32 //////
	if(OS === "iossim32"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/iossim32")
		CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/iossim32")
		let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"DKCMake/iOS.cmake -DIOS_PLATFORM=SIMULATOR "+DKPATH+"DK")
		if(rtvalue.indexOf("errors occurred!") > -1) 
			return
		if(TYPE === "Debug" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -sdk iphonesimulator11.2")
		if(TYPE === "Release" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build -sdk iphonesimulator11.2")
	}
	
	///// IOSSIM64 //////
	if(OS === "iossim64"){
		DKBuild_ValidateXcode()
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/iossim64")
		CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/iossim64")
		let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"DKCMake/iOS.cmake -DIOS_PLATFORM=SIMULATOR64 "+DKPATH+"DK")
		if(rtvalue.indexOf("errors occurred!") > -1) 
			return
		if(TYPE === "Debug" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -sdk iphonesimulator11.2")
		if(TYPE === "Release" || TYPE === "ALL")
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build -sdk iphonesimulator11.2")
	}
	
	//// LINUX32 ///////
	if(OS === "linux32"){
		DKBuild_ValidateGcc()
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/linux32")
		CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/linux32")
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/linux32/Debug")
			CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/linux32/Debug")
			let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"DK")
			if(rtvalue.indexOf("errors occurred!") > -1) 
				return
			CPP_DK_Execute("make "+APP)
			
			//Create .desktop file
			let string = "[Desktop Entry]\n"
			string += "Encoding=UTF-8\n"
			string += "Version=1.0\n"
			string += "Type=Application\n"
			string += "Terminal=true\n"
			string += "Name="+APP+"\n"
			string += "Exec="+DKPATH+appdir+"/"+APP+"/linux32/Debug/"+APP+"\n"
			string += "Icon="+DKPATH+appdir+"/"+APP+"/icons/icon.png\n"
			CPP_DKFile_StringToFile(string, DKPATH+appdir+"/"+APP+"/linux32/Debug/"+APP+".desktop")
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/linux32/Release")
			CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/linux32/Release")
			let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"DK")
			if(rtvalue.indexOf("errors occurred!") > -1) 
				return
			CPP_DK_Execute("make "+APP)
			
			//Create .desktop file
			let string = "[Desktop Entry]\n"
			string += "Encoding=UTF-8\n"
			string += "Version=1.0\n"
			string += "Type=Application\n"
			string += "Terminal=true\n"
			string += "Name="+APP+"\n"
			string += "Exec="+DKPATH+appdir+"/"+APP+"/linux32/Release/"+APP+"\n"
			string += "Icon="+DKPATH+appdir+"/"+APP+"/icons/icon.png\n"
			CPP_DKFile_StringToFile(string, DKPATH+appdir+"/"+APP+"/linux32/Release/"+APP+".desktop")
		}
	}
	
	//// LINUX64 ///////
	if(OS === "linux64"){
		DKBuild_ValidateGcc()
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/linux64")
		CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/linux64")
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/linux64/Debug")
			CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/linux64/Debug")
			let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"DK")
			if(rtvalue.indexOf("errors occurred!") > -1) 
				return
			CPP_DK_Execute("make "+APP)

			//Create .desktop file
			let string = "[Desktop Entry]\n"
			string += "Encoding=UTF-8\n"
			string += "Version=1.0\n"
			string += "Type=Application\n"
			string += "Terminal=true\n"
			string += "Name="+APP+"\n"
			string += "Exec="+DKPATH+appdir+"/"+APP+"/linux64/Debug/"+APP+"\n"
			string += "Icon="+DKPATH+appdir+"/"+APP+"/icons/icon.png\n"
			CPP_DKFile_StringToFile(string, DKPATH+appdir+"/"+APP+"/linux64/Debug/"+APP+".desktop")
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/linux64/Release")
			CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/linux64/Release")
			let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"DK")
			if(rtvalue.indexOf("errors occurred!") > -1)
				return
			CPP_DK_Execute("make "+APP)
			
			//Create .desktop file
			let string = "[Desktop Entry]\n"
			string += "Encoding=UTF-8\n"
			string += "Version=1.0\n"
			string += "Type=Application\n"
			string += "Terminal=true\n"
			string += "Name="+APP+"\n"
			string += "Exec="+DKPATH+appdir+"/"+APP+"/linux64/Release/"+APP+"\n"
			string += "Icon="+DKPATH+appdir+"/"+APP+"/icons/icon.png\n"
			CPP_DKFile_StringToFile(string, DKPATH+appdir+"/"+APP+"/linux64/Release/"+APP+".desktop")
		}
	}
	
	//// RASPBERRY32 ///////
	if(OS === "raspberry32"){
		DKBuild_ValidateGcc()
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/raspberry32")
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/raspberry32/Debug")
			CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/raspberry32/Debug")
			let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"DK")
			if(rtvalue.indexOf("Error 1") > -1) 
				return
			if(rtvalue.indexOf("errors occurred!") > -1)
				return //FIXME: this doesn't catch all build errors
			CPP_DK_Execute("make "+APP)
			
			//Create .desktop file
			let string = "[Desktop Entry]\n"
			string += "Encoding=UTF-8\n"
			string += "Version=1.0\n"
			string += "Type=Application\n"
			string += "Terminal=true\n"
			string += "Name="+APP+"\n"
			string += "Exec="+DKPATH+appdir+"/"+APP+"/raspberry32/Debug/"+APP+"\n"
			string += "Icon="+DKPATH+appdir+"/"+APP+"/icons/icon.png\n"
			CPP_DKFile_StringToFile(string, DKPATH+appdir+"/"+APP+"/linux32/Debug/"+APP+".desktop")
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/raspberry32/Release")
			CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/raspberry32/Release")
			let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"DK")
			if(rtvalue.indexOf("errors occurred!") > -1)
				return //FIXME: this doesn't catch all build errors
			CPP_DK_Execute("make "+APP)
			
			//Create .desktop file
			let string = "[Desktop Entry]\n"
			string += "Encoding=UTF-8\n"
			string += "Version=1.0\n"
			string += "Type=Application\n"
			string += "Terminal=true\n"
			string += "Name="+APP+"\n"
			string += "Exec="+DKPATH+appdir+"/"+APP+"/raspberry32/Release/"+APP+"\n"
			string += "Icon="+DKPATH+appdir+"/"+APP+"/icons/icon.png\n"
			CPP_DKFile_StringToFile(string, DKPATH+appdir+"/"+APP+"/raspberry32/Release/"+APP+".desktop")
		}
	}
	
	//// RASPBERRY64 ///////
	if(OS === "linux64"){
		DKBuild_ValidateGcc()
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/raspberry64")
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/raspberry64/Debug")
			CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/raspberry64/Debug")
			let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"DK")
			if(rtvalue.indexOf("errors occurred!") > -1) 
				return //FIXME: this doesn't catch all build errors
			CPP_DK_Execute("make "+APP)

			//Create .desktop file
			let string = "[Desktop Entry]\n"
			string += "Encoding=UTF-8\n"
			string += "Version=1.0\n"
			string += "Type=Application\n"
			string += "Terminal=true\n"
			string += "Name="+APP+"\n"
			string += "Exec="+DKPATH+appdir+"/"+APP+"/raspberry64/Debug/"+APP+"\n"
			string += "Icon="+DKPATH+appdir+"/"+APP+"/icons/icon.png\n"
			CPP_DKFile_StringToFile(string, DKPATH+appdir+"/"+APP+"/raspberry64/Debug/"+APP+".desktop")
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/raspberry64/Release")
			CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/raspberry64/Release")
			let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"DK")
			if(rtvalue.indexOf("errors occurred!") > -1) 
				return  //FIXME: this doesn't catch all build errors
			CPP_DK_Execute("make "+APP)
			
			//Create .desktop file
			let string = "[Desktop Entry]\n"
			string += "Encoding=UTF-8\n"
			string += "Version=1.0\n"
			string += "Type=Application\n"
			string += "Terminal=true\n"
			string += "Name="+APP+"\n"
			string += "Exec="+DKPATH+appdir+"/"+APP+"/raspberry64/Release/"+APP+"\n"
			string += "Icon="+DKPATH+appdir+"/"+APP+"/icons/icon.png\n"
			CPP_DKFile_StringToFile(string, DKPATH+appdir+"/"+APP+"/raspberry64/Release/"+APP+".desktop")
		}
	}
	
	////// ANDROID32 /////
	if(OS === "android32"){
		DKBuild_ValidateNDK()
		DKBuild_ValidateVC2019()
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/android32")
		CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/android32")
		if(CPP_DK_GetOS() === "Windows")
			let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Visual Studio 16 2019\" -A ARM -DCMAKE_TOOLCHAIN_FILE="+NDK+"/build/cmake/android.toolchain.cmake -DANDROID_NDK="+NDK+" -DANDROID_ABI=armeabi-v7a -DANDROID_NATIVE_API_LEVEL=26 –DCMAKE_SYSTEM_NAME=ANDROID -DCMAKE_ANDROID_STL=c++_static "+cmake_string+DKPATH+"DK")
		if(CPP_DK_GetOS() === "Linux" || CPP_DK_GetOS() === "Mac")
			rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"DK")
		if(rtvalue.indexOf("errors occurred!") > -1) 
			return 
			
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/android32/Debug")
			CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/android32/Debug")
			//CPP_DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=1 NDKLOG=1")
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/android32/Release")
			CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/android32/Release")
			//CPP_DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=0 NDKLOG=1")
		}

	}
	
	////// ANDROID64 /////
	if(OS === "android64"){
		DKBuild_ValidateNDK()
		DKBuild_ValidateVC2019()
		CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/android64")
		CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/android64")
		if(CPP_DK_GetOS() === "Windows")
			let rtvalue = CPP_DK_Execute(CMAKE+" -G \"Visual Studio 16 2019\" -A ARM64 -DCMAKE_TOOLCHAIN_FILE="+NDK+"/build/cmake/android.toolchain.cmake -DANDROID_NDK="+NDK+" -DANDROID_ABI=arm64-v8a -DANDROID_NATIVE_API_LEVEL=24 –DCMAKE_SYSTEM_NAME=ANDROID "+cmake_string+DKPATH+"DK")
		if(CPP_DK_GetOS() === "Linux" || CPP_DK_GetOS() === "Mac")
			rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"DK")
		if(rtvalue.indexOf("errors occurred!") > -1) 
			return 
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/android64/Debug")
			CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/android64/Debug")
			//CPP_DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=1 NDKLOG=1")
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DKFile_MkDir(DKPATH+appdir+"/"+APP+"/android64/Release")
			CPP_DKFile_ChDir(DKPATH+appdir+"/"+APP+"/android64/Release")
			//CPP_DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=0 NDKLOG=1")
		}
	}
	
	
	
	console.log("\n")
	console.log("********************************************")
	console.log("********************************************")
	console.log("   DONE BUILDING "+APP+" "+OS)
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
