#pragma once
#ifndef DKFile_H
#define DKFile_H

#include "DK.h"
#include "DKString.h"
#include <boost/filesystem.hpp>


////////////
class DKFile
{
public:
	static DKString appfilename;
	static DKString local_assets;
	static DKString online_assets;

	static bool PathExists(const DKString& path);
	static bool VerifyPath(DKString& path);
    static bool MakeDir(const DKString& dir);
	static bool ChDir(const DKString& dir);
	static bool Rename(const DKString& input, const DKString& output, const bool overwrite);
	static bool Delete(const DKString& path);
	static bool RemoveDirectory(const DKString& path);
	static bool Copy(const DKString& src, const DKString& dst, const bool overwrite, const bool recursive);
	static bool CopyFolder(const DKString& src, const DKString& dst, const bool overwrite, const bool recursive);
	static bool GetShortName(const DKString& file, DKString& shortname);
	static bool GetDrives(DKStringArray& strings);
	static bool GetExeName(DKString& exename);
	static bool GetFullExeName(DKString& fullexename);
	static bool GetExePath(DKString& exepath);
	static bool GetFileName(const DKString& path, DKString& filename);
	static bool GetFilePath(const DKString& file, DKString& path);
	static bool FileToString(const DKString& file, DKString& string);
	static bool StringToFile(const DKString& string, const DKString& file);
	static bool GetExtention(const DKString& file, DKString& extension);
	static bool RemoveExtention(DKString& file);
	static bool GetDirectoryContents(const DKString& path, DKStringArray& strings);
	static bool FindFile(DKString& filename, const DKString& path, const DKString& extension);
	static bool IsDirectory(const DKString& file);
	static bool AppendSystemPath(const DKString& path);
	static bool GetAbsolutePath(const DKString& in, DKString& out);
	static bool GetRelativePath(const DKString& file, const DKString& path, DKString& out);
	static bool GetModifiedTime(const DKString& path, DKString& time);
	static bool CreateFile(const DKString& path);
	static bool GetLocalCreationDate(const DKString& path, DKString& filedate);
	static bool GetLocalModifiedDate(const DKString& path, DKString& filedate);
	static DKString GetSetting(const DKString& file, const DKString& setting);
	static bool SetSetting(const DKString& file, const DKString& setting, const DKString& value);
	static DKStringArray GetSettings(const DKString& file, const DKString& setting);
	static bool CopyDirectory(boost::filesystem::path const& source, boost::filesystem::path const& destination, const bool overwrite, const bool recursive);
};


#endif //DKFile_H
