var OS = "";   //win32,win64,mac32,mac64,linux32,linux64,ios32,ios64,iossim32,iossim64,android32,android64
var APP = "";  //DKAppname
var TYPE = "";  //Debug, Release, ALL
var LINK = "";  //Static, Dynamic
var LEVEL = "";  //Build, Rebuild, RebuildAll
var DKPATH = "";
var SVN = "";
var GIT = "";
var CMAKE = "";
var NDK = "C:/android-ndk-r10d";
var VC2015 = "C:/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe";
var GCC = "/usr/bin/g++";
var XCODE = "/Applications/Xcode.app";
var APP_LIST = [];


///////////////////////
function DKBuild_Init()
{
	//DKLog("DKBuild_Init() \n", DKDEBUG);
	DKCreate("DKThreadPool");
	DKCreate("DKCurl");

	//DKLog(DK_GetOS()+"\n", DKDEBUG);
	if(DK_GetOS() == "Win32"){
		DKPATH = "C:/digitalknob";
		SVN = "C:/Program Files/Subversion/bin/svn.exe";
		SVN = DKFile_GetShortName(SVN);
		GIT = "C:/Program Files/Git/bin/git.exe";
		GIT = DKFile_GetShortName(GIT);
		CMAKE = "C:/Program Files/CMake/bin/cmake.exe";
		CMAKE = DKFile_GetShortName(CMAKE);
	}
	if(DK_GetOS() == "Win64"){
		DKPATH = "C:/digitalknob";
		SVN = "C:/Program Files (x86)/Subversion/bin/svn.exe";
		SVN = DKFile_GetShortName(SVN);
		GIT = "C:/Program Files/Git/bin/git.exe";
		GIT = DKFile_GetShortName(GIT);
		CMAKE = "C:/Program Files (x86)/CMake/bin/cmake.exe";
		CMAKE = DKFile_GetShortName(CMAKE);
	}
	if(DK_GetOS() == "Mac"){
		DKPATH = "/Users/aquawicket/Desktop/digitalknob";
		GIT = "git";
		SVN = "svn";
		CMAKE = "/Applications/CMake.app/Contents/bin/cmake";
	}
	if(DK_GetOS() == "Linux"){
		DKPATH = "/home/aquawicket/Desktop/digitalknob";
		SVN = "/usr/bin/svn";
		GIT = "/usr/bin/git";
		CMAKE = "/usr/bin/cmake";
	}

	if(DKAvailable("DKWidget")){
		DKCreate("DKBuild/DKBuildGUI.js", function(){});
	}
	else{
		DKCreate("DKBuild/DKBuildConsole.js", function(){});
	}
}

//////////////////////////////
function DKBuild_ValidateSvn()
{
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Looking for SVN \n", DKINFO);
	//DKLog(SVN+"\n", DKDEBUG);
	if(!DKFile_Exists(SVN)){
		DKLog("Please install SVN \n", DKINFO);
		DKBuild_InstallSvn();
	}
	DKLog("Found SVN \n", DKINFO);
	if(DK_GetOS() == "Mac"){
		SVN = "svn";
	}
}

/////////////////////////////
function DKBuild_InstallSvn()
{
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Installing Svn \n", DKINFO);
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
		DKLog("ERROR: unrecognied HOST OS: "+DK_GetOS(), DKERROR);
	}
}

//////////////////////////////
function DKBuild_ValidateGit()
{
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Looking for GIT \n", DKINFO);
	//DKLog(GIT+"\n", DKDEBUG);
	if(!DKFile_Exists(GIT)){
		DKLog("Please install GIT \n", DKINFO);
		DKBuild_InstallGit();
	}
	DKLog("Found GIT \n", DKINFO);
	if(DK_GetOS() == "Mac"){
		GIT = "git";
	}
}

/////////////////////////////
function DKBuild_InstallGit()
{
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Installing Git \n", DKINFO);
	var assets = DKAssets_LocalAssets();
	
	if(DK_GetOS() == "Win32"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Git-2.11.0-32-bit.exe", assets);
		DK_System(assets+"/Git-2.11.0-32-bit.exe");
	}
	else if(DK_GetOS() == "Win64"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/Git-2.11.0-64-bit.exe", assets);
		DK_System(assets+"/Git-2.11.0-64-bit.exe");
	}
	else if(DK_GetOS() == "Mac"){
		//TODO
	}
	else if(DK_GetOS() == "Linux"){
		DK_Execute("sudo apt-get install git");
	}
	else{
		DKLog("ERROR: unrecognied HOST OS: "+DK_GetOS(), DKERROR);
	}
}

////////////////////////////////
function DKBuild_ValidateCmake()
{
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Looking for CMake \n", DKINFO);
	//DKLog(CMAKE+"\n", DKDEBUG);
	if(!DKFile_Exists(CMAKE)){
		DKLog("Please install CMake \n", DKINFO);
		DKBuild_InstallCmake();
	}
	DKLog("Found CMake \n", DKINFO);
	if(DK_GetOS() == "Mac"){
		CMAKE = "cmake";
	}
}

///////////////////////////////
function DKBuild_InstallCmake()
{
	DKLog("Installing CMake \n", DKINFO);
	var datapath = DKAssets_LocalAssets();
	
	if(DK_GetOS() == "Win32"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/cmake-3.3.2-win32-x86.exe", datapath);
		DK_System(datapath+"/cmake-3.3.2-win32-x86.exe");
	}
	else if(DK_GetOS() == "Win64"){
		DKCurl_Download("http://DigitalKnob.com/Download/Tools/cmake-3.3.2-win32-x86.exe", datapath);
		DK_System(datapath+"/cmake-3.3.2-win32-x86.exe");
	}
	else if(DK_GetOS() == "Mac"){
		//TODO
	}
	else if(DK_GetOS() == "Linux"){
		DK_Execute("sudo apt-get install cmake");
	}
	else{
		DKLog("ERROR: unrecognied HOST OS: "+DK_GetOS(), DKERROR);
	}
}

/////////////////////////////////
function DKBuild_ValidateVC2015()
{
	if(DK_GetBrowser() != "Rocket"){ return; }
	if(DK_GetOS() != "Win32" && DK_GetOS() != "Win64"){
		return;
	}
	DKLog("Looking for Visual Studio 2015 \n", DKINFO);
	//DKLog(VC2015+"\n", DKDEBUG);
	if(!DKFile_Exists(VC2015)){
		DKBuild_InstallVC2015();
	}
	DKLog("Found Visual Studio 2015 \n", DKINFO);
}

////////////////////////////////
function DKBuild_InstallVC2015()
{
	DKLog("Installing Visual Studio 2015 \n", DKINFO);
	var datapath = DKAssets_LocalAssets();
	
	DKCurl_Download("http://DigitalKnob.com/Download/Tools/vs_community_ENU__908841471.1484716364.exe", datapath);
	DK_System(datapath+"/vvs_community_ENU__908841471.1484716364.exe");
}

//////////////////////////////
function DKBuild_ValidateGcc()
{
	if(DK_GetOS() != "Linux"){ return; }
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Looking for GCC \n", DKINFO);
	//DKLog(GCC+"\n", DKDEBUG);
	if(!DKFile_Exists(GCC)){
		DKLog("Please install GCC \n", DKINFO);
		DKBuild_InstallGcc();
	}
	DKLog("Found Gcc \n", DKINFO);
}

///////////////////////////////
function DKBuild_InstallGcc()
{
	DKLog("Installing Gcc \n", DKINFO);
	DK_Execute("sudo apt-get update && sudo apt-get install build-essential");
}

////////////////////////////////
function DKBuild_ValidateXcode()
{
	if(DK_GetOS() != "Mac"){ return; }
	if(DK_GetBrowser() != "Rocket"){ return; }
	DKLog("Looking for Xcode \n", DKINFO);
	//DKLog(XCODE+"\n", DKDEBUG);
	if(!DKFile_Exists(XCODE)){
		DKLog("Please install Xcode \n", DKINFO);
		DKBuild_InstallXcode();
	}
	DKLog("Found Xcode \n", DKINFO);
}
///////////////////////////////
function DKBuild_InstallXcode()
{
	DKLog("Installing Xcode \n", DKINFO);
	var datapath = DKAssets_LocalAssets();
	DKCurl_Download("http://DigitalKnob.com/Download/Tools/xcode4630916281a.dmg", datapath);
}

//////////////////////////
function DKBuild_OsCheck()
{
	if(DK_GetOS() == "Win32"){
		if(OS == "win64"){
			DKLog(OS+" can only be build from a WIN64 machine.\n", DKINFO); return false;
		}
		if(OS == "mac"){
			DKLog(OS+" can only be build from an OSX machine.\n", DKINFO); return false;
		}
		if(OS == "ios"){
			DKLog(OS+" can only be build from an OSX machine.\n", DKINFO); return false;
		}
		if(OS == "ios-simulator"){
			DKLog(OS+" can only be build from an OSX machine.\n", DKINFO); return false;
		}
		if(OS == "linux"){
			DKLog(OS+" can only be build from a LINUX machine.\n", DKINFO); return false;
		}
	}
	if(DK_GetOS() == "Win64"){
		if(OS == "mac"){
			DKLog(OS+" can only be build from an OSX machine.\n", DKINFO); return false;
		}
		if(OS == "ios"){
			DKLog(OS+" can only be build from an OSX machine.\n", DKINFO); return false;
		}
		if(OS == "ios-simulator"){
			DKLog(OS+" can only be build from an OSX machine.\n", DKINFO); return false;
		}
		if(OS == "linux"){
			DKLog(OS+" can only be build from a LINUX machine.\n", DKINFO); return false;
		}
	}
	if(DK_GetOS() == "Mac"){
		if(OS == "win32"){
			DKLog(OS+" can only be build from a Windows machine.\n", DKINFO); return false;
		}
		if(OS == "win64"){
			DKLog(OS+" can only be build from an WIN64 machine.\n", DKINFO); return false;
		}
		if(OS == "linux"){
			DKLog(OS+" can only be build from a linux machine.\n", DKINFO); return false;
		}
		if(OS == "andoroid"){
			DKLog(OS+" can only be build from a Windows machine.\n", DKINFO); return false;
		}
	}
	if(DK_GetOS() == "Linux"){
		if(OS == "win32"){
			DKLog(OS+" can only be build from a Windows machine.\n", DKINFO); return false;
		}
		if(OS == "win64"){
			DKLog(OS+" can only be build from an WIN64 machine.\n", DKINFO); return false;
		}
		if(OS == "mac"){
			DKLog(OS+" can only be build from an OSX machine.\n", DKINFO); return false;
		}
		if(OS == "ios"){
			DKLog(OS+" can only be build from an OSX machine.\n", DKINFO); return false;
		}
		if(OS == "ios-simulator"){
			DKLog(OS+" can only be build from an OSX machine.\n", DKINFO); return false;
		}
		if(OS == "andoroid"){
			DKLog(OS+" can only be build from a Windows machine.\n", DKINFO); return false;
		}
	}
	if(DK_GetOS() == "Android"){
		DKLog("Android is not capable of compiling DKApps..  please use a desktop system.\n", DKINFO); return false;
	}
	if(DK_GetOS() == "iOS"){
		DKLog("iOS is not capable of compiling DKApps..  please use a desktop system.\n", DKINFO); return false;
	}
	return true;
}

////////////////////////////
function DKBuild_SvnUpdate()
{
	DKLog("Svn Update... \n", DKINFO);
	DK_Execute(SVN +" cleanup "+DKPATH);
	DK_Execute(SVN +" checkout https://github.com/aquawicket/DigitalKnob/trunk/ "+DKPATH);
	
	var mysvn = DKAssets_LocalAssets()+"mysvn.txt";
	if(!DKFile_Exists(mysvn)){ mysvn = DKPATH+"/mysvn.txt"; } //check for /mysvn.txt
	if(DKFile_Exists(mysvn)){
		var url = DKFile_GetSetting(mysvn, "[MYSVN]");
		DK_Execute(SVN +" checkout "+url+" "+DKPATH+"/USER");
	}
	
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
	DKLog("Svn Commit... \n", DKINFO);
	DK_Execute(SVN +" cleanup "+DKPATH);
	DK_Execute(SVN +" commit -m update "+DKPATH);
	
	if(DKFile_Exists(DKPATH+"/USER")){
		DK_Execute(SVN +" commit -m update "+DKPATH+"/USER");
	}
	
	if(DKAvailable("DKAudio")){
		DKCreate("DKAudio");
	}
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}

////////////////////////////
function DKBuild_GitUpdate()
{
	DKLog("Git Update... \n", DKINFO);
	DK_Execute(GIT +" clone https://github.com/aquawicket/DigitalKnob.git "+DKPATH);
	DKFile_ChDir(DKPATH);
	DK_Execute(GIT +" checkout -- .");
	DK_Execute(GIT +" pull origin master");
	
	var mygit = DKAssets_LocalAssets()+"mysvn.txt";
	if(!DKFile_Exists(mygit)){ mygit = DKPATH+"/mysvn.txt"; } //check for /mysvn.txt
	if(DKFile_Exists(mygit)){
		var url = DKFile_GetSetting(mygit, "[MYGIT]");
		DKFile_ChDir(DKPATH+"/USER");
		DK_Execute(GIT +" clone "+url+" "+DKPATH+"/USER");
		DK_Execute(GIT +" checkout -- .");
		DK_Execute(GIT +" pull origin master");
	}
	
	if(DKAvailable("DKAudio")){
		DKCreate("DKAudio");
	}
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}

////////////////////////////
function DKBuild_GitCommit()
{
	DKLog("Git Commit... \n", DKINFO);
	//DKBuild_GitUpdate(); //first update  this does not work, changed files are reverted
	DKFile_ChDir(DKPATH);
	DK_Execute(GIT +" init");
	DK_Execute(GIT +" config user.name \"dkuser\"");
	DK_Execute(GIT +" config user.email \"dkuser@digitalknob.com\"");
	
	DK_Execute(GIT +" commit -a -m \"commit from git\"");
	DK_Execute(GIT +" push");
	
	if(DKFile_Exists(DKPATH+"/USER")){
		DKFile_ChDir(DKPATH+"/USER");
		DK_Execute(GIT +" init");
		DK_Execute(GIT +" config user.name \"dkuser\"");
		DK_Execute(GIT +" config user.email \"dkuser@digitalknob.com\"");
	
		DK_Execute(GIT +" commit -a -m \"commit from git\"");
		DK_Execute(GIT +" push");
	}
	
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
	DKLog("Deleting Apps and Plugins... \n", DKINFO);
	
	// Delete everything in DKApps except DKBuild
	var apps = DKFile_DirectoryContents(DKPATH+"/DKApps");
	var list = apps.split(',');
	for(var i=0; i<list.length; ++i){
		if(list[i] == "DKBuilder"){ continue; }
		//DKLog("Deleting "+DKPATH+"/DKApps/"+list[i]+"\n", DKDEBUG);
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
	DKLog("Deleting 3rdParty... \n", DKINFO);
	DKLog("Please wait. \n", DKINFO);
	DKFile_Delete(DKPATH+"/3rdParty");
}

/////////////////////////////
function DKBuild_GetAppList()
{
	//DKLog("DKBuild_GetAppList() \n", DKDEBUG);
	var apps = DKFile_DirectoryContents(DKPATH+"/DKApps");
	//DKLog("DKBuild_GetAppList() apps = "+apps+"\n", DKDEBUG);
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
			//DKLog(MYAPP_LIST[i]+"\n", DKDEBUG);
			if(!DKFile_IsDirectory(DKPATH+"/USER/DKApps/"+MYAPP_LIST[i]) || MYAPP_LIST[i] == ".svn"){
				MYAPP_LIST.splice(i, 1);
				i=0;
			}
		}
		APP_LIST = APP_LIST.concat(MYAPP_LIST);
	}
	
	/*
	DKLog("*****************\n", DKDEBUG);
	for(var i=0; i<APP_LIST.length; i++){
		DKLog(APP_LIST[i]+"\n", DKDEBUG);
	}
	*/
}

////////////////////////////
function DKBuild_DoResults()
{
	DKLog("DKBuild_DoResults(): OS="+OS+" APP="+APP+" TYPE="+TYPE+" LEVEL="+LEVEL+"\n", DKDEBUG);
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
	if(DKFile_Exists(DKPATH+"/USER/DKApps/"+APP)){
		appdir = "USER/DKApps";
	}
	
	//Create icons
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
		
		//copy .pdb file to assets
		DKFile_Copy(DKPATH+"/"+appdir+"/"+APP+"/"+OS+"/Release/"+APP+".pdb", DKPATH+"/DKApps/"+APP+"/assets/"+APP+".pdb", true);
		
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
	
	//// LINUX32 ///////
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
	
	//// LINUX64 ///////
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

			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/linux64/Debug/"+APP+".desktop")
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
			
			//Create .desktop file
			var string = "[Desktop Entry]\n";
			string += "Encoding=UTF-8\n";
			string += "Version=1.0\n";
			string += "Type=Application\n";
			string += "Terminal=true\n";
			string += "Name="+APP+"\n";
			string += "Exec="+DKPATH+"/"+appdir+"/"+APP+"/linux64/Release/"+APP+"\n";
			string += "Icon="+DKPATH+"/"+appdir+"/"+APP+"/icons/icon.png\n";
			DKFile_StringToFile(string, DKPATH+"/"+appdir+"/"+APP+"/linux64/Release/"+APP+".desktop")
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
	
	if(DKAvailable("DKAudio")){
		DKCreate("DKAudio");
	}
	if(DKValid("DKAudioJS,DKAudioJS0")){
		DKAudio_PlaySound("DKBuild/ding.wav");
	}
}
