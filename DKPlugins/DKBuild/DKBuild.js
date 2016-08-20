var OS = "";   //win32,win64,mac32,mac64,linux32,linux64,ios32,ios64,iossim32,iossim64,android32,android64
var APP = "";  //DKAppname
var TYPE = "";  //Debug, Release, ALL
var LINK = "";  //Static, Dynamic
var LEVEL = "";  //Build, Rebuild, RebuildAll
var DKPATH = "";
var SVN = "";
var CMAKE = "";
var NDK = "C:/android-ndk-r10d";
var VC2015 = "C:/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe";
var APP_LIST = [];


///////////////////////
function DKBuild_Init()
{
	//DKLog("DKBuild_Init() \n");
	DKCreate("DKThreadPool");
	DKCreate("DKCurl");

	//DKLog(DK_GetOS()+"\n");
	if(DK_GetOS() == "WIN32" || DK_GetOS() == "Win32"){
		DKPATH = "C:/digitalknob";
		SVN = "C:/Program Files (x86)/Subversion/bin/svn.exe";
		SVN = DKFile_GetShortName(SVN);
		CMAKE = "C:/Program Files (x86)/CMake/bin/cmake.exe";
		CMAKE = DKFile_GetShortName(CMAKE);
	}
	if(DK_GetOS() == "WIN64"){
		DKPATH = "C:/digitalknob";
		SVN = "C:/Program Files (x86)/Subversion/bin/svn.exe";
		SVN = DKFile_GetShortName(SVN);
		CMAKE = "C:/Program Files (x86)/CMake/bin/cmake.exe";
		CMAKE = DKFile_GetShortName(CMAKE);
	}
	if(DK_GetOS() == "MAC"){
		DKPATH = "/Users/aquawicket/Desktop/digitalknob";
		SVN = "/usr/bin/svn";
		CMAKE = "/Applications/CMake.app/Contents/bin/cmake";
	}
	if(DK_GetOS() == "LINUX"){
		DKPATH = "/home/aquawicket/Desktop/digitalknob";
		SVN = "/usr/bin/svn";
		CMAKE = "/usr/bin/cmake";
	}

	if(DKAvailable("DKWidget")){
		DKCreate("DKBuild/DKBuildGUI.js");
	}
	else{
		DKCreate("DKBuild/DKBuildConsole.js");
	}
}

/////////////////////////////
function DKBuild_InstallSvn()
{
	DKLog("Installing Svn \n");
	var datapath = DKAssets_GetDataPath();
	
	if(DK_GetOS() == "WIN32"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Setup-Subversion-1.8.10.msi", datapath);
		DK_System(datapath+"/Setup-Subversion-1.8.10.msi");
	}
	else if(DK_GetOS() == "WIN64"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Setup-Subversion-1.8.10.msi", datapath);
		DK_System(datapath+"/Setup-Subversion-1.8.10.msi");
	}
	else if(DK_GetOS() == "MAC"){
		//TODO
	}
	else if(DK_GetOS() == "LINUX"){
		DK_Execute("sudo apt-get install subversion");
	}
	else{
		DKLog("ERROR: unrecognied HOST OS: "+DK_GetOS());
	}
}

////////////////////////////////
function DKBuild_ValidateSvn()
{
	DKLog("Looking for SVN \n");
	//DKLog(SVN+"\n");
	if(!DKFile_Exists(SVN)){
		DKLog("Please install SVN \n");
		DKBuild_InstallSvn();
	}
	DKLog("Found SVN \n");
	if(DK_GetOS() == "MAC"){
		SVN = "svn";
	}
}

/////////////////////////////////
function DKBuild_InstallCmake()
{
	DKLog("Installing CMake \n");
	var datapath = DKAssets_GetDataPath();
	
	if(DK_GetOS() == "WIN32"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/cmake-3.3.2-win32-x86.exe", datapath);
		DK_System(datapath+"/cmake-3.3.2-win32-x86.exe");
	}
	else if(DK_GetOS() == "WIN64"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/cmake-3.3.2-win32-x86.exe", datapath);
		DK_System(datapath+"/cmake-3.3.2-win32-x86.exe");
	}
	else if(DK_GetOS() == "MAC"){
		//TODO
	}
	else if(DK_GetOS() == "LINUX"){
		DK_Execute("sudo apt-get install cmake");
	}
	else{
		DKLog("ERROR: unrecognied HOST OS: "+DK_GetOS());
	}
}

//////////////////////////////////
function DKBuild_ValidateCmake()
{
	DKLog("Looking for CMake \n");
	//DKLog(CMAKE+"\n");
	if(!DKFile_Exists(CMAKE)){
		DKLog("Please install CMake \n");
		DKBuild_InstallCmake();
	}
	DKLog("Found CMake \n");
	if(DK_GetOS() == "MAC"){
		CMAKE = "cmake";
	}
}

//////////////////////////////////
function DKBuild_InstallVC2015()
{
	DKLog("Installing Visual Studio 2015 \n");
	var datapath = DKAssets_GetDataPath();
	
	if(DK_GetOS() == "WIN32"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/vs_community__de28dd49b1b30045a3a02f62906c2168.exe", datapath);
		DK_System(datapath+"/vs_community__de28dd49b1b30045a3a02f62906c2168.exe");
	}
	else if(DK_GetOS() == "WIN64"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/vs_community__de28dd49b1b30045a3a02f62906c2168.exe", datapath);
		DK_System(datapath+"/vs_community__de28dd49b1b30045a3a02f62906c2168.exe");
	}
}

///////////////////////////////////
function DKBuild_ValidateVC2015()
{
	if(DK_GetOS() != "WIN32" && DK_GetOS() != "WIN64"){
		return;
	}
	DKLog("Looking for Visual Studio 2015 \n");
	//DKLog(VC2015+"\n");
	if(!DKFile_Exists(VC2015)){
		DKBuild_InstallVC2015();
	}
	DKLog("Found Visual Studio 2015 \n");
}

////////////////////////////
function DKBuild_OsCheck()
{
	if(DK_GetOS() == "WIN32"){
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
	if(DK_GetOS() == "WIN64"){
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
	if(DK_GetOS() == "MAC"){
		if(OS == "win32"){
			DKLog(OS+" can only be build from a Windows machine.\n"); return false;
		}
		if(OS == "win64"){
			DKLog(OS+" can only be build from an WIN64 machine.\n"); return false;
		}
		if(OS == "linux"){
			DKLog(OS+" can only be build from a linux machine.\n"); return false;
		}
		if(OS == "andoroid"){
			DKLog(OS+" can only be build from a Windows machine.\n"); return false;
		}
	}
	if(DK_GetOS() == "LINUX"){
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
		if(OS == "andoroid"){
			DKLog(OS+" can only be build from a Windows machine.\n"); return false;
		}
	}
	if(DK_GetOS() == "ANDROID"){
		DKLog("Android is not capable of compiling DKApps..  please use a desktop system.\n"); return false;
	}
	if(DK_GetOS() == "IOS"){
		DKLog("iOS is not capable of compiling DKApps..  please use a desktop system.\n"); return false;
	}
	if(DK_GetOS() == "IOS-SIMULATOR"){
		DKLog("iOS is not capable of compiling DKApps..  please use a desktop system.\n"); return false;
	}
	return true;
}

//////////////////////////////
function DKBuild_SvnUpdate()
{
	DKLog("Svn Update... \n");
	DK_Execute(SVN +" cleanup "+DKPATH);
	DK_Execute(SVN +" checkout https://github.com/aquawicket/DigitalKnob/trunk/ "+DKPATH);
	
	var mysvn = DKAssets_GetDataPath()+"USER/mysvn.txt";
	if(!DKFile_Exists(mysvn)){ mysvn = DKPATH+"/USER/mysvn.txt"; } //check for /USER/mysvn.txt
	if(DKFile_Exists(mysvn)){
		var url = DKFile_GetSetting(mysvn, "[MYSVN]");
		DK_Execute(SVN +" checkout "+url+" "+DKPATH+"/USER");
	}
	
	DKCreate("DKAudio");
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}

//////////////////////////////
function DKBuild_SvnCommit()
{
	DKLog("Svn Commit... \n");
	DK_Execute(SVN +" cleanup "+DKPATH);
	DK_Execute(SVN +" commit -m update "+DKPATH);
	
	var mysvn = DKAssets_GetDataPath()+"USER/mysvn.txt";
	if(!DKFile_Exists(mysvn)){ mysvn = DKPATH+"/USER/mysvn.txt"; } //check for /USER/mysvn.txt
	if(DKFile_Exists(mysvn)){
		//var url = DKFile_GetSetting(mysvn, "[MYSVN]");
		DK_Execute(SVN +" commit -m update "+DKPATH+"/USER");
	}
	
	DKCreate("DKAudio");
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
	
	// Delete DKPlugins
	DKFile_Delete(DKPATH+"/DKPlugins");

	// Delete the USER folder
	DKFile_Delete(DKPATH+"/USER");
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
	var apps = DKFile_DirectoryContents(DKPATH+"/DKApps");
	//DKLog("DKBuild_GetAppList() apps = "+apps+"\n");
	var myapps = DKFile_DirectoryContents(DKPATH+"/USER/DKApps");
	if(!apps){ return; }
	APP_LIST = apps.split(",");
	for(var i=0; i<APP_LIST.length; i++){
		if(!DKFile_IsDirectory(DKPATH+"/DKApps/"+APP_LIST[i]) || 
			APP_LIST[i] == ".svn"// ||
			//APP_LIST[i] == "DKBuild" //FIXME:  this should be the same name of the app we are running 
		){
				APP_LIST.splice(i, 1);
				i=0;
		}
	}
	
	if(myapps){
		MYAPP_LIST = myapps.split(',');
		for(var i=0; i<MYAPP_LIST.length; i++){
			//DKLog(MYAPP_LIST[i]+"\n");
			if(!DKFile_IsDirectory(DKPATH+"/USER/DKApps/"+MYAPP_LIST[i]) || MYAPP_LIST[i] == ".svn"){
				MYAPP_LIST.splice(i, 1);
				i=0;
			}
		}
		APP_LIST = APP_LIST.concat(MYAPP_LIST);
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
	//DKFile_Copy(DKPATH+"/DKPlugins/DKApp/CMakeLists.txt", DKPATH+"/DKApps/"+APP+"/CMakeLists.txt", true);
	//DKFile_Copy(DKPATH+"/DKPlugins/DKApp/", DKPATH+"/DKApps/"+APP+"/", false); //any missing files
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
	if(DKFile_Exists(DKPATH+"/USER/DKApps/"+APP)){
		appdir = "USER/DKApps";
	}
	
	
	////// WIN32 /////
	if(OS == "win32"){
		if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/CMakeFiles");
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/"+APP+".dir");
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/Debug");
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/Release");
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/Win32");
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win32/CMakeCache.txt");	
		}
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/win32");
		DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/win32");
		var rtvalue = DK_Execute(CMAKE+" -G \"Visual Studio 14 2015\" "+cmake_string+DKPATH);
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE == "Debug" || TYPE == "ALL"){
			DK_Execute("C:/Progra~2/MSBuild/14.0/Bin/MSBuild.exe "+DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Debug");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			DK_Execute("C:/Progra~2/MSBuild/14.0/Bin/MSBuild.exe "+DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Release");
		}
		
		//upx compress the exe file
		if(DKFile_Exists(DKPATH+"/3rdParty/upx391w/upx.exe")){
			DKLog("UPX compressing exe... please wait \n", DKWARN);
			DK_Execute(DKPATH+"/3rdParty/upx391w/upx.exe -9 -v "+DKPATH+"/"+appdir+"/"+APP+"/win32/Release/"+APP+".exe");
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
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/Debug");
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/Release");
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/Win32");
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/win64/CMakeCache.txt");
		}
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/win64");
		DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/win64");
		var rtvalue = DK_Execute(CMAKE+" -G \"Visual Studio 14 2015 Win64\" "+cmake_string+DKPATH);
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE == "Debug" || TYPE == "ALL"){
			DK_Execute("C:/Progra~2/MSBuild/14.0/Bin/MSBuild.exe "+DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/"+APP+".sln /p:Configuration=Debug");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
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
		var rtvalue = DK_Execute(CMAKE+" -G \"Xcode\" -DCMAKE_OSX_ARCHITECTURES=i386 "+cmake_string+DKPATH);
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
		var rtvalue = DK_Execute(CMAKE+" -G \"Xcode\" -DCMAKE_OSX_ARCHITECTURES=x86_64 "+cmake_string+DKPATH);
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE == "Debug" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Debug build");
			
			//update the info.plist in include the logo icon
			var info_plist = DKFile_FileToString(DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/info.plist");
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>");
			DKFile_StringToFile(info_plist, DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/info.plist")
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Release build");
			
			//update the info.plist in include the logo icon
			var info_plist = DKFile_FileToString(DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/info.plist");
			info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>");
			DKFile_StringToFile(info_plist, DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/info.plist")
			
			//TODO
			//update install_name_tool if cef present
			if(DKFile_Exists(DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/Frameworks/Chromium Embedded Framework.framework")){
				DKLog("USING CHROMIUM EMBEDDED FRAMEWORK \n", DKDEBUG);
				DK_Execute("install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Debug/"+APP+".app/Contents/MacOS/"+APP+"\"");
				DK_Execute("install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+DKPATH+"/"+appdir+"/"+APP+"/mac64/Release/"+APP+".app/Contents/MacOS/"+APP+"\"");
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
		var rtvalue = DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"/DKCMake/iOS.cmake -DIOS_PLATFORM=OS "+DKPATH);
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
		var rtvalue = DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"/DKCMake/iOS.cmake -DIOS_PLATFORM=OS "+DKPATH);
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
		var rtvalue = DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"/DKCMake/iOS.cmake -DIOS_PLATFORM=SIMULATOR "+DKPATH);
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE == "Debug" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -arch i386 -sdk iphonesimulator6.1");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Release build -arch i386 -sdk iphonesimulator6.1");
		}
	}
	
	///// IOSSIM64 //////
	if(OS == "iossim64"){
		if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
			DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/iossim64");
		}
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/iossim64");
		DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/iossim64");
		var rtvalue = DK_Execute(CMAKE+" -G \"Xcode\" "+cmake_string+"-DCMAKE_TOOLCHAIN_FILE="+DKPATH+"/DKCMake/iOS.cmake -DIOS_PLATFORM=SIMULATOR "+DKPATH);
		if(rtvalue.indexOf("errors occurred!") > -1){ return; }
		
		if(TYPE == "Debug" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Debug build -arch x86_64 -sdk iphonesimulator6.1");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			DK_Execute("xcodebuild -target "+APP+" -configuration Release build -arch x86_64 -sdk iphonesimulator6.1");
		}
	}
	
	//// LINUX32 /////
	if(OS == "linux32"){
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/linux32");
		if(TYPE == "Debug" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/linux32/Debug");
			var rtvalue = DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH);
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute("make "+APP);
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/linux32/Release");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/linux32/Release");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/linux32/Release");
			var rtvalue = DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH);
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute("make "+APP);
		}
	}
	
	//// LINUX64 /////
	if(OS == "linux64"){
		DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/linux64");
		if(TYPE == "Debug" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug");
			var rtvalue = DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH);
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute("make "+APP);
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/linux64/Release");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/linux64/Release");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/linux64/Release");
			var rtvalue = DK_Execute(CMAKE+" -G \"Unix Makefiles\" "+cmake_string+DKPATH);
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute("make "+APP);
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
			var rtvalue = DK_Execute(CMAKE+" -G \"MinGW Makefiles\" "+cmake_string+DKPATH);
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=1 NDKLOG=1");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/android32/Release/CMakeCache.txt");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/android32/Release");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/android32/Release");
			var rtvalue = DK_Execute(CMAKE+" -G \"MinGW Makefiles\" "+cmake_string+DKPATH);
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
			var rtvalue = DK_Execute(CMAKE+" -G \"MinGW Makefiles\" "+cmake_string+DKPATH);
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=1 NDKLOG=1");
		}
		if(TYPE == "Release" || TYPE == "ALL"){
			if(LEVEL == "Rebuild" || LEVEL == "RebuildAll"){
				DKFile_Delete(DKPATH+"/"+appdir+"/"+APP+"/android64/Release/CMakeCache.txt");
			}
			DKFile_MkDir(DKPATH+"/"+appdir+"/"+APP+"/android64/Release");
			DKFile_ChDir(DKPATH+"/"+appdir+"/"+APP+"/android64/Release");
			var rtvalue = DK_Execute(CMAKE+" -G \"MinGW Makefiles\" "+cmake_string+DKPATH);
			if(rtvalue.indexOf("errors occurred!") > -1){ return; }
			
			DK_Execute(NDK+"/ndk-build.cmd NDK_DEBUG=0 NDKLOG=1")
		}
	}
	
	DKCreate("DKAudio");
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}
