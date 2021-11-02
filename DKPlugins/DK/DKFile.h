#pragma once
#ifndef DKFile_H
#define DKFile_H


#ifndef __has_include
	static_assert(false, "__has_include not supported");
#else
	#if __cplusplus >= 201703L && __has_include(<filesystem>)
		#include <filesystem>
		namespace fs = std::filesystem;
	//#elif __has_include(<filesystem>)
	//	#include <filesystem>
	//	namespace fs = std::__fs::filesystem;
	#elif __has_include(<experimental/filesystem>)
		#include <experimental/filesystem>
		namespace fs = std::experimental::filesystem;
	#elif __has_include(<boost/filesystem.hpp>)
		#include <boost/filesystem.hpp>
		namespace fs = boost::filesystem;
	#else
		static_assert(false, "filesystem unavalable");
	#endif
#endif

#include "DK/DK.h"
#include "DK/DKString.h"

class DKFile{
public:
	static bool DebugPath(const DKString& path);
	static bool NormalizePath(DKString& path);
#ifdef WIN32
	static bool AppendSystemPath(const DKString& path);
#endif
	static bool ChDir(const DKString& dir);
	static bool Copy(const DKString& src, const DKString& dst, const bool overwrite, const bool recursive);
	static bool CopyDirectory(fs::path const& source, fs::path const& destination, const bool overwrite, const bool recursive);
	
	static bool CopyFolder(const DKString& src, const DKString& dst, const bool overwrite, const bool recursive);
	static bool CreateFile(const DKString& path);
	static bool Delete(const DKString& path);
	static bool FileToString(const DKString& file, DKString& string);
	static bool FindFile(DKString& filename, const DKString& path, const DKString& extension);
	static bool GetAbsolutePath(const DKString& in, DKString& out);
	static bool GetAppName(DKString& appname);
	static bool GetAppPath(DKString& exepath);
	static bool GetBasename(const DKString& path, DKString& basename);
	static bool GetDirectoryContents(const DKString& path, DKStringArray& strings);
	static bool GetDrives(DKStringArray& strings);
	static bool GetExeName(DKString& exename);
	static bool GetExePath(DKString& exepath);
	static bool GetExtention(const DKString& file, DKString& extension);
	static bool GetFileName(const DKString& path, DKString& filename);
	static bool GetFilePath(const DKString& file, DKString& path);
	static bool GetLocalCreationDate(const DKString& path, DKString& filedate);
	static bool GetLocalModifiedDate(const DKString& path, DKString& filedate);
	static bool GetModifiedTime(const DKString& path, DKString& time);
	static bool GetPath(DKString& path);
	static bool GetRelativePath(const DKString& file, const DKString& path, DKString& out);
	static bool GetSetting(const DKString& file, const DKString& setting, DKString& value);
	//static bool GetSettings(const DKString& file, const DKString& setting, DKStringArray& arry);
	static bool GetShortName(const DKString& file, DKString& shortname);
	static bool IsDirectory(const DKString& file);
	static bool MakeDir(const DKString& dir);
	static bool PathExists(const DKString& path);
	static bool RemoveDirectory(const DKString& path);
	static bool RemoveExtention(DKString& file);
	static bool Rename(const DKString& input, const DKString& output, const bool overwrite);
	static bool SetSetting(const DKString& file, const DKString& setting, const DKString& value);
	static bool StringToFile(const DKString& string, const DKString& file);
	static bool VerifyPath(DKString& path);
	static bool ValidatePath(DKString& path);
  
	static DKString exe_path;      //example:  C:/Users/username/digitalknob/DKApps/DKMyApp/win32/Release/DKMyApp.exe
	static DKString exe_name;      //example:  DKMyApp.exe
	static DKString app_path;      //example:  C:/Users/username/digitalknob/DKApps/DKMyApp/win32/Release
	static DKString app_name;      //example:  DKMyApp
	static DKString local_assets;  //example:  C:/Users/username/digitalknob/DKApps/DKMyApp/assets
	static DKString online_assets; //example:  http://digitalknob.com/DKMyApp
};

#endif //DKFile_H
