/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DK/DKLog.h"
#include "DK/DKUtil.h"
#if HAVE_DKArchive
	#include "DKArchive/DKArchive.h"
#endif
#include "DKAssets/DKAssets.h"

//WARNING_DISABLE
#include <algorithm>
#include <fstream>
//WARNING_ENABLE

bool DKAssets::Init(){
	DKDEBUGFUNC();
	//DKClass::DKCreate("DKAssetsJS");
	//DKClass::DKCreate("DKAssetsV8");
	
	if(!DKAssets::GetAssetsPath(DKFile::local_assets)){ //Are we in a development environment?
		if(!DKAssets::GetDataPath(DKFile::local_assets)) //Then, Does our default data folder exist?
			DKAssets::DeployAssets();
	}

#if !IOS
	DKFile::MakeDir(DKFile::local_assets+"USER");
#endif
	DKINFO("DKFile::local_assets = "+DKFile::local_assets+"\n");

	DKString file;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_FILE]", file);
	if(same(file, "OFF")){
		DKLog::log_file = false;
	}
	else{
//#if !ANDROID
	//clear the log file
	//std::ofstream file_log;
    //DKString path = DKFile::local_assets+"log.txt";
	//file_log.open(path.c_str(), std::ofstream::out | std::ofstream::trunc);
	//file_log.close();
//#endif		
	}

#if WIN32
	DKString console;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CONSOLE]", console);
#	if DEBUG
		if(!same(console, "OFF"))
			ShowWindow(GetConsoleWindow(), SW_SHOW);
#	else
		if(!same(console, "ON"))
			ShowWindow(GetConsoleWindow(), SW_HIDE);
#	endif
#endif

	DKString debug;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_DEBUG]", debug);
#if DEBUG
	if(!same(debug, "OFF"))
		DKLog::log_debug = true;
#else
	if(same(debug, "ON"))
		DKLog::log_debug = true;
#endif

	DKString info;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_INFO]", info);
	if(same(info, "OFF"))
		DKLog::log_info = false;

	DKString warnings;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_WARNINGS]", warnings);
	if(same(warnings, "OFF"))
		DKLog::log_warnings = false;

	DKString errors;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_ERRORS]", errors);
	if(same(errors, "OFF"))
		DKLog::log_errors = false;
	
	DKString stacktraceonerrors;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[STACKTRACE_ON_ERRORS]", stacktraceonerrors);
#if DEBUG
	if(!same(stacktraceonerrors, "OFF"))
		DKLog::stacktrace_on_errors = true;
#else
	if(same(stacktraceonerrors, "ON"))
		DKLog::stacktrace_on_errors = true;
#endif

	DKString exceptiononerrors;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[EXCEPTION_ON_ERRORS]", exceptiononerrors);
	if(same(exceptiononerrors, "ON"))
		DKLog::exception_on_errors = true;

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_SHOW]", DKLog::log_show);
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_HIDE]", DKLog::log_hide);

	DKString threads;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[LOG_THREAD]", threads);
#if DEBUG
	if (!same(threads, "OFF"))
		DKLog::log_thread = true;
#else
	if (same(threads, "ON"))
		DKLog::log_thread = true;
#endif
	
	DKString lines;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_LINES]", lines);
#if DEBUG
	if(!same(lines, "OFF"))
		DKLog::log_lines = true;
#else
	if(same(lines, "ON"))
		DKLog::log_lines = true;
#endif

	DKString funcs;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_FUNCS]", funcs);
#if DEBUG
	if(!same(funcs, "OFF"))
		DKLog::log_funcs = true;
#else
	if(same(funcs, "ON"))
		DKLog::log_funcs = true;
#endif
	
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[ONLINE_ASSETS]", DKFile::online_assets);
	if(DKFile::online_assets.empty())
		DKFile::online_assets = "http://aquawicket.github.io/DigitalKnob/DKPlugins/";

	DKINFO("DKFile::online_assets = "+DKFile::online_assets+"\n");
	//DKINFO("Loaded -> "+DKFile::online_assets+"settings.txt\n");
	return true;
}

bool DKAssets::End(){
	DKDEBUGFUNC();
	//DKClass::DKClose("DKAssetsJS");
	//DKClass::DKClose("DKAssetsV8");
	return true;
}

bool DKAssets::GetAssetsPath(DKString& path){
	DKDEBUGFUNC(path);
	//If there is an assets directory below the app directory, then we are in a development environment.
	//and we will point to that location for assets
	
#if WIN32
	if (DKFile::PathExists(DKFile::app_path + "../assets/") && 
	    DKFile::PathExists(DKFile::app_path + "../DKMAKE.cmake")) {
		if (DKFile::GetAbsolutePath(DKFile::app_path + "../assets/", path)) {
			//SetDllDirectory(path.c_str()); //FIXME: get rid of this?
			return true;
		}
	}
	if (DKFile::PathExists(DKFile::app_path + "../../assets/") &&
		DKFile::PathExists(DKFile::app_path + "../../DKMAKE.cmake")) {
		if (DKFile::GetAbsolutePath(DKFile::app_path + "../../assets/", path)) {
			//SetDllDirectory(path.c_str()); //FIXME: get rid of this?
			return true;
		}
	}
	return false;
#elif MAC
	if (DKFile::PathExists(DKFile::app_path + "../../../../../assets/") && 
		DKFile::PathExists(DKFile::app_path + "../../../../../DKMAKE.cmake")) {
		if (DKFile::GetAbsolutePath(DKFile::app_path + "../../../../../assets/", path)) {
			return true;
		}
	}
	return false;
#elif IOS
    std::string::size_type pos = DKFile::app_path.find("/Library");
    DKString userpath = DKFile::app_path.substr(0, pos);
    DKStringArray folders;
    DKFile::GetDirectoryContents(userpath + "/digitalknob", folders);
    for(int i=0; i<folders.size(); ++i){
        if(DKFile::PathExists(userpath + "/digitalknob/"+folders[i]+"/DKApps/" + DKFile::app_name + "/assets/") &&
            DKFile::PathExists(userpath + "/digitalknob/"+folders[i]+"/DKApps/" + DKFile::app_name + "/DKMAKE.cmake")){
            path = userpath + "/digitalknob/"+folders[i]+"/DKApps/" + DKFile::app_name + "/assets/";
            return true;
        }
    }
	return false;
#elif LINUX
	if (DKFile::PathExists(DKFile::app_path + "../../assets/") && DKFile::PathExists(DKFile::app_path + "../../DKMAKE.cmake")) {
		if (DKFile::GetAbsolutePath(DKFile::app_path + "../../assets/", path))
			return true;
	}
	return false;
#elif EMSCRIPTEN
	path = "/";
	return true;
#else
	return DKERROR("not implemented on this OS \n");
#endif
}

bool DKAssets::GetDataPath(DKString& path){
	DKDEBUGFUNC(path);
#if WIN32
	DKString apppath;
	DKFile::GetAppPath(apppath);
	DKString appname;
	DKFile::GetAppName(appname);
	path = apppath+appname+"_Data/";
	if (DKFile::PathExists(path))
		return true;
	DKFile::MakeDir(path);
	return false;
#elif ANDROID
	//TODO - folder should be named /appname_Data/
	//CallJavaFunction("getApplicationName", "");
	//path = "/mnt/sdcard/"+DKFile::exe_path;
	//path = DKFile::exe_path+"/assets/";
	
	path = DKFile::exe_path +"/assets/";
	return true;
#elif MAC
    path = DKFile::exe_path;
    std::string::size_type n = path.find_last_of("/");
    path.erase (path.begin()+n+1, path.end());
	replace(path, "/MacOS", "/Resources");
	return true;
#elif IOS //FIXME - double check that iOS doesn't have the MAC preprocessor definition.
	path = DKFile::exe_path;
    std::string::size_type n = path.find_last_of("/");
    path.erase(path.begin()+n+1, path.end());
	path += "assets/";
	return true;
#elif LINUX
	DKString apppath;
	DKFile::GetAppPath(apppath);
	DKString appname;
	DKFile::GetAppName(appname);
	path = apppath + appname + "_Data/";
	if (DKFile::PathExists(path))
		return true;
	DKFile::MakeDir(path);
	return false;
#elif EMSCRIPTEN
	path = "/";
	return true;
#else
	return DKERROR("not implemented on this OS \n");
#endif
}

bool DKAssets::PackageAssets(DKString& dataFolder, DKString& headerFile){
	DKDEBUGFUNC(dataFolder, headerFile);
#if !WIN
	#if HAVE_DKArchive
		if(!DKArchive::Compress(dataFolder, dataFolder + "/../assets.zip"))
			return DKERROR("DKArchive::Compress() failed! \n");
	#endif
	if (!DKUtil::Bin2C(dataFolder + "/../assets.zip", headerFile))
		return DKERROR("DKUtil::Bin2C() failed! \n");
	//DKFile::Delete(dataFolder + "/../assets.zip"); //delete lingering zip file;
	//alter assets.h file (the memory intensive way :P)
	/*
	DKString assets_string;
	DKFile::FileToString(headerFile, assets_string);
	replace(assets_string, "\n", "");
	replace(assets_string, "\r", "");
	replace(assets_string, " ", "");
	std::remove_if(assets_string.begin(), assets_string.end(), isspace);
	assets_string += "#if HAVE_DKAssets && !ANDROID\n" + assets_string;
	assets_string += "#endif\n\n";
	assets_string += "void CopyAssets(){\n";
	assets_string += "#if HAVE_DKAssets && !ANDROID\n";
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

bool DKAssets::DeployAssets(){
	DKDEBUGFUNC();
	DKINFO("Deploying assets . . .\n");
	
	//Save User data
	DKINFO("Backing up USER data . . .\n");
	if(DKFile::PathExists(DKFile::local_assets + "USER"))
		DKFile::CopyFolder(DKFile::local_assets + "USER", DKFile::local_assets + "../USER", true, true);
	DKFile::Delete(DKFile::local_assets); //remove assets folder completely 

#if !ANDROID && !WIN
	DKINFO("Extracting assets from binary executable . . .\n");	
	DKFile::MakeDir(DKFile::local_assets);
	DKString fileOut = DKFile::local_assets+"assets.zip";
	DKUtil::C2Bin(ASSETS_H, ASSETS_H_SIZE, fileOut.c_str());
	#if HAVE_DKArchive
		DKArchive::Extract(DKFile::local_assets+"assets.zip", DKFile::local_assets);
	#endif
	DKFile::Delete(DKFile::local_assets+"assets.zip"); //delete lingering zip file;
#endif

//Windows will use the resources interface
#if WIN32
	DKINFO("Extracting assets from executable windows resources . . . \n");	
	HGLOBAL hResourceLoaded;	// handle to loaded resource 
	HRSRC hRes;					// handle/ptr. to res. info. 
	char *lpResLock;			// pointer to resource data 
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
#if HAVE_DKArchive
	DKArchive::Extract(DKFile::local_assets+"assets.zip", DKFile::local_assets);
#endif
	DKFile::Delete(DKFile::local_assets+"assets.zip"); //delete lingering zip file;

	//if the data path contains an assets folder, move it's contents to the root.
	//if(DKFile::PathExists(DKFile::local_assets+"assets")){
	//	DKFile::Copy(DKFile::local_assets+"assets/", DKFile::local_assets, true, true); //FIXME: This is not copying .dll files
	//	DKFile::Delete(DKFile::local_assets+"assets");
	//}
#endif

#if ANDROID
	DKERROR("not implemented this OS \n"); //NOTE: we have a CopyAssets() function for android somewhere
#endif

	//Restore User data
	DKFile::MakeDir(DKFile::local_assets+"USER");
	if(DKFile::PathExists(DKFile::local_assets+"../USER")){
		DKINFO("Restoring USER data . . .\n");	
		DKFile::CopyFolder(DKFile::local_assets+"../USER", DKFile::local_assets+"USER", true, true);
		DKFile::Delete(DKFile::local_assets+"../USER");
	}
	return true;
}
