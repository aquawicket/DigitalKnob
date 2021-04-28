/*
	Git should be extracted from this to it's own plugin.
	Also, git credential memory should be added.
*/

var OS = "";   //win32,win64,mac32,mac64,linux32,linux64,ios32,ios64,iossim32,iossim64,android32,android64,raspberry32,raspberry64 
var APP = "";  //DKAppname
var TYPE = "";  //Debug, Release, ALL
var LINK = "";  //Static, Dynamic
var LEVEL = "";  //Build, Rebuild, RebuildAll
var DKPATH = "";
var CMAKE = "";
var NDK = "";
var NDK_NAME = "android-ndk-r21e";
var VC2019 = "C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/MSBuild/Current/Bin/MSBuild.exe";
VC2019 = CPP_DKFile_GetShortName(VC2019);
//VC2019 = DKBuild_GetShortPath(VC2019);
var GCC = "/usr/bin/g++";
var XCODE = "/Applications/Xcode.app";
var APP_LIST = [];


///////////////////////
function DKBuild_init()()
{
	CPP_DK_Create("DKCurl");

	if(CPP_DK_GetOS() === "Win32"){
		DKPATH = "C:/digitalknob";
		CMAKE = "C:/Program Files/CMake/bin/cmake.exe";
		CMAKE = CPP_DKFile_GetShortName(CMAKE);
		NDK = DKPATH+"/DK/3rdParty/"+NDK_NAME;
		NDK = CPP_DKFile_GetShortName(NDK);
	}
	if(CPP_DK_GetOS() === "Win64"){
		DKPATH = "C:/digitalknob";
		CMAKE = "C:/Program Files (x86)/CMake/bin/cmake.exe";
		CMAKE = CPP_DKFile_GetShortName(CMAKE);
		NDK = DKPATH+"/DK/3rdParty/"+NDK_NAME;
		NDK = CPP_DKFile_GetShortName(NDK);
	}
	if(CPP_DK_GetOS() === "Mac"){
		DKPATH = "/Users/aquawicket/Desktop/digitalknob";
		CMAKE = "/Applications/CMake.app/Contents/bin/cmake";
		NDK = DKPATH+"/DK/3rdParty/"+NDK_NAME;
	}
	if(CPP_DK_GetOS() === "Linux"){
		DKPATH = "/home/pi/Desktop/digitalknob"; //FIXME: Need to dynamically get username (pi)
		CMAKE = "/usr/bin/cmake";
		NDK = DKPATH+"/DK/3rdParty/"+NDK_NAME;
	}
	if(CPP_DK_GetOS() === "Raspberry"){
		DKPATH = "/home/pi/Desktop/digitalknob"; //FIXME: Need to dynamically get username (pi)
		CMAKE = "/usr/bin/cmake";
		NDK = DKPATH+"/DK/3rdParty/"+NDK_NAME;
	}
}

//////////////////////
function DKBuild_end()()
{
	
}

//This is and alternative way to get windows short paths
////////////////////////////////////////
function DKBuild_GetShortPath(fullPath){
	var local_assets = CPP_DKAssets_LocalAssets();
	var getShortPath = local_assets+"/DKFile/getShortPath.cmd";
	var shortPath = CPP_DK_Execute(getShortPath+' "'+fullPath+'"');
	shortPath = shortPath.slice(0, -1)
	while(shortPath.includes("\\")){
		shortPath = shortPath.replace("\\","/");
	}
	return shortPath;
}

////////////////////////////////
function DKBuild_ValidateCmake()
{
	if(CPP_DK_GetBrowser() !== "RML"){ return; }
	console.log("Looking for CMake");
	if(!CPP_dk.file.extist(CMAKE)){
		console.log("Please install CMake");
		DKBuild_InstallCmake();
	}
	console.log("Found CMake");
	if(CPP_DK_GetOS() === "Mac"){
		CMAKE = "cmake";
	}
}

///////////////////////////////
function DKBuild_InstallCmake()
{
	console.log("Installing CMake");
	//var datapath = DKAssets_LocalAssets(); //FIXME: why did this stop working?
	var datapath = CPP_DKAssets_LocalAssets();
	
	if(CPP_DK_GetOS() === "Win32"){
		if(!CPP_dk.file.extist(datapath+"/cmake-3.19.4-win32-x86.msi")){
			CPP_DKCurl_Download("https://cmake.org/files/v3.19/cmake-3.19.4-win32-x86.msi", datapath);
		}
		CPP_DK_System(datapath+"/cmake-3.19.4-win32-x86.msi");
	}
	else if(CPP_DK_GetOS() === "Win64"){
		if(!CPP_dk.file.extist(datapath+"/cmake-3.19.4-win32-x86.msi")){
			CPP_DKCurl_Download("https://cmake.org/files/v3.19/cmake-3.19.4-win32-x86.msi", datapath);
		}
		CPP_DK_System(datapath+"/cmake-3.19.4-win32-x86.msi");
	}
	else if(CPP_DK_GetOS() === "Mac"){
		//TODO
	}
	else if(CPP_DK_GetOS() === "Linux"){
		CPP_DK_Execute("sudo apt-get install cmake");
	}
	else if(CPP_DK_GetOS() === "Raspberry"){
		CPP_DK_Execute("sudo apt-get install cmake");
	}
	else{
		console.log("ERROR: unrecognied HOST OS: "+CPP_DK_GetOS());
	}
}

/////////////////////////////////
function DKBuild_ValidateVC2019()
{
	if(CPP_DK_GetBrowser() !== "RML"){ return; }
	if(CPP_DK_GetOS() !== "Win32" && CPP_DK_GetOS() !== "Win64"){
		return;
	}
	console.log("Looking for Visual Studio 2019");
	if(!CPP_dk.file.extist(VC2019)){
		DKBuild_InstallVC2019();
	}
	console.log("Found Visual Studio 2019");
}

////////////////////////////////
function DKBuild_InstallVC2019()
{
	console.log("Installing Visual Studio 2019");
	var datapath = CPP_DKAssets_LocalAssets();
	
	CPP_DKCurl_Download("https://download.visualstudio.microsoft.com/download/pr/5e397ebe-38b2-4e18-a187-ac313d07332a/169156e6e9a005d49b357c42240184dc1e3ccc28ebc777e70d49257c074f77e8/vs_Community.exe", datapath);
	CPP_DK_System(datapath+"/vs_Community.exe");
}

//////////////////////////////
function DKBuild_ValidateGcc()
{
	if(CPP_DK_GetOS() !== "Linux" && CPP_DK_GetOS() !== "Raspberry"){ return; }
	if(CPP_DK_GetBrowser() !== "RML"){ return; }
	console.log("Looking for GCC");
	if(!CPP_dk.file.extist(GCC)){
		console.log("Please install GCC");
		DKBuild_InstallGcc();
	}
	console.log("Found Gcc");
}

/////////////////////////////
function DKBuild_InstallGcc()
{
	console.log("Installing Gcc");
	CPP_DK_Execute("sudo apt-get update && sudo apt-get install build-essential");
}

////////////////////////////////
function DKBuild_ValidateXcode()
{
	if(CPP_DK_GetOS() !== "Mac"){ return; }
	if(CPP_DK_GetBrowser() !== "RML"){ return; }
	console.log("Looking for Xcode");
	if(!CPP_dk.file.extist(XCODE)){
		console.log("Please install Xcode");
		DKBuild_InstallXcode();
	}
	console.log("Found Xcode");
}
///////////////////////////////
function DKBuild_InstallXcode()
{
	console.log("Installing Xcode");
	var datapath = DKAssets_LocalAssets();
	CPP_DKCurl_Download("http://DigitalKnob.com/Download/Tools/xcode4630916281a.dmg", datapath);
}

//////////////////////////
function DKBuild_OsCheck()
{
	if(CPP_DK_GetOS() === "Win32"){
		if(OS === "win64"){
			console.error(OS+" can only be build from a WIN64 machine"); return false;
		}
		if(OS === "mac"){
			console.error(OS+" can only be build from an OSX machine"); return false;
		}
		if(OS === "ios"){
			console.error(OS+" can only be build from an OSX machine"); return false;
		}
		if(OS === "ios-simulator"){
			console.error(OS+" can only be build from an OSX machine"); return false;
		}
		if(OS === "linux"){
			console.error(OS+" can only be build from a LINUX machine"); return false;
		}
		if(OS === "raspberry"){
			console.error(OS+" can only be build from a Raspberry machine"); return false;
		}
	}
	if(CPP_DK_GetOS() === "Win64"){
		if(OS === "mac"){
			console.error(OS+" can only be build from an OSX machine"); return false;
		}
		if(OS === "ios"){
			console.error(OS+" can only be build from an OSX machine"); return false;
		}
		if(OS === "ios-simulator"){
			console.error(OS+" can only be build from an OSX machine"); return false;
		}
		if(OS === "linux"){
			console.error(OS+" can only be build from a LINUX machine"); return false;
		}
		if(OS === "raspberry"){
			console.error(OS+" can only be build from a Raspberry machine"); return false;
		}
	}
	if(CPP_DK_GetOS() === "Mac"){
		if(OS === "win32"){
			console.error(OS+" can only be build from a Windows machine"); return false;
		}
		if(OS === "win64"){
			console.error(OS+" can only be build from an WIN64 machine"); return false;
		}
		if(OS === "linux"){
			console.error(OS+" can only be build from a linux machine"); return false;
		}
		if(OS === "linux32"){
			console.error(OS+" can only be build from a linux machine"); return false;
		}
		if(OS === "linux64"){
			console.error(OS+" can only be build from a linux machine"); return false;
		}
		//if(OS === "andoroid"){
		//	console.error(OS+" can only be build from a Windows machine"); return false;
		//}
		if(OS === "raspberry"){
			console.error(OS+" can only be build from a Raspberry machine"); return false;
		}
	}
	if(CPP_DK_GetOS() === "Linux"){
		if(OS === "win32"){
			console.error(OS+" can only be build from a Windows machine"); return false;
		}
		if(OS === "win64"){
			console.error(OS+" can only be build from an WIN64 machine"); return false;
		}
		if(OS === "mac"){
			console.error(OS+" can only be build from an OSX machine"); return false;
		}
		if(OS === "ios"){
			console.error(OS+" can only be build from an OSX machine"); return false;
		}
		if(OS === "ios-simulator"){
			console.error(OS+" can only be build from an OSX machine"); return false;
		}
		//if(OS === "andoroid"){
		//	console.error(OS+" can only be build from a Windows machine"); return false;
		//}
		if(OS === "raspberry"){
			console.error(OS+" can only be build from a Raspberry machine"); return false;
		}
	}
	if(CPP_DK_GetOS() === "Raspberry"){
		if(OS === "win32"){
			console.error(OS+" can only be build from a Windows machine"); return false;
		}
		if(OS === "win64"){
			console.error(OS+" can only be build from an WIN64 machine"); return false;
		}
		if(OS === "mac"){
			console.error(OS+" can only be build from an OSX machine"); return false;
		}
		if(OS === "ios"){
			console.error(OS+" can only be build from an OSX machine"); return false;
		}
		if(OS === "ios-simulator"){
			console.error(OS+" can only be build from an OSX machine"); return false;
		}
		//if(OS === "andoroid"){
		//	console.error(OS+" can only be build from a Windows machine"); return false;
		//}
	}
	if(CPP_DK_GetOS() === "Android"){
		console.error("Android is not capable of compiling DKApps..  please use a desktop system"); return false;
	}
	if(CPP_DK_GetOS() === "iOS"){
		console.error("iOS is not capable of compiling DKApps..  please use a desktop system"); return false;
	}
	return true;
}

///////////////////////////////////
function DKBuild_ResetAppsPlugins()
{
	console.log("Deleting Apps and Plugins... ");
	
	// Delete everything in DKApps except DKBuild
	var apps = CPP_DKFile_DirectoryContents(DKPATH+"/DKApps");
	var list = apps.split(',');
	for(var i=0; i<list.length; ++i){
		if(list[i] === "DKBuilder"){ continue; }
		//console.log("Deleting "+DKPATH+"/DKApps/"+list[i]);
		CPP_DKFile_Delete(DKPATH+"/DKApps/"+list[i]);
	}
	
	//Multipe user folders
	var contents = CPP_DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //console.log("files["+i+"] = "+files[i]);
		var url = CPP_DKFile_GetSetting(files[i], "[MYGIT]");
		if(url){ //console.log("url = "+url);
			var folder = files[i].replace(".txt",""); //console.log("folder = "+folder);
			CPP_DKFile_Delete(DKPATH+"/"+folder);
		}
	}
	
	// Delete DKPlugins
	CPP_DKFile_Delete(DKPATH+"/DKPlugins");
}

////////////////////////////////
function DKBuild_Reset3rdParty()
{
	//TODO
	console.log("Deleting 3rdParty... ");
	console.log("Please wait. ");
	CPP_DKFile_Delete(DKPATH+"/3rdParty");
}

/////////////////////////////
function DKBuild_GetAppList()
{
	//DKApps folder
	var apps = CPP_DKFile_DirectoryContents(DKPATH+"/DK/DKApps");
	if(!apps){ return; }
	APP_LIST = apps.split(",");
	for(var i=0; i<APP_LIST.length; i++){
		if(!CPP_DKFile_IsDirectory(DKPATH+"/DK/DKApps/"+APP_LIST[i]) || APP_LIST[i] === ".svn"){
			APP_LIST.splice(i, 1);
			i=0;
		}
	}

	//User DKApps folders
	var contents = CPP_DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ 
		if(files[i].indexOf(".txt") <=1){ continue; }
		//console.log("files["+i+"] = "+files[i]);
		var url = CPP_DKFile_GetSetting(DKPATH+"/"+files[i], "[MYGIT]");
		if(url){ 
			//console.log("url = "+url);
			var folder = files[i].replace(".txt",""); 
			//console.log("folder = "+folder);
			var apps2 = CPP_DKFile_DirectoryContents(DKPATH+"/"+folder+"/DKApps");
			if(apps2){
				//console.log("apps2 = "+apps2);
				var APP_LIST2 = apps2.split(",");
				for(var b=0; b<APP_LIST2.length; b++){
					//console.log("APP_LIST2["+b+"] = "+APP_LIST2[b]);
					if(!CPP_DKFile_IsDirectory(DKPATH+"/"+folder+"/DKApps/"+APP_LIST2[b]) || APP_LIST2[b] === ".svn" || APP_LIST2[b] === ".git"){
						APP_LIST2.splice(b, 1);
						b=0;
					}
				}
				APP_LIST = APP_LIST.concat(APP_LIST2);
				//console.log("apps = "+apps);
			}
		}
	}
	
	/*
	console.log("*****************");
	for(var i=0; i<APP_LIST.length; i++){
		console.log(APP_LIST[i]);
	}
	*/
}

////////////////////////////
function DKBuild_DoResults()
{
	console.log("DKBuild_DoResults(): OS="+OS+" APP="+APP+" TYPE="+TYPE+" LEVEL="+LEVEL);
	if(!DKBuild_OsCheck()){ return; }
	
	//Update the apps CmakeLists.txt file
	//CPP_DKFile_Copy(DKPATH+"/DKPlugins/_DKImport/CMakeLists.txt", DKPATH+"/DKApps/"+APP+"/CMakeLists.txt", true);
	//CPP_DKFile_Copy(DKPATH+"/DKPlugins/_DKIMPORT/", DKPATH+"/DKApps/"+APP+"/", false); //any missing files
	//CPP_DKFile_StringToFile("",DKPATH+"/DKApps/"+APP+"/assets.zip");
	
	////// Create the cmake string
	var cmake_string = "";
	if(TYPE === "Debug" || TYPE === "ALL"){
		cmake_string = cmake_string+"-DDEBUG=ON ";
	}
	if(TYPE === "Release" || TYPE === "ALL"){
		cmake_string = cmake_string+"-DRELEASE=ON ";
	}
	if(LEVEL === "Build"){
		cmake_string = cmake_string+"-DBUILD=ON ";
	}
	if(LEVEL === "Rebuild"){
		cmake_string = cmake_string+"-DREBUILD=ON ";
	}
	if(LEVEL === "RebuildAll"){
		cmake_string = cmake_string+"-DREBUILDALL=ON ";
	}
	if(LINK === "Shared"){
		cmake_string = cmake_string+"-DSHARED=ON ";
	}
	else{
		cmake_string = cmake_string+"-DSTATIC=ON ";
	}
	
	var appdir = "DKApps";
	
	var contents = CPP_DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ 
		if(CPP_dk.file.extist(DKPATH+"/"+files[i]+"/DKApps/"+APP)){
			appdir = files[i]+"/DKApps";
		}
	}
	
	//// Create Icons
	if(CPP_DK_GetOS() === "Win32" || CPP_DK_GetOS() === "Win64"){
		CPP_DK_Create("DKBuild/IconMaker.js");
		IconMaker_Create(DKPATH+"/"+appdir+"/"+APP);
	}
	
	////// WIN32 /////
	if(OS === "win32"){
		if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/CMakeFiles");
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/"+APP+".dir");
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/Win32");
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/CMakeCache.txt");	
			if(TYPE === "Debug" || TYPE === "ALL"){
				//CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/Debug");
			}
			if(TYPE === "Release" || TYPE === "ALL"){
				//CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/Release");
			}
		}
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/win32");
		CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/win32");
		
		var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Visual Studio 16 2019\" -A Win32 "+cmake_string+DKPATH+"/DK");
		
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(CPP_dk.file.extist(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Debug/"+APP+".exe")){
				CPP_DKFile_Rename(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Debug/"+APP+".exe", DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_old.exe", true);
			}		
			CPP_DK_Execute(VC2019+" "+DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Debug");
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(CPP_dk.file.extist(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+".exe")){
				CPP_DKFile_Rename(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+".exe", DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_old.exe", true);
			}
			CPP_DK_Execute(VC2019+" "+DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Release");
		}
		
		//copy .pdb file to assets
		//CPP_DKFile_Copy(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+".pdb", DKPATH+"/"+appdir+"/"+APP+"/assets/"+APP+".pdb", true);
		
		//upx compress the exe file
		/*
		if(CPP_dk.file.extist(DKPATH+"/DK/3rdParty/upx-3.95-win64/upx.exe")){
			console.warn("UPX compressing exe... please wait");
			CPP_DK_Execute(DKPATH+"/DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+DKPATH+"/"+appdir+"/"+APP+"/win32/Release/"+APP+".exe");
		}
		else{
			console.warn("DKBuild_DoResults(): UPX does not exists");
		}
		*/
	}
	
	////// WIN64 /////
	if(OS === "win64"){
		if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/CMakeFiles");
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/"+APP+".dir");
			
			
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/Win32");
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/CMakeCache.txt");
			if(TYPE === "Debug" || TYPE === "ALL"){
				//CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/Debug");
			}
			if(TYPE === "Release" || TYPE === "ALL"){
				//CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/Release");
			}
		}
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/win64");
		CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/win64");
		var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Visual Studio 16 2019\" -A x64 "+cmake_string+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(CPP_dk.file.extist(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Debug/"+APP+"_64.exe")){
				CPP_DKFile_Rename(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Debug/"+APP+"_64.exe", DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_64_old.exe", true);
			}
			CPP_DK_Execute(VC2019+" "+DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Debug");
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(CPP_dk.file.extist(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_64.exe")){
				CPP_DKFile_Rename(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_64.exe", DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_64_old.exe", true);
			}
			CPP_DK_Execute(VC2019+" "+DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Release");
		}
		
		//copy .pdb file to assets
		//CPP_DKFile_Copy(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+".pdb", DKPATH+"/"+appdir+"/"+APP+"/assets/"+APP+".pdb", true);
		
		//upx compress the exe file
		/*
		if(CPP_dk.file.extist(DKPATH+"/3rdParty/upx-3.95-win64/upx.exe")){
			console.warn("UPX compressing exe... please wait");
			CPP_DK_Execute(DKPATH+"/3rdParty/upx-3.95-win64/upx.exe -9 -v "+DKPATH+"/"+appdir+"/"+APP+"/win64/Release/"+APP+".exe");
		}
		else{
			console.warn("DKBuild_DoResults(): UPX does not exists");
		}
		*/
	}
	
	///// MAC32 ////
	if(OS === "mac32"){
		if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/mac32");
		}
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/mac32");
		CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/mac32");
		var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Xcode\" -DCMAKE_OSX_ARCHITECTURES=i386 "+cmake_string+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build");
			
			//update the info.plist in include the logo icon
			var info_plist = CPP_DKFile_FileToString(DKPATH+"/"+appdir+"/"+APP+"/mac32/Debug/"+APP+".app/Contents/info.plist");
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>");
			CPP_DKFile_StringToFile(info_plist, DKPATH+"/"+appdir+"/"+APP+"/mac32/Debug/"+APP+".app/Contents/info.plist")
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build");
			
			//update the info.plist in include the logo icon
			var info_plist = CPP_DKFile_FileToString(DKPATH+"/"+appdir+"/"+APP+"/mac32/Release/"+APP+".app/Contents/info.plist");
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>");
			CPP_DKFile_StringToFile(info_plist, DKPATH+"/"+appdir+"/"+APP+"/mac32/Release/"+APP+".app/Contents/info.plist")
			
			//update install_name_tool if cef present
			//TODO
		}
	}
	
	///// MAC64 ////
	if(OS === "mac64"){
		if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/mac64");
		}
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/mac64");
		CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/mac64");
		var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Xcode\" -DCMAKE_OSX_ARCHITECTURES=x86_64 "+cmake_string+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build");
			
			//update the info.plist in include the logo icon
			var info_plist = CPP_DKFile_FileToString(DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/info.plist");
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>");
			CPP_DKFile_StringToFile(info_plist, DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/info.plist");
			
			//update install_name_tool if cef present
			if(CPP_dk.file.extist(DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/Frameworks/Chromium Embedded Framework.framework")){
				console.log("USING CHROMIUM EMBEDDED FRAMEWORK");
				
				var command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\"";
				console.log(command);
				CPP_DK_Execute(command);
				
				command = "install_name_tool -add_rpath \"@executable_path/../../../../\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\"";
				console.log(command);
				CPP_DK_Execute(command);
				
				command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+"\"";
				console.log(command);
				CPP_DK_Execute(command);
				
				command = "install_name_tool -add_rpath \"@executable_path/../\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/MacOS/"+APP+"\"";
				console.log(command);
				CPP_DK_Execute(command);
			}
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build");
			
			//update the info.plist in include the logo icon
			var info_plist = CPP_DKFile_FileToString(DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/info.plist");
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>");
			CPP_DKFile_StringToFile(info_plist, DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/info.plist");
			
			//update install_name_tool if cef present
			if(CPP_dk.file.extist(DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/Frameworks/Chromium Embedded Framework.framework")){
				console.log("USING CHROMIUM EMBEDDED FRAMEWORK");
				
				var command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\"";
				console.log(command);
				CPP_DK_Execute(command);
				
				command = "install_name_tool -add_rpath \"@executable_path/../../../../\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\"";
				console.log(command);
				CPP_DK_Execute(command);
				
				command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+"\"";
				console.log(command);
				CPP_DK_Execute(command);
				
				command = "install_name_tool -add_rpath \"@executable_path/../\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/MacOS/"+APP+"\"";
				console.log(command);
				CPP_DK_Execute(command);
			}
		}
	}
	
	///// IOS32 ////
	if(OS === "ios32"){
		if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/ios32");
		}
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/ios32");
		CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/ios32");
		var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"/DKCMake/iOS.cmake -DIOS_PLATFORM=OS "+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -arch \"armv7 armv7s\"");
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build -arch \"armv7 armv7s\"");
		}
	}
	
	///// IOS64 ////
	if(OS === "ios64"){
		if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/ios64");
		}
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/ios64");
		CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/ios64");
		var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"/DKCMake/iOS.cmake -DIOS_PLATFORM=OS "+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -arch \"armv7 armv7s\"");
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build -arch \"armv7 armv7s\"");
		}
	}
	
	///// IOSSIM32 //////
	if(OS === "iossim32"){
		if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/iossim32");
		}
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/iossim32");
		CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/iossim32");
		var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"/DKCMake/iOS.cmake -DIOS_PLATFORM=SIMULATOR "+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -sdk iphonesimulator11.2");
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build -sdk iphonesimulator11.2");
		}
	}
	
	///// IOSSIM64 //////
	if(OS === "iossim64"){
		if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
			CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/iossim64");
		}
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/iossim64");
		CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/iossim64");
		var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"/DKCMake/iOS.cmake -DIOS_PLATFORM=SIMULATOR64 "+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE === "Debug" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -sdk iphonesimulator11.2");
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			CPP_DK_Execute("xcodebuild -target "+APP+" -configuration Release build -sdk iphonesimulator11.2");
		}
	}
	
	//// LINUX32 ///////
	if(OS === "linux32"){
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/linux32");
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
				CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug");
			}
			CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug");
			CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug");
			var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			CPP_DK_Execute("make "+APP);
			
			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			CPP_DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug/"+APP+".desktop");
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
				CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/linux32/Release");
			}
			CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/linux32/Release");
			CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/linux32/Release");
			var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			CPP_DK_Execute("make "+APP);
			
			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/linux32/Release/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			CPP_DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/linux32/Release/"+APP+".desktop");
		}
	}
	
	//// LINUX64 ///////
	if(OS === "linux64"){
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/linux64");
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
				CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug");
			}
			CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug");
			CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug");
			var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			CPP_DK_Execute("make "+APP);

			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			CPP_DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug/"+APP+".desktop");
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
				CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/linux64/Release");
			}
			CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/linux64/Release");
			CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/linux64/Release");
			var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			CPP_DK_Execute("make "+APP);
			
			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/linux64/Release/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			CPP_DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/linux64/Release/"+APP+".desktop");
		}
	}
	
	////// ANDROID32 /////
	if(OS === "android32"){
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/android32");
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
				CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/android32/Debug/CMakeCache.txt");
			}
			CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/android32/Debug");
			CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/android32/Debug");

			if(CPP_DK_GetOS() === "Win32 " || CPP_DK_GetOS() === "Win64"){
				var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Visual Studio 16 2019\" -A ARM -DCMAKE_TOOLCHAIN_FILE="+NDK+"/build/cmake/android.toolchain.cmake -DANDROID_NDK="+NDK+" -DANDROID_ABI=armeabi-v7a -DANDROID_NATIVE_API_LEVEL=29 "+cmake_string+DKPATH+"/DK");
			}
			if(CPP_DK_GetOS() === "Linux" || CPP_DK_GetOS() === "Mac"){
				rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			}
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			CPP_DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=1 NDKLOG=1");
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
				CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/android32/Release/CMakeCache.txt");
			}
			CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/android32/Release");
			CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/android32/Release");

			if(CPP_DK_GetOS() === "Win32" || CPP_DK_GetOS() === "Win64"){
				var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Visual Studio 16 2019\" -A ARM -DCMAKE_TOOLCHAIN_FILE="+NDK+"/build/cmake/android.toolchain.cmake -DANDROID_NDK="+NDK+" -DANDROID_ABI=armeabi-v7a -DANDROID_NATIVE_API_LEVEL=29 "+cmake_string+DKPATH+"/DK");
			}
			if(CPP_DK_GetOS() === "Linux" || CPP_DK_GetOS() === "Mac"){
				rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			}
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			CPP_DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=0 NDKLOG=1")
		}
	}
	
	////// ANDROID64 /////
	if(OS === "android64"){
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/android64");
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
				CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/android64/Debug/CMakeCache.txt");
			}
			CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/android64/Debug");
			CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/android64/Debug");
			
			if(CPP_DK_GetOS() === "Win32 " || CPP_DK_GetOS() === "Win64"){
				var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Visual Studio 16 2019\" -A ARM -DCMAKE_TOOLCHAIN_FILE="+NDK+"/build/cmake/android.toolchain.cmake -DANDROID_NDK="+NDK+" -DANDROID_ABI=arm64-v8a -DANDROID_NATIVE_API_LEVEL=29 "+cmake_string+DKPATH+"/DK");
			}
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			CPP_DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=1 NDKLOG=1");
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
				CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/android64/Release/CMakeCache.txt");
			}
			CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/android64/Release");
			CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/android64/Release");

			if(CPP_DK_GetOS() === "Win32" || CPP_DK_GetOS() === "Win64"){
				var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Visual Studio 16 2019\" -A ARM64 -DCMAKE_TOOLCHAIN_FILE="+NDK+"/build/cmake/android.toolchain.cmake -DANDROID_NDK="+NDK+" -DANDROID_ABI=arm64-v8a -DANDROID_NATIVE_API_LEVEL=29 "+cmake_string+DKPATH+"/DK");
			}
			if(CPP_DK_GetOS() === "Linux" || CPP_DK_GetOS() === "Mac"){
				rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			}
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			CPP_DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=0 NDKLOG=1")
		}
	}
	
	
	//// RASPBERRY32 ///////
	if(OS === "raspberry32"){
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/raspberry32");
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
				CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/raspberry32/Debug");
			}
			CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/raspberry32/Debug");
			CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/raspberry32/Debug");
			var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("Error 1") > -1){ return; }
			if(rtvalue.indexOf("errors occurred!") > -1){ return; } //FIXME: this doesn't catch all build errors
			
			CPP_DK_Execute("make "+APP);
			
			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/raspberry32/Debug/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			CPP_DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug/"+APP+".desktop");
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
				CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/raspberry32/Release");
			}
			CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/raspberry32/Release");
			CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/raspberry32/Release");
			var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; } //FIXME: this doesn't catch all build errors
			
			CPP_DK_Execute("make "+APP);
			
			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/raspberry32/Release/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			CPP_DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/raspberry32/Release/"+APP+".desktop");
		}
	}
	
	//// RASPBERRY64 ///////
	if(OS === "linux64"){
		CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/raspberry64");
		if(TYPE === "Debug" || TYPE === "ALL"){
			if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
				CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/raspberry64/Debug");
			}
			CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/raspberry64/Debug");
			CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/raspberry64/Debug");
			var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; } //FIXME: this doesn't catch all build errors
			
			CPP_DK_Execute("make "+APP);

			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/raspberry64/Debug/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			CPP_DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/raspberry64/Debug/"+APP+".desktop");
		}
		if(TYPE === "Release" || TYPE === "ALL"){
			if(LEVEL === "Rebuild" || LEVEL === "RebuildAll"){
				CPP_DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/raspberry64/Release");
			}
			CPP_dk.file.makeDir(DKPATH+"/"+appdir+"/"+APP+"/raspberry64/Release");
			CPP_DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/raspberry64/Release");
			var rtvalue = CPP_DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; } //FIXME: this doesn't catch all build errors
			
			CPP_DK_Execute("make "+APP);
			
			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/raspberry64/Release/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			CPP_DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/raspberry64/Release/"+APP+".desktop");
		}
	}
	
	
	//* The build is done
	console.log("\n");
	console.log("********************************************");
	console.log("********************************************");
	console.log("   DONE BUILDING "+APP+" "+OS)
	console.log("********************************************");
	console.log("********************************************");
	
	/*
	if(CPP_DK_Available("DKAudio")){
		CPP_DK_Create("DKAudio");
	}
	if(CPP_DK_Valid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
	*/
}
