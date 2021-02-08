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
	DKString datapath;

	DKAssets::AquireDataPath(datapath);
	if(DKAssets::CheckAssetsPath(datapath)){
		DKFile::MakeDir(DKFile::local_assets+"USER");
	}
	else{
		DKAssets::DeployAssets(NULL, NULL);
	}

//#ifdef WIN32
	//DKAssets::DeployAssets(NULL, NULL);
//#endif

	DKINFO("DKFile::local_assets = "+DKFile::local_assets+"\n");

	DKString file;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[LOG_FILE]", file);
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
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[CONSOLE]", console);
	if(!same(console, "ON")){
		ShowWindow(GetConsoleWindow(), SW_HIDE);
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
		DKString app_name;
		DKFile::GetExeName(app_name);
		replace(app_name, ".exe", "");
		//DKFile::online_assets = "http://digitalknob.com/"+app_name;
		DKFile::online_assets = "http://aquawicket.github.io/DigitalKnob/DKPlugins/";
	}

	DKINFO("DKFile::online_assets = "+DKFile::online_assets+"\n");
	return true;
}

////////////////////////////////////////////////
bool DKAssets::AquireDataPath(DKString& exepath)
{
	DKDEBUGFUNC(exepath);
    unsigned found = 0;
#ifdef WIN32
    exepath = DKFile::exe_path;
	if (exepath.empty()){
		TCHAR appfilename[MAX_PATH];
		GetModuleFileName(NULL, appfilename, MAX_PATH);
		exepath = appfilename;
	}
	DKString appname;
	DKFile::GetExeName(appname);
	DKFile::RemoveExtention(appname);
	found = exepath.find_last_of("\\");
    exepath.erase (exepath.begin()+found+1, exepath.end());
	exepath += appname+"\\";
	replace(exepath, "\\\\", "\\");
	return true;
#elif defined(ANDROID)
	//TODO - folder should be the name of the app
	//CallJavaFunction("getApplicationName", "");
	exepath = "/mnt/sdcard/"+DKFile::exe_path+"/";
	return true;
#elif defined(MAC)
    exepath = DKFile::exe_path;
    found = exepath.find_last_of("/");
    exepath.erase (exepath.begin()+found+1, exepath.end());
	replace(exepath, "/MacOS", "/Resources");
	return true;
#elif defined(IOS) //FIXME - this will never happen, look at the #elif above.
	exepath = DKFile::exe_path;
    found = exepath.find_last_of("/");
    exepath.erase (exepath.begin()+found+1, exepath.end());
	exepath += "assets/";
	return true;
#elif defined(LINUX)
	exepath = DKFile::exe_path;
	DKString appname;
	DKFile::GetExeName(appname);
	DKFile::RemoveExtention(appname);
	found = exepath.find_last_of("/");
	exepath.erase (exepath.begin()+found+1, exepath.end());
	exepath += appname+"-Data/";
	return true;
#endif
	
	DKERROR("DKFile::AquireDataPath() not implemented on this OS \n");
	return false;
}

////////////////////////////////////////////////////
bool DKAssets::CheckAssetsPath(const DKString& path)
{
	DKDEBUGFUNC(path);
	DKFile::local_assets = path;

	//if there is an assets directory under this, then we are in a development environment.
	//we will refer to all the files in the assets folder in this case. 

	//TODO:
	//get rid of the tailing / ?
	//... it would need to be added to all references
	//..  i.e.   DKFile::local_assets+"/file.ext"


#ifdef WIN32
	if(DKFile::PathExists(DKFile::app_path + "..\\assets\\ASSETS")){ //Windows
		DKFile::GetAbsolutePath(DKFile::app_path + "..\\assets\\", DKFile::local_assets);
		return true;
	}
	if(DKFile::PathExists(DKFile::app_path + "..\\..\\assets\\ASSETS")){ //Windows
		DKFile::GetAbsolutePath(DKFile::app_path + "..\\..\\assets\\", DKFile::local_assets);
		return true;
	}
	//SetDllDirectory(DKFile::app_path.c_str()); //FIXME: get rid of this?
#endif
    
#ifdef MAC
    if(DKFile::PathExists(DKFile::app_path + "../../../../../assets/ASSETS")){ //Mac
		DKFile::GetAbsolutePath(DKFile::app_path + "../../../../../assets/", DKFile::local_assets);
		DKFile::local_assets += "/";
		return true;
	}
#endif

#ifdef IOS
	DKINFO("Searching for iOS assets path...\n");
	
	// /Users/aquawicket/Library/Application Support/iPhone Simulator/6.1/Applications/D4BEB636-716E-445D-8CD9-8722785D7EB7/GuiTest.app/GuiTest
	// /Users/aquawicket/Desktop/digitalknob/USER/DKApps/GuiTest/iossim32/Release-iphonesimulator/GuiTest.app/GuiTest
	
	std::size_t pos = DKFile::app_path.find("/Library");
	DKString userpath = DKFile::app_path.substr(0, pos);
	
	if(DKFile::PathExists(userpath+"/Desktop/digitalknob/DKApps/"+DKFile::app_name+"/assets/ASSETS")){
		DKFile::local_assets = userpath+"/Desktop/digitalknob/DKApps/"+DKFile::app_name+"/assets/";
		return true;
	}
	if(DKFile::PathExists(userpath+"/Desktop/digitalknob/USER/DKApps/"+DKFile::app_name+"/assets/ASSETS")){
		DKFile::local_assets = userpath+"/Desktop/digitalknob/USER/DKApps/"+DKFile::app_name+"/assets/";
		return true;
	}
#endif

#ifdef LINUX
    if(DKFile::PathExists(DKFile::app_path+"../../assets/ASSETS")){ //Linux
		DKFile::GetAbsolutePath(DKFile::app_path+"../../assets/", DKFile::local_assets);
		DKFile::local_assets += "/";
		return true;
	}
#endif

	//AppendDataPath(DKFile::app_path);
	return false;
}

/*
///////////////////////////////////////////////////////
bool DKAssets::AppendDataPath(const DKString& datapath)
{
	DKDEBUGFUNC(datapath);
	osgDB::FilePathList fl = osgDB::getDataFilePathList();
	if(std::find(fl.begin(), fl.end(), datapath) == fl.end()){
		fl.push_back(datapath);
		osgDB::setDataFilePathList(fl);
	}
	return true;
}
*/

///////////////////////////////////////////////////////////////
bool DKAssets::PackageAssets(DKString& input, DKString& output)
{
	DKDEBUGFUNC(input, output);
#if !defined(WIN32)
	DKArchive::Compress(input, input+"/../assets.zip");

	DKUtil::Bin2C(input + "/../assets.zip", output);
	//DKFile::Delete(input + "/../assets.zip"); //delete lingering zip file;

	//alter assets.h file (the memory intensive way :P)
	DKString assets_string;
	DKFile::FileToString(output, assets_string);
	//replace(assets_string, "\n", "");
	//replace(assets_string, "\r", "");
	//replace(assets_string, " ", "");
	//std::remove_if(assets_string.begin(), assets_string.end(), isspace);

	/*
	assets_string += "#if defined(USE_DKAssets) && !defined(ANDROID)\n" + assets_string;
	assets_string += "#endif\n\n";
	assets_string += "void CopyAssets(){\n";
	assets_string += "#if defined(USE_DKAssets) && !defined(ANDROID)\n";
	assets_string += "DKCreate(\"DKAssets\");\n";
	assets_string += "DKAssets::CopyAssets(assets, assets_size);\n";
	assets_string += "#endif\n";
	assets_string += "}";
	*/
	DKFile::StringToFile(assets_string, output);
	return true;
	
#endif
	return false;
}

////////////////////////////////////////////////////////////////////////////////////
bool DKAssets::DeployAssets(const unsigned char* assets, const long int assets_size)
{
	DKDEBUGFUNC();
	if(has(DKFile::local_assets, "/assets")){ return false; }
	if(has(DKFile::local_assets, "\\assets")){ return false; }
	if(DKFile::PathExists(DKFile::local_assets+"ASSETS")){ return false; }
	DKINFO("Deploying app assets . . .\n");
	
	//Save User data
	if (DKFile::PathExists(DKFile::local_assets + "USER/USER")){
		DKINFO("Backing up user data \n");
		DKFile::CopyFolder(DKFile::local_assets + "USER", DKFile::local_assets + "../USER", true, true);
	}
	
	DKINFO("Backing up USER data . . .\n");
	DKFile::local_assets = DKFile::local_assets.substr(0, DKFile::local_assets.size()-1); //remove / at the end 
	DKFile::Delete(DKFile::local_assets); //remove assets folder completely 
	DKFile::local_assets = DKFile::local_assets + "/"; //put it back :P
	
//#if !defined(ANDROID) && !defined(WIN32)
	#include "assets.h" //FIXME: we manually move assets.h into DKPlugins/DKAssets/ to get this to work.
	DKINFO("Extracting assets from binary executable . . .\n");	
	DKFile::MakeDir(DKFile::local_assets);
	DKString output = DKFile::local_assets+"assets.zip";
	DKUtil::C2Bin((unsigned char *)ASSETS_H, ASSETS_H_SIZE, output);
	DKArchive::Extract(DKFile::local_assets+"assets.zip", DKFile::local_assets);
	//DKFile::Delete(DKFile::local_assets+"assets.zip"); //delete lingering zip file;
//#endif

/*
#ifdef WIN32
	DKINFO("Extracting assets from executable windows resources . . .\n");	
	HGLOBAL hResourceLoaded;		// handle to loaded resource 
	HRSRC hRes;						// handle/ptr. to res. info. 
	char *lpResLock;				// pointer to resource data 
	DWORD dwSizeRes;

	DKFile::MakeDir(DKFile::local_assets);
	DKINFO(DKFile::local_assets + "assets.zip \n");
	DKString strOutputLocation = DKFile::local_assets + "assets.zip";
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
		//DKFile::Copy(DKFile::local_assets+"assets/", DKFile::local_assets, true, true); //FIXME: This is not copying .dll files
		//DKFile::Delete(DKFile::local_assets+"assets");
	//}
#endif
*/
#ifdef ANDROID
	DKWARN("TODO: DKAssets::CopyAssets() <-- link android CopyAssets to this\n");
#endif

	//Restore User data
	DKINFO("Restoring USER data . . .\n");	
	DKFile::MakeDir(DKFile::local_assets+"USER");
	if (DKFile::PathExists(DKFile::local_assets + "../USER")){
		DKINFO("Restoring  user data \n");
		DKFile::CopyFolder(DKFile::local_assets + "../USER", DKFile::local_assets + "USER", true, true);
		DKFile::Delete(DKFile::local_assets + "../USER");
	}
	return true;
}
