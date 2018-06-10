/*
	Git should be extracted from this to it's own plugin.
	Also, git credential memory should be added.
*/

var OS = "";   //win32,win64,mac32,mac64,linux32,linux64,ios32,ios64,iossim32,iossim64,android32,android64
var APP = "";  //DKAppname
var TYPE = "";  //Debug, Release, ALL
var LINK = "";  //Static, Dynamic
var LEVEL = "";  //Build, Rebuild, RebuildAll
var DKPATH = "";
var SVN = "";
var CMAKE = "";
var NDK = "";
var VC2015 = "C:/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe";
var GCC = "/usr/bin/g++";
var XCODE = "/Applications/Xcode.app";
var APP_LIST = [];


///////////////////////
function DKBuild_Init()
{
	//DKLog("DKBuild_Init() \n");
	DKCreate("DKThreadPool");
	DKCreate("DKCurl");
	DKCreate("DKGit/DKGit.js", function(){});

	//DKLog(DK_GetOS()+"\n");
	if(DK_GetOS() == "Win32"){
		DKPATH = "C:/digitalknob";
		SVN = "C:/Program Files/Subversion/bin/svn.exe";
		SVN = DKFile_GetShortName(SVN);
		CMAKE = "C:/Program Files/CMake/bin/cmake.exe";
		CMAKE = DKFile_GetShortName(CMAKE);
		NDK = DKPATH+"/3rdParty/android-ndk-r10d";
		NDK = DKFile_GetShortName(NDK);
	}
	if(DK_GetOS() == "Win64"){
		DKPATH = "C:/digitalknob";
		SVN = "C:/Program Files (x86)/Subversion/bin/svn.exe";
		SVN = DKFile_GetShortName(SVN);
		CMAKE = "C:/Program Files (x86)/CMake/bin/cmake.exe";
		CMAKE = DKFile_GetShortName(CMAKE);
		NDK = DKPATH+"/3rdParty/android-ndk-r10d";
		NDK = DKFile_GetShortName(NDK);
	}
	if(DK_GetOS() == "Mac"){
		DKPATH = "/Users/aquawicket/Desktop/digitalknob";
		SVN = "svn";
		CMAKE = "/Applications/CMake.app/Contents/bin/cmake";
		NDK = DKPATH+"/3rdParty/android-ndk-r10e";
	}
	if(DK_GetOS() == "Linux"){
		DKPATH = "/home/aqualinux/Desktop/digitalknob";
		SVN = "/usr/bin/svn";
		CMAKE = "/usr/bin/cmake";
		NDK = DKPATH+"/3rdParty/android-ndk-r10e";
	}

	/*
	if(DKAvailable("DKWidget")){
		DKCreate("DKBuild/DKBuildGUI.js", function(){});
	}
	else{
		DKCreate("DKBuild/DKBuildConsole.js", function(){});
	}
	*/
}

//////////////////////
function DKBuild_End()
{
	//DKLog("DKBuild_End()\n");
}

//////////////////////////////
function DKBuild_ValidateSvn()
{
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Looking for SVN \n");
	//DKLog(SVN+"\n");
	if(!DKFile_Exists(SVN)){
		DKLog("Please install SVN \n");
		DKBuild_InstallSvn();
	}
	DKLog("Found SVN \n");
	if(DK_GetOS() == "Mac"){
		SVN = "svn";
	}
}

/////////////////////////////
function DKBuild_InstallSvn()
{
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Installing Svn \n");
	var assets = DKAssets_LocalAssets();
	
	if(DK_GetOS() == "Win32"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Setup-Subversion-1.8.10.msi", assets);
		DK_System(assets+"/Setup-Subversion-1.8.10.msi");
	}
	else if(DK_GetOS() == "Win64"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Setup-Subversion-1.8.10.msi", assets);
		DK_System(assets+"/Setup-Subversion-1.8.10.msi");
	}
	else if(DK_GetOS() == "Mac"){
		//TODO
	}
	else if(DK_GetOS() == "Linux"){
		DK_Execute("sudo apt-get install subversion");
	}
	else{
		DKLog("ERROR: unrecognied HOST OS: "+DK_GetOS(), DKINFO);
	}
}

////////////////////////////////
function DKBuild_ValidateCmake()
{
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Looking for CMake \n");
	//DKLog(CMAKE+"\n");
	if(!DKFile_Exists(CMAKE)){
		DKLog("Please install CMake \n");
		DKBuild_InstallCmake();
	}
	DKLog("Found CMake \n");
	if(DK_GetOS() == "Mac"){
		CMAKE = "cmake";
	}
}

///////////////////////////////
function DKBuild_InstallCmake()
{
	DKLog("Installing CMake \n");
	var datapath = DKAssets_LocalAssets();
	
	if(DK_GetOS() == "Win32"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/cmake-3.4.1-win32-x86.exe", datapath);
		DK_System(datapath+"/cmake-3.4.1-win32-x86.exe");
	}
	else if(DK_GetOS() == "Win64"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/cmake-3.4.1-win32-x86.exe", datapath);
		DK_System(datapath+"/cmake-3.4.1-win32-x86.exe");
	}
	else if(DK_GetOS() == "Mac"){
		//TODO
	}
	else if(DK_GetOS() == "Linux"){
		DK_Execute("sudo apt-get install cmake");
	}
	else{
		DKLog("ERROR: unrecognied HOST OS: "+DK_GetOS(), DKINFO);
	}
}

/////////////////////////////////
function DKBuild_ValidateVC2015()
{
	if(DK_GetBrowser() != "Rocket"){ return; }
	if(DK_GetOS() != "Win32" && DK_GetOS() != "Win64"){
		return;
	}
	DKLog("Looking for Visual Studio 2015 \n");
	//DKLog(VC2015+"\n");
	if(!DKFile_Exists(VC2015)){
		DKBuild_InstallVC2015();
	}
	DKLog("Found Visual Studio 2015 \n");
}

////////////////////////////////
function DKBuild_InstallVC2015()
{
	DKLog("Installing Visual Studio 2015 \n");
	var datapath = DKAssets_LocalAssets();
	
	DKCurl_Download("http://DigitalKnob.com/Download/Tools/vs_community_ENU__908841471.1484716364.exe", datapath);
	DK_System(datapath+"vs_community_ENU__908841471.1484716364.exe");
}

//////////////////////////////
function DKBuild_ValidateGcc()
{
	if(DK_GetOS() != "Linux"){ return; }
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Looking for GCC \n");
	//DKLog(GCC+"\n");
	if(!DKFile_Exists(GCC)){
		DKLog("Please install GCC \n");
		DKBuild_InstallGcc();
	}
	DKLog("Found Gcc \n");
}

///////////////////////////////
function DKBuild_InstallGcc()
{
	DKLog("Installing Gcc \n");
	DK_Execute("sudo apt-get update && sudo apt-get install build-essential");
}

////////////////////////////////
function DKBuild_ValidateXcode()
{
	if(DK_GetOS() != "Mac"){ return; }
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Looking for Xcode \n");
	//DKLog(XCODE+"\n");
	if(!DKFile_Exists(XCODE)){
		DKLog("Please install Xcode \n");
		DKBuild_InstallXcode();
	}
	DKLog("Found Xcode \n");
}
///////////////////////////////
function DKBuild_InstallXcode()
{
	DKLog("Installing Xcode \n");
	var datapath = DKAssets_LocalAssets();
	DKCurl_Download("http://DigitalKnob.com/Download/Tools/xcode4630916281a.dmg", datapath);
}

//////////////////////////
function DKBuild_OsCheck()
{
	if(DK_GetOS() == "Win32"){
		if(OS == "win64"){
			DKLog(OS+" can only be build from a WIN64 machine.\n"); return false;
		}
		if(OS == "mac"){
			DKLog(OS+" can only be build from an OSX machine.\n"); return false;
		}
		if(OS == "ios"){
			DKLog(OS+" can only be build from an OSX machine.\n"); return false;
		}
		if(OS == "ios-simulator"){
			DKLog(OS+" can only be build from an OSX machine.\n"); return false;
		}
		if(OS == "linux"){
			DKLog(OS+" can only be build from a LINUX machine.\n"); return false;
		}
	}
	if(DK_GetOS() == "Win64"){
		if(OS == "mac"){
			DKLog(OS+" can only be build from an OSX machine.\n"); return false;
		}
		if(OS == "ios"){
			DKLog(OS+" can only be build from an OSX machine.\n"); return false;
		}
		if(OS == "ios-simulator"){
			DKLog(OS+" can only be build from an OSX machine.\n"); return false;
		}
		if(OS == "linux"){
			DKLog(OS+" can only be build from a LINUX machine.\n"); return false;
		}
	}
	if(DK_GetOS() == "Mac"){
		if(OS == "win32"){
			DKLog(OS+" can only be build from a Windows machine.\n"); return false;
		}
		if(OS == "win64"){
			DKLog(OS+" can only be build from an WIN64 machine.\n"); return false;
		}
		if(OS == "linux"){
			DKLog(OS+" can only be build from a linux machine.\n"); return false;
		}
		if(OS == "linux32"){
			DKLog(OS+" can only be build from a linux machine.\n"); return false;
		}
		if(OS == "linux64"){
			DKLog(OS+" can only be build from a linux machine.\n"); return false;
		}
		//if(OS == "andoroid"){
		//	DKLog(OS+" can only be build from a Windows machine.\n"); return false;
		//}
	}
	if(DK_GetOS() == "Linux"){
		if(OS == "win32"){
			DKLog(OS+" can only be build from a Windows machine.\n"); return false;
		}
		if(OS == "win64"){
			DKLog(OS+" can only be build from an WIN64 machine.\n"); return false;
		}
		if(OS == "mac"){
			DKLog(OS+" can only be build from an OSX machine.\n"); return false;
		}
		if(OS == "ios"){
			DKLog(OS+" can only be build from an OSX machine.\n"); return false;
		}
		if(OS == "ios-simulator"){
			DKLog(OS+" can only be build from an OSX machine.\n"); return false;
		}
		//if(OS == "andoroid"){
		//	DKLog(OS+" can only be build from a Windows machine.\n"); return false;
		//}
	}
	if(DK_GetOS() == "Android"){
		DKLog("Android is not capable of compiling DKApps..  please use a desktop system.\n"); return false;
	}
	if(DK_GetOS() == "iOS"){
		DKLog("iOS is not capable of compiling DKApps..  please use a desktop system.\n"); return false;
	}
	return true;
}

////////////////////////////
function DKBuild_SvnUpdate()
{
	DKLog("Svn Update... \n");
	DK_Execute(SVN +" cleanup "+DKPATH);
	DK_Execute(SVN +" checkout https://github.com/aquawicket/DigitalKnob/trunk/ "+DKPATH);
	
	var mysvn = DKAssets_LocalAssets()+"mysvn.txt";
	if(!DKFile_Exists(mysvn)){ mysvn = DKPATH+"/mysvn.txt"; } //check for /mysvn.txt
	
	//TODO: Multipe user folders
	
	if(DKAvailable("DKAudio")){
		DKCreate("DKAudio");
	}
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}

////////////////////////////
function DKBuild_SvnCommit()
{
	DKLog("Svn Commit... \n");
	DK_Execute(SVN +" cleanup "+DKPATH);
	DK_Execute(SVN +" commit -m update "+DKPATH);
	
	//TODO: Multipe user folders
	
	if(DKAvailable("DKAudio")){
		DKCreate("DKAudio");
	}
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}

///////////////////////////////////
function DKBuild_ResetAppsPlugins()
{
	DKLog("Deleting Apps and Plugins... \n");
	
	// Delete everything in DKApps except DKBuild
	var apps = DKFile_DirectoryContents(DKPATH+"/DKApps");
	var list = apps.split(',');
	for(var i=0; i<list.length; ++i){
		if(list[i] == "DKBuilder"){ continue; }
		//DKLog("Deleting "+DKPATH+"/DKApps/"+list[i]+"\n");
		DKFile_Delete(DKPATH+"/DKApps/"+list[i]);
	}
	
	//Multipe user folders
	var contents = DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ //DKLog("files["+i+"] = "+files[i]+"\n");
		var url = DKFile_GetSetting(files[i], "[MYGIT]");
		if(url){ //DKLog("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); //DKLog("folder = "+folder+"\n");
			DKFile_Delete(DKPATH+"/"+folder);
		}
	}
	
	// Delete DKPlugins
	DKFile_Delete(DKPATH+"/DKPlugins");
}

////////////////////////////////
function DKBuild_Reset3rdParty()
{
	//TODO
	DKLog("Deleting 3rdParty... \n");
	DKLog("Please wait. \n");
	DKFile_Delete(DKPATH+"/3rdParty");
}

/////////////////////////////
function DKBuild_GetAppList()
{
	//DKLog("DKBuild_GetAppList() \n");
	
	//DKApps folder
	var apps = DKFile_DirectoryContents(DKPATH+"/DK/DKApps");
	if(!apps){ return; }
	APP_LIST = apps.split(",");
	for(var i=0; i<APP_LIST.length; i++){
		if(!DKFile_IsDirectory(DKPATH+"/DK/DKApps/"+APP_LIST[i]) || APP_LIST[i] == ".svn"){
			APP_LIST.splice(i, 1);
			i=0;
		}
	}

	//User DKApps folders
	var contents = DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ 
		if(files[i].indexOf(".txt") <=1){ continue; }
		//DKLog("files["+i+"] = "+files[i]+"\n");
		var url = DKFile_GetSetting(DKPATH+"/"+files[i], "[MYGIT]");
		if(url){ 
			//DKLog("url = "+url+"\n");
			var folder = files[i].replace(".txt",""); 
			//DKLog("folder = "+folder+"\n");
			var apps2 = DKFile_DirectoryContents(DKPATH+"/"+folder+"/DKApps");
			if(apps2){
				//DKLog("apps2 = "+apps2+"\n");
				var APP_LIST2 = apps2.split(",");
				for(var b=0; b<APP_LIST2.length; b++){
					//DKLog("APP_LIST2["+b+"] = "+APP_LIST2[b]+"\n");
					if(!DKFile_IsDirectory(DKPATH+"/"+folder+"/DKApps/"+APP_LIST2[b]) || APP_LIST2[b] == ".svn" || APP_LIST2[b] == ".git"){
						APP_LIST2.splice(b, 1);
						b=0;
					}
				}
				APP_LIST = APP_LIST.concat(APP_LIST2);
				//DKLog("apps = "+apps+"\n");
			}
		}
	}
	
	/*
	DKLog("*****************\n");
	for(var i=0; i<APP_LIST.length; i++){
		DKLog(APP_LIST[i]+"\n");
	}
	*/
}

////////////////////////////
function DKBuild_DoResults()
{
	DKLog("DKBuild_DoResults(): OS="+OS+" APP="+APP+" TYPE="+TYPE+" LEVEL="+LEVEL+"\n");
	if(!DKBuild_OsCheck()){ return; }
	
	//Update the apps CmakeLists.txt file
	//DKFile_Copy(DKPATH+"/DKPlugins/_DKImport/CMakeLists.txt", DKPATH+"/DKApps/"+APP+"/CMakeLists.txt", true);
	//DKFile_Copy(DKPATH+"/DKPlugins/_DKIMPORT/", DKPATH+"/DKApps/"+APP+"/", false); //any missing files
	//DKFile_StringToFile("",DKPATH+"/DKApps/"+APP+"/assets.zip");
	
	////// Create the cmake string
	var cmake_string = "";
	if(TYPE == "Debug" || TYPE == "ALL"){
		cmake_string = cmake_string+"-DDEBUG=ON ";
	}
	if(TYPE == "Release" || TYPE == "ALL"){
		cmake_string = cmake_string+"-DRELEASE=ON ";
	}
	if(LEVEL == "Build"){
		cmake_string = cmake_string+"-DBUILD=ON ";
	}
	if(LEVEL == "Rebuild"){
		cmake_string = cmake_string+"-DREBUILD=ON ";
	}
	if(LEVEL == "RebuildAll"){
		cmake_string = cmake_string+"-DREBUILDALL=ON ";
	}
	if(LINK == "Dynamic"){
		cmake_string = cmake_string+"-DDYNAMIC=ON ";
	}
	else{
		cmake_string = cmake_string+"-DSTATIC=ON ";
	}
	
	var appdir = "DKApps";
	
	var contents = DKFile_DirectoryContents(DKPATH);
	var files = contents.split(",");
	for(var i=0; i<files.length; i++){ 
		if(DKFile_Exists(DKPATH+"/"+files[i]+"/DKApps/"+APP)){
			appdir = files[i]+"/DKApps";
		}
	}
	
	//// Create Icons
	if(DK_GetOS() == "Win32" || DK_GetOS() == "Win64"){
		DKCreate("DKBuild/IconMaker.js", function(){
			IconMaker_Create(DKPATH+"/"+appdir+"/"+APP);
		});
	}
	
	////// WIN32 /////
	if(OS == "win32"){
		if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/CMakeFiles");
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/"+APP+".dir");
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/Win32");
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/CMakeCache.txt");	
			if(TYPE == "Debug" || TYPE == "ALL"){
				//DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/Debug");
			}
			if(TYPE == "Release" || TYPE == "ALL"){
				//DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/Release");
			}
		}
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/win32");
		DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/win32");
		var rtvalue = DK_Execute(CMAKE+" -G \"Visual Studio 14 2015\" "+cmake_string+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE == "Debug" || TYPE == "ALL"){
			if(DKFile_Exists(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Debug/"+APP+".exe")){
				DKFile_Rename(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Debug/"+APP+".exe", DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_old.exe", true);
			}		
			DK_Execute("C:/Progra~2/MSBuild/14.0/Bin/MSBuild.exe "+DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Debug");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			if(DKFile_Exists(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+".exe")){
				DKFile_Rename(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+".exe", DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_old.exe", true);
			}
			DK_Execute("C:/Progra~2/MSBuild/14.0/Bin/MSBuild.exe "+DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Release");
		}
		
		//copy .pdb file to assets
		DKFile_Copy(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+".pdb", DKPATH+"/"+appdir+"/"+APP+"/assets/"+APP+".pdb", true);
		
		//upx compress the exe file
		if(DKFile_Exists(DKPATH+"/3rdParty/upx392w/upx.exe")){
			DKLog("UPX compressing exe... please wait \n", DKWARN);
			DK_Execute(DKPATH+"/3rdParty/upx392w/upx.exe -9 -v "+DKPATH+"/"+appdir+"/"+APP+"/win32/Release/"+APP+".exe");
		}
		else{
			DKLog("DKBuild_DoResults(): UPX does not exists \n", DKWARN);
		}
	}
	
	////// WIN64 /////
	if(OS == "win64"){
		if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/CMakeFiles");
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/"+APP+".dir");
			
			
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/Win32");
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/CMakeCache.txt");
			if(TYPE == "Debug" || TYPE == "ALL"){
				//DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/Debug");
			}
			if(TYPE == "Release" || TYPE == "ALL"){
				//DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/Release");
			}
		}
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/win64");
		DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/win64");
		var rtvalue = DK_Execute(CMAKE+" -G \"Visual Studio 14 2015 Win64\" "+cmake_string+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE == "Debug" || TYPE == "ALL"){
			if(DKFile_Exists(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Debug/"+APP+"_64.exe")){
				DKFile_Rename(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Debug/"+APP+"_64.exe", DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_64_old.exe", true);
			}
			DK_Execute("C:/Progra~2/MSBuild/14.0/Bin/MSBuild.exe "+DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Debug");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			if(DKFile_Exists(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_64.exe")){
				DKFile_Rename(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_64.exe", DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+"_64_old.exe", true);
			}
			DK_Execute("C:/Progra~2/MSBuild/14.0/Bin/MSBuild.exe "+DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Release");
		}
		
		//upx compress the exe file
		if(DKFile_Exists(DKPATH+"/3rdParty/upx391w/upx.exe")){
			DKLog("UPX compressing exe... please wait \n", DKWARN);
			DK_Execute(DKPATH+"/3rdParty/upx391w/upx.exe -9 -v "+DKPATH+"/"+appdir+"/"+APP+"/win64/Release/"+APP+".exe");
		}
		else{
			DKLog("DKBuild_DoResults(): UPX does not exists \n", DKWARN);
		}
	}
	
	///// MAC32 ////
	if(OS == "mac32"){
		if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/mac32");
		}
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/mac32");
		DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/mac32");
		var rtvalue = DK_Execute(CMAKE+" -G \"Xcode\" -DCMAKE_OSX_ARCHITECTURES=i386 "+cmake_string+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE == "Debug" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Debug build");
			
			//update the info.plist in include the logo icon
			var info_plist = DKFile_FileToString(DKPATH+"/"+appdir+"/"+APP+"/mac32/Debug/"+APP+".app/Contents/info.plist");
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>");
			DKFile_StringToFile(info_plist, DKPATH+"/"+appdir+"/"+APP+"/mac32/Debug/"+APP+".app/Contents/info.plist")
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Release build");
			
			//update the info.plist in include the logo icon
			var info_plist = DKFile_FileToString(DKPATH+"/"+appdir+"/"+APP+"/mac32/Release/"+APP+".app/Contents/info.plist");
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>");
			DKFile_StringToFile(info_plist, DKPATH+"/"+appdir+"/"+APP+"/mac32/Release/"+APP+".app/Contents/info.plist")
			
			//update install_name_tool if cef present
			//TODO
		}
	}
	
	///// MAC64 ////
	if(OS == "mac64"){
		if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/mac64");
		}
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/mac64");
		DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/mac64");
		var rtvalue = DK_Execute(CMAKE+" -G \"Xcode\" -DCMAKE_OSX_ARCHITECTURES=x86_64 "+cmake_string+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE == "Debug" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Debug build");
			
			//update the info.plist in include the logo icon
			var info_plist = DKFile_FileToString(DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/info.plist");
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>");
			DKFile_StringToFile(info_plist, DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/info.plist");
			
			//update install_name_tool if cef present
			if(DKFile_Exists(DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/Frameworks/Chromium Embedded Framework.framework")){
				DKLog("USING CHROMIUM EMBEDDED FRAMEWORK \n");
				
				var command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\"";
				DKLog(command+"\n", DKINFO);
				DK_Execute(command);
				
				command = "install_name_tool -add_rpath \"@executable_path/../../../../\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\"";
				DKLog(command+"\n", DKINFO);
				DK_Execute(command);
				
				command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+"\"";
				DKLog(command+"\n", DKINFO);
				DK_Execute(command);
				
				command = "install_name_tool -add_rpath \"@executable_path/../\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/MacOS/"+APP+"\"";
				DKLog(command+"\n", DKINFO);
				DK_Execute(command);
			}
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Release build");
			
			//update the info.plist in include the logo icon
			var info_plist = DKFile_FileToString(DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/info.plist");
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>");
			DKFile_StringToFile(info_plist, DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/info.plist");
			
			//update install_name_tool if cef present
			if(DKFile_Exists(DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/Frameworks/Chromium Embedded Framework.framework")){
				DKLog("USING CHROMIUM EMBEDDED FRAMEWORK \n");
				
				var command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\"";
				DKLog(command+"\n", DKINFO);
				DK_Execute(command);
				
				command = "install_name_tool -add_rpath \"@executable_path/../../../../\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\"";
				DKLog(command+"\n", DKINFO);
				DK_Execute(command);
				
				command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+"\"";
				DKLog(command+"\n", DKINFO);
				DK_Execute(command);
				
				command = "install_name_tool -add_rpath \"@executable_path/../\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/MacOS/"+APP+"\"";
				DKLog(command+"\n", DKINFO);
				DK_Execute(command);
			}
		}
	}
	
	///// IOS32 ////
	if(OS == "ios32"){
		if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/ios32");
		}
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/ios32");
		DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/ios32");
		var rtvalue = DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"/DKCMake/iOS.cmake -DIOS_PLATFORM=OS "+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE == "Debug" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -arch \"armv7 armv7s\"");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Release build -arch \"armv7 armv7s\"");
		}
	}
	
	///// IOS64 ////
	if(OS == "ios64"){
		if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/ios64");
		}
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/ios64");
		DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/ios64");
		var rtvalue = DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"/DKCMake/iOS.cmake -DIOS_PLATFORM=OS "+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE == "Debug" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -arch \"armv7 armv7s\"");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Release build -arch \"armv7 armv7s\"");
		}
	}
	
	///// IOSSIM32 //////
	if(OS == "iossim32"){
		if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/iossim32");
		}
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/iossim32");
		DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/iossim32");
		var rtvalue = DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"/DKCMake/iOS.cmake -DIOS_PLATFORM=SIMULATOR "+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE == "Debug" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -sdk iphonesimulator11.2");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Release build -sdk iphonesimulator11.2");
		}
	}
	
	///// IOSSIM64 //////
	if(OS == "iossim64"){
		if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/iossim64");
		}
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/iossim64");
		DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/iossim64");
		var rtvalue = DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"/DKCMake/iOS.cmake -DIOS_PLATFORM=SIMULATOR64 "+DKPATH+"/DK");
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE == "Debug" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -sdk iphonesimulator11.2");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Release build -sdk iphonesimulator11.2");
		}
	}
	
	//// LINUX32 ///////
	if(OS == "linux32"){
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/linux32");
		if(TYPE == "Debug" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug");
			var rtvalue = DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute("make "+APP);
			
			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug/"+APP+".desktop");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/linux32/Release");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/linux32/Release");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/linux32/Release");
			var rtvalue = DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute("make "+APP);
			
			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/linux32/Release/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/linux32/Release/"+APP+".desktop");
		}
	}
	
	//// LINUX64 ///////
	if(OS == "linux64"){
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/linux64");
		if(TYPE == "Debug" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug");
			var rtvalue = DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute("make "+APP);

			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug/"+APP+".desktop");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/linux64/Release");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/linux64/Release");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/linux64/Release");
			var rtvalue = DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute("make "+APP);
			
			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/linux64/Release/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/linux64/Release/"+APP+".desktop");
		}
	}
	
	////// ANDROID32 /////
	if(OS == "android32"){
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/android32");
		if(TYPE == "Debug" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/android32/Debug/CMakeCache.txt");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/android32/Debug");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/android32/Debug");
			var rtvalue = DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=1 NDKLOG=1");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/android32/Release/CMakeCache.txt");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/android32/Release");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/android32/Release");
			var rtvalue;
			if(DK_GetOS() == "Win32" || DK_GetOS() == "Win64"){
				rtvalue = DK_Execute(CMAKE+" -G \"Visual Studio 14 2015\" "+cmake_string+DKPATH+"/DK");
			}
			if(DK_GetOS() == "Linux" || DK_GetOS() == "Mac"){
				rtvalue = DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			}
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=0 NDKLOG=1")
		}
	}
	
	////// ANDROID64 /////
	if(OS == "android64"){
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/android64");
		if(TYPE == "Debug" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/android64/Debug/CMakeCache.txt");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/android64/Debug");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/android64/Debug");
			var rtvalue = DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=1 NDKLOG=1");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/android64/Release/CMakeCache.txt");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/android64/Release");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/android64/Release");
			var rtvalue = DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH+"/DK");
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=0 NDKLOG=1")
		}
	}
	
	if(DKAvailable("DKAudio")){
		DKCreate("DKAudio");
	}
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}
