#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DK/DKLog.h"
#include "DK/DKUtil.h"
#include "DKArchive/DKArchive.h"
#include "DKAssets/DKAssets.h"
#include <algorithm>

/////////////////////
bool DKAssets::Init()
{
	DKDEBUGFUNC();

	if(!DKAssets::GetAssetsPath(DKFile::local_assets)){ //Are we in a development environment?
		if(!DKAssets::GetDataPath(DKFile::local_assets)){ //Then, Does our default data folder exist?
			DKAssets::DeployAssets();
		}
	}

	DKFile::MakeDir(DKFile::local_assets+"USER");
	DKINFO("DKFile::local_assets = "+DKFile::local_assets+"\n");

	DKString file;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_FILE]", file);
	if(same(file, "OFF")) { log_file = false; }
	else{
#ifndef ANDROID
	//clear the log file
	std::ofstream file_log;
    DKString path = DKFile::local_assets+"log.txt";
	file_log.open(path.c_str(), std::ofstream::out | std::ofstream::trunc);
	file_log.close();
#endif		
	}

#ifdef WIN32
	DKString console;
	if (DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CONSOLE]", console)) {
		if(!same(console, "ON")){
			ShowWindow(GetConsoleWindow(), SW_HIDE);
		}
	}
#endif

	DKString debug;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_DEBUG]", debug);
	if(same(debug, "ON")) { log_debug = true; }

	DKString info;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_INFO]", info);
	if(same(info, "OFF")) { log_info = false; }

	DKString warnings;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_WARNINGS]", warnings);
	if(same(warnings, "OFF")) { log_warnings = false; }

	DKString errors;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_ERRORS]", errors);
	if(same(errors, "OFF")) { log_errors = false; }

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_SHOW]", log_show);
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_HIDE]", log_hide);

	DKString threads;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[LOG_THREAD]", threads);
	if (same(threads, "ON")) { log_thread = true; }
	
	DKString lines;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_LINES]", lines);
	if(same(lines, "ON")) { log_lines = true; }

	DKString funcs;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_FUNCS]", funcs);
	if(same(funcs, "ON")) { log_funcs = true; }
	
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[ONLINE_ASSETS]", DKFile::online_assets);
	if(DKFile::online_assets.empty()){
		//DKString app_name;
		//DKFile::GetExeName(app_name);
		//replace(app_name, ".exe", "");
		DKFile::online_assets = "http://aquawicket.github.io/DigitalKnob/DKPlugins/";
	}

	DKINFO("DKFile::online_assets = "+DKFile::online_assets+"\n");
	return true;
}

////////////////////////////////////////////
bool DKAssets::GetAssetsPath(DKString& path)
{
	DKDEBUGFUNC();
	//If there is an assets directory below the app directory, then we are in a development environment.
	//and we will point to that location for assets
	
#ifdef WIN32
	if (DKFile::PathExists(DKFile::app_path + "../assets/") && 
	    DKFile::PathExists(DKFile::app_path + "../DKCMake.txt")) {
		if (DKFile::GetAbsolutePath(DKFile::app_path + "../assets/", path)) {
			//SetDllDirectory(path.c_str()); //FIXME: get rid of this?
			return true;
		}
	}
	if (DKFile::PathExists(DKFile::app_path + "../../assets/") &&
		DKFile::PathExists(DKFile::app_path + "../../DKCMake.txt")) {
		if (DKFile::GetAbsolutePath(DKFile::app_path + "../../assets/", path)) {
			//SetDllDirectory(path.c_str()); //FIXME: get rid of this?
			return true;
		}
	}
	return false;
#endif
#ifdef MAC
	if (DKFile::PathExists(DKFile::app_path + "../../../../../assets/") && 
		DKFile::PathExists(DKFile::app_path + "../../../../../DKCMake.txt")) {
		if (DKFile::GetAbsolutePath(DKFile::app_path + "../../../../../assets/", path)) {
			return true;
		}
	}
	return false;
#endif
#ifdef IOS
	// /Users/aquawicket/Library/Application Support/iPhone Simulator/6.1/Applications/D4BEB636-716E-445D-8CD9-8722785D7EB7/Appname.app/Appname
	// /Users/aquawicket/Desktop/digitalknob/USER/DKApps/GuiTest/iossim32/Release-iphonesimulator/Appname.app/Appname
	std::size_t pos = DKFile::app_path.find("/Library");
	DKString userpath = DKFile::app_path.substr(0, pos);
	if(DKFile::PathExists(userpath + "/Desktop/digitalknob/DKApps/" + DKFile::app_name + "/assets/") && 
	   DKFile::PathExists(userpath + "/Desktop/digitalknob/DKApps/" + DKFile::app_name + "/DKCMake.txt")){
		path = userpath + "/Desktop/digitalknob/DKApps/" + DKFile::app_name + "/assets/";
		return true;
	}
	if(DKFile::PathExists(userpath + "/Desktop/digitalknob/USER/DKApps/" + DKFile::app_name + "/assets/") && 
	   DKFile::PathExists(userpath + "/Desktop/digitalknob/USER/DKApps/" + DKFile::app_name + "/DKCMake.txt")){
		path = userpath + "/Desktop/digitalknob/USER/DKApps/" + DKFile::app_name + "/assets/";
		return true;
	}
	return false;
#endif
#ifdef LINUX
	if (DKFile::PathExists(DKFile::app_path + "../../assets/") &&
		DKFile::PathExists(DKFile::app_path + "../../DKCMake.txt")) {
		if (DKFile::GetAbsolutePath(DKFile::app_path + "../../assets/", path)) {
			return true;
		}
	}
	return false;
#endif
	DKERROR("DKAssets::GetAssetsPath() not implemented on this platform \n");
	return false;
}

//////////////////////////////////////////
bool DKAssets::GetDataPath(DKString& path)
{
	DKDEBUGFUNC();

#ifdef WIN32
	DKString apppath;
	DKFile::GetAppPath(apppath);
	DKString appname;
	DKFile::GetAppName(appname);
	path = apppath+appname+"_Data/";
	if (DKFile::PathExists(path)) {
		return true;
	}
	DKFile::MakeDir(path);
	return false;
#endif
#ifdef ANDROID
	//TODO - folder should be named /appname_Data/
	//CallJavaFunction("getApplicationName", "");
	path = "/mnt/sdcard/"+DKFile::exe_path;
	return true;
#endif
#ifdef MAC
    path = DKFile::exe_path;
    unsigned n = path.find_last_of("/");
    path.erase (path.begin()+n+1, path.end());
	replace(path, "/MacOS", "/Resources");
	return true;
#endif
#ifdef IOS //FIXME - double check that iOS doesn't have the MAC preprocessor definition.
	path = DKFile::exe_path;
    unsigned n = path.find_last_of("/");
    path.erase(path.begin()+n+1, path.end());
	path += "assets";
	return true;
#endif
#ifdef LINUX
	DKString apppath;
	DKFile::GetAppPath(apppath);
	DKString appname;
	DKFile::GetAppName(appname);
	path = apppath + appname + "_Data/";
	if (DKFile::PathExists(path)) {
		return true;
	}
	DKFile::MakeDir(path);
	return false;
#endif
	
	DKERROR("DKAssets::GetDataPath() not implemented on this OS \n");
	return false;
}

////////////////////////////////////////////////////////////////////////
bool DKAssets::PackageAssets(DKString& dataFolder, DKString& headerFile)
{
	DKDEBUGFUNC(dataFolder, headerFile);
#if !defined(WIN32)
	if (!DKArchive::Compress(dataFolder, dataFolder + "/../assets.zip")) {
		return false;
	}
	if (!DKUtil::Bin2C(dataFolder + "/../assets.zip", headerFile)) {
		return false;
	}
	//DKFile::Delete(dataFolder + "/../assets.zip"); //delete lingering zip file;

	//alter assets.h file (the memory intensive way :P)
	/*
	DKString assets_string;
	DKFile::FileToString(headerFile, assets_string);
	replace(assets_string, "\n", "");
	replace(assets_string, "\r", "");
	replace(assets_string, " ", "");
	std::remove_if(assets_string.begin(), assets_string.end(), isspace);
	assets_string += "#if defined(USE_DKAssets) && !defined(ANDROID)\n" + assets_string;
	assets_string += "#endif\n\n";
	assets_string += "void CopyAssets(){\n";
	assets_string += "#if defined(USE_DKAssets) && !defined(ANDROID)\n";
	assets_string += "DKCreate(\"DKAssets\");\n";
	assets_string += "DKAssets::CopyAssets(assets, assets_size);\n";
	assets_string += "#endif\n";
	assets_string += "}";
	DKFile::StringToFile(assets_string, headerFile);
	*/
	return true;
	
#endif
	return false;
}

/////////////////////////////
bool DKAssets::DeployAssets()
{
	DKDEBUGFUNC();
	DKINFO("Deploying assets . . .\n");
	
	//Save User data
	DKINFO("Backing up USER data . . .\n");
	if(DKFile::PathExists(DKFile::local_assets + "USER")){
		DKFile::CopyFolder(DKFile::local_assets + "USER", DKFile::local_assets + "../USER", true, true);
	}
	DKFile::Delete(DKFile::local_assets); //remove assets folder completely 

#if !defined(ANDROID) && !defined(WIN32)
	DKINFO("Extracting assets from binary executable . . .\n");	
	DKFile::MakeDir(DKFile::local_assets);
	DKString fileOut = DKFile::local_assets+"assets.zip";
	DKUtil::C2Bin(ASSETS_H, ASSETS_H_SIZE, fileOut.c_str());
	DKArchive::Extract(DKFile::local_assets+"assets.zip", DKFile::local_assets);
	DKFile::Delete(DKFile::local_assets+"assets.zip"); //delete lingering zip file;
#endif

//Windows will use the resources interface
#ifdef WIN32
	DKINFO("Extracting assets from executable windows resources . . .\n");	
	HGLOBAL hResourceLoaded;		// handle to loaded resource 
	HRSRC hRes;					// handle/ptr. to res. info. 
	char *lpResLock;				// pointer to resource data 
	DWORD dwSizeRes;

	DKFile::MakeDir(DKFile::local_assets);
	DKString strOutputLocation = DKFile::local_assets+"assets.zip";
	hRes = FindResource(NULL, MAKEINTRESOURCE(321), RT_RCDATA); // find location of the resource and get handle to it
	hResourceLoaded = LoadResource(NULL, hRes); // loads the specified resource into global memory. 
	lpResLock = (char*)LockResource(hResourceLoaded); // get a pointer to the loaded resource!
	dwSizeRes = SizeofResource(NULL, hRes); // determine the size of the resource, so we know how much to write out to file!  
	std::ofstream outputFile(strOutputLocation.c_str(), std::ios::binary);
	outputFile.write((const char*)lpResLock, dwSizeRes);
	outputFile.close();
	DKArchive::Extract(DKFile::local_assets+"assets.zip", DKFile::local_assets);
	DKFile::Delete(DKFile::local_assets+"assets.zip"); //delete lingering zip file;

	//if the data path contains an assets folder, move it's contents to the root.
	//if(DKFile::PathExists(DKFile::local_assets+"assets")){
	//	DKFile::Copy(DKFile::local_assets+"assets/", DKFile::local_assets, true, true); //FIXME: This is not copying .dll files
	//	DKFile::Delete(DKFile::local_assets+"assets");
	//}
#endif

#ifdef ANDROID
	DKERROR("DKAssets::DeployAssets() is not implemented on android yet"); //NOTE: we have a CopyAssets() function for android somewhere
#endif

	//Restore User data
	DKFile::MakeDir(DKFile::local_assets+"USER");
	if (DKFile::PathExists(DKFile::local_assets+"../USER")){
		DKINFO("Restoring USER data . . .\n");	
		DKFile::CopyFolder(DKFile::local_assets+"../USER", DKFile::local_assets+"USER", true, true);
		DKFile::Delete(DKFile::local_assets+"../USER");
	}
	return true;
}
