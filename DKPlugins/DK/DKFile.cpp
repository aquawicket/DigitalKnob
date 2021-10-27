#include "DK/stdafx.h"
#include "DKFile.h"
#include "DKLog.h"
#include <stdio.h>
#include <fstream>
#include <string>
#include <iostream>
#include <sys/stat.h>
#include <cstring>

DKString DKFile::exe_path;      //EXAMPLE:  C:/Users/aquawicket/digitalknob/DK/DKApps/DKBuilder/win32/Release/DKBuilder.exe
DKString DKFile::exe_name;      //EXAMPLE:  DKBuilder.exe
DKString DKFile::app_path;      //EXAMPLE:  C:/Users/aquawicket/digitalknob/DK/DKApps/DKBuilder/win32/Release/
DKString DKFile::app_name;      //EXAMPLE:  DKBuilder
DKString DKFile::local_assets;  //EXAMPLE:  C:/Users/aquawicket/digitalknob/DK/DKApps/DKBuilder/assets/
DKString DKFile::online_assets; //EXAMPLE:  http://aquawicket.github.io/DigitalKnob/DKPlugins/

bool DKFile::DebugPath(const DKString& path){
	if(has(path, "\\")){
		DKWARN("DKFile::DebugPath("+path+"): Found obscurities in the path. Please debug to find the out where is starts for this path \n");
		return false;
	}
	if(has(path, "//") && !has(path, "://")){
		DKWARN("DKFile::DebugPath("+path+"): Found obscurities in the path. Please debug to find out where it starts for this path \n");
		return false;
	}
	return true;
}

//TODO: this function is not complete
bool DKFile::NormalizePath(DKString& path){
	DKDEBUGFUNC(path);
	//FIXME:  need a better algorythm here 
	while(has(path, "\\"))
		replace(path, "\\", "/"); //Turn all back slashes into forward slashes
	while(has(path, "//"))
		replace(path, "//", "/"); //Turn all double forward slashes into single
	//replace the double forward slash back in for url paths
	replace(path, "http:/", "http://");
	replace(path, "https:/", "https://");
	replace(path, "HTTP:/", "HTTP://");
	replace(path, "HTTPS:/", "HTTPS://");
	replace(path, "ftp:/", "ftp://");
	replace(path, "ftps:/", "ftps://");
	replace(path, "FTP:/", "FTP://");
	replace(path, "FTPS:/", "FTPS://");
	return false;
}

#ifdef WIN32
bool DKFile::AppendSystemPath(const DKString& path){
	DKDEBUGFUNC(path);
	DebugPath(path);
	DKString command = "setx PATH %PATH%;"+path;
	DKString rtn;
	return DKUtil::Execute(command, "rt", rtn);
}
#endif

bool DKFile::ChDir(const DKString& dir){
	DKDEBUGFUNC(dir);
	DebugPath(dir);
	if(!PathExists(dir))
		return DKERROR("dir does not exist \n");
	fs::current_path(dir);
	return true;
}

bool DKFile::Copy(const DKString& src, const DKString& dst, const bool overwrite, const bool recursive){
	DKDEBUGFUNC(src, dst, overwrite, recursive);
	DebugPath(src);
	DebugPath(dst);
	if(!PathExists(src))
		return DKERROR("("+src+","+dst+","+toString(overwrite)+","+toString(recursive)+"): The src path does not exits \n");
	if(fs::is_directory(src)) {
		if(!CopyDirectory(src, dst, overwrite, recursive))
			return DKERROR("("+src+","+dst+","+toString(overwrite)+","+toString(recursive)+"): failed \n");
	}
	else{
		if(PathExists(dst) && overwrite == false){
			DKWARN("DKFile::Copy("+src+","+dst+","+toString(overwrite)+","+toString(recursive)+"): destination already exists \n");
			return false;
		}
	    fs::copy_file(src, dst, fs::copy_options::overwrite_existing);
	}
	DKINFO("Copied to "+dst+" \n");
	return true;
}

bool DKFile::CopyDirectory(fs::path const& source, fs::path const& destination, const bool overwrite, const bool recursive) {
	DKDEBUGFUNC(source, destination, overwrite, recursive);
	DebugPath(source.string());
	DebugPath(destination.string());
#ifndef ANDROID
	try{
#endif
		// Check whether the function call is valid
		if(!fs::exists(source) || !fs::is_directory(source))
			return DKERROR("Source directory "+source.string()+" does not exist or is not a directory \n");
		if(!fs::exists(destination)){ 
			// Create the destination directory
			if(!fs::create_directories(destination))
				return DKERROR("Unable to create destination directory "+destination.string()+" \n");
		}
#ifndef ANDROID
	}
	catch(fs::filesystem_error const & e){
#endif
		return DKERROR(toString(e.what())+" \n");
#ifndef ANDROID
	}
#endif
	// Iterate through the source directory
	for(fs::directory_iterator file(source); file != fs::directory_iterator(); ++file){
		try{
			fs::path current(file->path());
			if(fs::is_directory(current) && recursive){
				// Found directory: Recursion
				if(!CopyDirectory(current, destination / current.filename(), overwrite, recursive))
					return DKERROR("DKFile::CopyDirectory() failed \n");
			}
			else{
				// Found file: Copy
				if(overwrite){
					if(has(current.string(), ".dll")){ continue; }//skip overwriting .dlls in case they are in use
					fs::copy_file( current, destination / current.filename(), fs::copy_options::overwrite_existing);
				}
				else{
					fs::copy_file( current, destination / current.filename() );
				}
			}
		}
		catch(fs::filesystem_error const & e){
			std:: cerr << e.what() << '\n';
		}
	}
	return true;
}

bool DKFile::CopyFolder(const DKString& src, const DKString& dst, const bool overwrite, const bool recursive){
	DKDEBUGFUNC(src, dst, overwrite, recursive);
	DebugPath(src);
	DebugPath(dst);
	if(!PathExists(src))
		return DKERROR("src is invalid \n");
	if(!CopyDirectory(src,dst,overwrite,recursive))
		return DKERROR("DKFile::CopyDirectory() failed \n");
	return true;
}

bool DKFile::CreateFile(const DKString& path){
	DKDEBUGFUNC(path);
	DebugPath(path);
	if(PathExists(path))
		return DKERROR("path:("+path+") already exists \n");
	std::ofstream outputFile(path.c_str()); //TODO: return value on success/fail
	return true;
}

bool DKFile::Delete(const DKString& path){
	DKDEBUGFUNC(path);
	DebugPath(path);
	if(!PathExists(path))
		return DKERROR("path:("+path+") does not exist \n");
	if(DKFile::IsDirectory(path))
		DKFile::RemoveDirectory(path); //first delete all contents
	else{
		if(remove(path.c_str()) != 0)
			return DKERROR("remove("+path+") failed \n");
	}
	DKWARN("Deleted path "+path+" \n");
	return true;
}

bool DKFile::FileToString(const DKString& file, DKString& string){
	DebugPath(file);
	if(!PathExists(file))
		return DKERROR("file:("+file+") path does not exist \n");
	if(IsDirectory(file))
		return DKERROR("file:("+file+") path is a directory \n");
	//TODO: error control
	std::ifstream t(file.c_str());
	std::string str((std::istreambuf_iterator<char>(t)), std::istreambuf_iterator<char>());
	string = str;
	return true && DKDEBUGRETURN(file, string);
}

bool DKFile::FindFile(DKString& filename, const DKString& path, const DKString& extension){
	DKDEBUGFUNC(filename, path, extension);
	DebugPath(filename);
	DebugPath(path);
	if(!PathExists(path))
		return false;
	DKStringArray files;
	if(!GetDirectoryContents(path, files))
		return DKERROR("GetDirectoryContents("+path+") failed \n");
	for(unsigned int i=0; i<files.size(); ++i){
		if(has(files[i],extension)){
			filename = files[i];
			return true;
		}
	}
	return DKERROR("Could not find "+filename+extension+" file \n");
}

bool DKFile::GetAbsolutePath(const DKString& in, DKString& out){
	//GetAbsolutePath is allowed to recieve obscure paths, it will return normalized paths.
	if(!PathExists(in))
		return DKERROR("("+in+"): Path does not exits \n");
#ifdef WIN32
	char *fileExt;
	char resolved_path[256];
	GetFullPathName(in.c_str(), 256, resolved_path, &fileExt);
	out = resolved_path;
	NormalizePath(out); //windows returns paths with a \\ seperator, so we normalize it here.
#else
	char *actualpath;
	actualpath = realpath(in.c_str(), NULL);
	out = actualpath;
	if(in.back() == '/' && out.back() != '/')
		out += '/'; //Keep the trailing / for folder paths
	DKINFO("DKFile::GetAbsolutePath():  realpath_in: "+in+"realpath_out:"+out+" \n");
#endif
	DebugPath(out);
	return true && DKDEBUGRETURN(in, out);
}

bool DKFile::GetAppName(DKString& appname){
	if (!DKFile::PathExists(DKFile::exe_path))
		DKFile::GetExePath(DKFile::exe_path);
	DKFile::GetExeName(appname);
	replace(appname, ".exe", "");
	DebugPath(appname);
	return true && DKDEBUGRETURN(appname);
}

bool DKFile::GetAppPath(DKString& apppath){
	//DKDEBUGFUNC(apppath);
	if (!DKFile::PathExists(DKFile::exe_path))
		DKFile::GetExePath(DKFile::exe_path);
	unsigned found = 0;
#ifdef WIN32
	apppath = DKFile::exe_path;
	found = apppath.find_last_of("/");
	apppath.erase (apppath.begin()+found+1, apppath.end()); 
	DebugPath(apppath);
	return true && DKDEBUGRETURN(apppath);
#elif defined(ANDROID)
	apppath = "/mnt/sdcard/digitalknob/";
	DebugPath(apppath);
	return true && DKDEBUGRETURN(apppath);
#elif defined(MAC) || defined(IOS) || defined(LINUX)
	apppath = DKFile::exe_path;
	found = apppath.find_last_of("/");
	apppath.erase (apppath.begin()+found+1, apppath.end());
	DebugPath(apppath);
	return true && DKDEBUGRETURN(apppath);
#endif
	DebugPath(apppath);
	return DKERROR("not implemented on this OS \n");
}

bool DKFile::GetBasename(const DKString& path, DKString& basename){
	basename = path;
	if (basename.back() == '/')
		basename.pop_back();
	unsigned found = basename.find_last_of("/");
	if (found != std::string::npos && found < basename.length()) {
		basename = basename.substr(found + 1);
		return true && DKDEBUGRETURN(path, basename);
	}
	return DKERROR("basename invalid \n");
}

bool DKFile::GetDirectoryContents(const DKString& path, DKStringArray& strings){
	DebugPath(path);
	if(!PathExists(path))
		return DKERROR("path does not exist \n");
	fs::directory_iterator end_itr;
	for (fs::directory_iterator itr(path); itr != end_itr; ++itr) {
		DKString itrPath = itr->path().string();
		DKFile::NormalizePath(itrPath);
		DKString filename;
		DKFile::GetFileName(itrPath,filename);
		strings.push_back(filename);
	}
//#if defined(LINUX) || defined(MAC)
	std::sort(strings.begin(), strings.end());
//#endif
	//remove . && ..
	for(unsigned int i=0; i < strings.size(); ++i){
		if(same(strings[i],".") || same(strings[i],"..")){
			strings.erase(strings.begin()+i);
			--i;
		}
	}
	return true && DKDEBUGRETURN(path);
}

bool DKFile::GetDrives(DKStringArray& strings){
#ifdef WIN32
	TCHAR szDrive[] = " A:";
	DWORD drives = GetLogicalDrives();
	if(drives == 0)
		return DKERROR("GetLogicalDrives() failed \n");
	for (int i=0; i<26; i++){
		if((drives & (1 << i ))){
			TCHAR driveName[] = { static_cast<TCHAR>(TEXT('A') + i), TEXT(':'), TEXT('\0') };
			strings.push_back(driveName);
		}
	}
	return true;//&& DKDEBUGRETURN(toString(strings));
#endif //(WIN32)
	return DKERROR("not implemented on this OS \n");
}

bool DKFile::GetExeName(DKString& exename){
	if(!DKFile::PathExists(DKFile::exe_path))
		DKFile::GetExePath(DKFile::exe_path);
	unsigned found = DKFile::exe_path.find_last_of("/");
	if (found != std::string::npos && found < DKFile::exe_path.length()) {
		exename = DKFile::exe_path.substr(found + 1);
		DebugPath(exename);
		return true && DKDEBUGRETURN(exename);
	}
	return DKERROR("exename invalid \n");
}

bool DKFile::GetExePath(DKString& exepath){
	//DKFile::exe_path should hold the full file path of this executable from argv[0];
	//If is doesn't, we should fill that now and figure out why it didn't get assigned.
	if (!DKFile::PathExists(DKFile::exe_path)) {
		DKWARN("GetExePath(): DKFile::exe_path is invalid. It should have been set by argv[0] at app start \n");
		DKClass::DKCreate("DKDebug");
		DKClass::CallFunc("DKDebug::ShowStackTrace");
#ifdef WIN32
		TCHAR fullpath[MAX_PATH];
		GetModuleFileName(NULL, fullpath, MAX_PATH);
		DKFile::exe_path = fullpath;
		NormalizePath(exe_path); //Windows returns paths with a \\ seperator.
#else
		//FIXME: We need this coded in for other platforms
		return DKERROR("is not implemented on this platform \n");
#endif
	}
	exepath = DKFile::exe_path;
	DebugPath(exepath);
	return true && DKDEBUGRETURN(exepath);
}

bool DKFile::GetExtention(const DKString& file, DKString& extension){
	DebugPath(file);
	if(!has(file,".")){
		DKWARN("file ("+file+") has no extension \n");
		return true && DKDEBUGRETURN(file, extension);
	}
	unsigned found = file.find_last_of(".");
	extension = file.substr(found,file.size());
	return true && DKDEBUGRETURN(file, extension);
}

bool DKFile::GetFileName(const DKString& path, DKString& filename){
	DebugPath(path);
	filename = path;
	if (filename.back() == '/')
		filename.pop_back();
	unsigned found = filename.find_last_of("/");
	if(found != std::string::npos && found < filename.length()){
		filename = filename.substr(found+1);
		return true && DKDEBUGRETURN(path, filename);
	}
	DKWARN("/ not found in path ("+path+") \n");
	DKWARN("returning this path as the filename("+filename+") \n");
	return true && DKDEBUGRETURN(path, filename);
}

bool DKFile::GetFilePath(const DKString& file, DKString& path){
	DebugPath(file);
	path = file;
	if(path.back() == '/')
		path.pop_back();
	unsigned int found = path.find_last_of("/");
	if(found != std::string::npos && found < path.length()){
		path = path.substr(0, found+1);
		DebugPath(path);
		return true && DKDEBUGRETURN(file, path);
	}
	DebugPath(path);
	return false && DKDEBUGRETURN(file, path);
}

bool DKFile::GetLocalCreationDate(const DKString& path, DKString& filedate){
	DebugPath(path);
	if(!PathExists(path))
		return false;
#if defined(WIN32) || defined(MAC) || defined(LINUX)// || defined(ANDROID)	
	struct tm* clock;               // create a time structure
	struct stat attrib;             // create a file attribute structure
	stat(path.c_str(), &attrib);    // get the attributes of afile.txt
	clock = localtime(&(attrib.st_ctime)); 
	DKString month = toString(clock->tm_mon);
	DKString day = toString(clock->tm_mday);
	DKString hour = toString(clock->tm_hour);
	DKString minute = toString(clock->tm_min);
	DKString second = toString(clock->tm_sec);
	DKString year = toString(clock->tm_year + 1900);
	Pad(4, '0', year);
	Pad(2, '0', month);
	Pad(2, '0', day);
	Pad(2, '0', hour);
	Pad(2, '0', minute);
	Pad(2, '0', second);
	//19990102040506
	filedate = year + month + day + hour + minute + second;
	return true && DKDEBUGRETURN(path, filedate);
#endif
	return DKERROR("not implemented for this OS \n");
}

bool DKFile::GetLocalModifiedDate(const DKString& path, DKString& filedate){
	DebugPath(path);
	if(!PathExists(path))
		return false;
#if defined(WIN32) || defined(MAC) || defined(LINUX)// || defined(ANDROID)
	struct tm* clock;               // create a time structure
	struct stat attrib;         // create a file attribute structure
	stat(path.c_str(), &attrib);     // get the attributes of afile.txt
	clock = localtime(&(attrib.st_mtime)); 
	DKString month = toString(clock->tm_mon);
	DKString day = toString(clock->tm_mday);
	DKString hour = toString(clock->tm_hour);
	DKString minute = toString(clock->tm_min);
	DKString second = toString(clock->tm_sec);
	DKString year = toString(clock->tm_year + 1900);
	Pad(4, '0', year);
	Pad(2, '0', month);
	Pad(2, '0', day);
	Pad(2, '0', hour);
	Pad(2, '0', minute);
	Pad(2, '0', second);
	//19990102040506
	filedate = year + month + day + hour + minute + second;
	return true && DKDEBUGRETURN(path, filedate);
#endif
	return DKERROR("is not implemented for this OS \n");
}

bool DKFile::GetModifiedTime(const DKString& path, DKString& time){
	DebugPath(path);
	if(!PathExists(path))
		return false;
#ifdef WIN32 
	WIN32_FILE_ATTRIBUTE_DATA fileInfo;
	if(GetFileAttributesEx(path.c_str(), GetFileExInfoStandard, &fileInfo)){
		FILETIME localFiletime;
		if(FileTimeToLocalFileTime(&fileInfo.ftLastWriteTime, &localFiletime)){
			SYSTEMTIME st={0};
			::FileTimeToSystemTime(&localFiletime,&st);
			//FILETIME ftCreationTime;	// creation time
			//FILETIME ftLastAccessTime;	// last access time	
			//FILETIME ftLastWriteTime;	// last modification time
			//DWORD nFileSizeHigh;	// the high DWORD of the file size (it is zero unless the file is over four gigabytes)
			//DWORD nFileSizeLow;	// the low DWORD of the file size
			DKString month = toString((int)st.wMonth);
			DKString day = toString((int)st.wDay);
			DKString year = toString((int)st.wYear);
			int standard = st.wHour % 12;
			DKString hour = toString(standard);
			DKString minute = toString((int)st.wMinute);
			Pad(4, '0', year);
			Pad(2, '0', month);
			Pad(2, '0', day);
			Pad(2, '0', hour);
			Pad(2, '0', minute);
			time = month;
			time += "/";
			time += day;
			time += "/";
			time += year;
			time += " ";
			time += hour;
			time += ":";
			time += minute;
			if(st.wHour > 12)
				time += "pm";
			else
				time += "am";
			return true && DKDEBUGRETURN(path, time);
		}
		return DKERROR("localFiletime; invalid \n");
	}
	else{
		return DKERROR("file not found \n");
	}
#else 
#ifndef ANDROID
	struct tm* local;
	struct stat attrib;
	stat(path.c_str(), &attrib);
	local = localtime(&(attrib.st_mtime));
	int standard = local->tm_hour % 12;
	time = toString(local->tm_mon+1);
	time += "/";
	time += toString(local->tm_mday);
	time += "/";
	time += toString(local->tm_year + 1900);
	time += " ";
	time += toString(standard);
	time += ":";
	time += toString(local->tm_min);
	if(local->tm_hour > 12)
		time += "pm";
	else
		time += "am";
	return true && DKDEBUGRETURN(path, time);
#endif
#endif
	return DKERROR("not implemeneted on this OS \n");
}

bool DKFile::GetPath(DKString& path) {
	if (path.empty() || same(path, "/") || same(path, "."))
		path = DKFile::local_assets;
	DKFile::GetAbsolutePath(path, path);
	DKFile::ValidatePath(path);
	DKDEBUGRETURN(path);
	return true;
}

bool DKFile::GetRelativePath(const DKString& file, const DKString& path, DKString& out){
	DebugPath(file);
	DebugPath(path);
	if (same(file, path))
		return true;
	if(!PathExists(file))
		return DKERROR("("+file+") path does not exist \n");
	DKString file2 = file;
	if (file2.back() == '/')
		file2.pop_back();
	DKString path2 = path;
	if (path2.back() == '/')
		path2.pop_back();
	DKINFO("DKFile::GetRelativePath("+file2+","+path2+",DKString&) \n");
	int MAX_FILENAME_LEN = 512;
	int ABSOLUTE_NAME_START = 1;
	int SLASH = '/';
	const char* absoluteFilename = file2.c_str();
	const char* currentDirectory = path2.c_str();
	// declarations - put here so this should work in a C compiler
	int afMarker = 0, rfMarker = 0;
	int cdLen = 0, afLen = 0;
	int i = 0;
	int levels = 0;
	static char relativeFilename[512];
	cdLen = strlen(currentDirectory);
	afLen = strlen(absoluteFilename);
	// make sure the names are not too long or too short
	if(cdLen > MAX_FILENAME_LEN || cdLen < ABSOLUTE_NAME_START+1 || afLen > MAX_FILENAME_LEN || afLen < ABSOLUTE_NAME_START+1){
		out.clear();
		DebugPath(out);
		return DKERROR("cdLen > MAX_FILENAME_LEN || cdLen < ABSOLUTE_NAME_START+1 || afLen > MAX_FILENAME_LEN || afLen < ABSOLUTE_NAME_START+1 \n");
	}
	// Handle DOS names that are on different drives:
	if(currentDirectory[0] != absoluteFilename[0]){
		// not on the same drive, so only absolute filename will do
		strcpy(relativeFilename, absoluteFilename);
		out = relativeFilename;
		DebugPath(out);
		return true && DKDEBUGRETURN(file, path, out);
	}
	// they are on the same drive, find out how much of the current directory
	// is in the absolute filename
	i = ABSOLUTE_NAME_START;
	while(i < afLen && i < cdLen && currentDirectory[i] == absoluteFilename[i])
		i++;
	if(i == cdLen && (absoluteFilename[i] == SLASH || absoluteFilename[i-1] == SLASH)){
		// the whole current directory name is in the file name,
		// so we just trim off the current directory name to get the
		// current file name.
		if(absoluteFilename[i] == SLASH){
			// a directory name might have a trailing slash but a relative
			// file name should not have a leading one...
			i++;
		}
		strcpy(relativeFilename, &absoluteFilename[i]);
		out = relativeFilename;
		return true && DKDEBUGRETURN(file, path, out);
	}
	// The file is not in a child directory of the current directory, so we
	// need to step back the appropriate number of parent directories by
	// using "..\"s.  First find out how many levels deeper we are than the
	// common directory
	afMarker = i;
	levels = 1;
	// count the number of directory levels we have to go up to get to the
	// common directory
	while(i < cdLen){
		i++;
		if(currentDirectory[i] == SLASH){
			// make sure it's not a trailing slash
			i++;
			if(currentDirectory[i] != '\0')
				levels++;
		}
	}
	// move the absolute filename marker back to the start of the directory name
	// that it has stopped in.
	while(afMarker > 0 && absoluteFilename[afMarker-1] != SLASH){
		afMarker--;
	}
	// check that the result will not be too long
	if(levels * 3 + afLen - afMarker > MAX_FILENAME_LEN){
		DebugPath(out);
		return DKERROR("result > MAX_FILENAME_LEN: result too long \n");
	}
	// add the appropriate number of "..\"s.
	rfMarker = 0;
	for(i = 0; i < levels; i++){
		relativeFilename[rfMarker++] = '.';
		relativeFilename[rfMarker++] = '.';
		relativeFilename[rfMarker++] = SLASH;
	}
	// copy the rest of the filename into the result string
	strcpy(&relativeFilename[rfMarker], &absoluteFilename[afMarker]);
	out = relativeFilename;
	return true && DKDEBUGRETURN(file, path, out);
}

bool DKFile::GetSetting(const DKString& file, const DKString& setting, DKString& value){
	DebugPath(file);
	DKString path = file;
	replace(path, "file:///", "");
	if(!PathExists(path)){
		DKWARN("DKFile::GetSetting("+path+","+setting+",DKString&): path does not exist \n");
		return false; 
	}
	DKString filestring;
	if(!FileToString(path, filestring))
		return DKERROR("("+path+", "+filestring+") failed \n");
	if(!getSettingFromString(filestring, setting, value))
		return DKERROR("getSettingFromString("+filestring+", "+setting+", "+value+") failed \n");
	return true && DKDEBUGRETURN(file, setting, value);
}

/*
bool DKFile::GetSettings(const DKString& file, const DKString& setting, DKStringArray& arry){
	DKDEBUGFUNC(file, setting, arry);
	DebugPath(file);
	if(!PathExists(file))
		return false;
	DKString filestring;
	if(!FileToString(file, filestring))
		return DKERROR("DKFile::FileToString failed!\n");
	arry = getSettingsFromString(filestring, setting);
	return true && DKDEBUGRETURN(file, setting, arry);
}
*/


bool DKFile::GetShortName(const DKString& file, DKString& shortname){
	DebugPath(file);
	if(!PathExists(file))
		return DKERROR("("+file+") path does not exist \n");
#ifdef WIN32
	long length = 0;
	TCHAR* buffer = NULL;
	length = GetShortPathName(file.c_str(), NULL, 0);
	if(length < 1)
		return DKERROR("length < 1 \n");
	buffer = new TCHAR[length];
	length = GetShortPathName(file.c_str(), buffer, length);
	if(length < 1)
		return DKERROR("length < 1 \n");
	DKString temp = buffer; 
	delete [] buffer;
	shortname = temp;
#else
	shortname = file;
#endif
	DebugPath(shortname);
	return true && DKDEBUGRETURN(file, shortname);
}

bool DKFile::IsDirectory(const DKString& file){
	DebugPath(file);
	if(!PathExists(file))
		return DKERROR("("+file+") path does not exist \n");
	struct stat s;
	if(stat(file.c_str(),&s) == 0){
		if (s.st_mode & S_IFDIR)
			return true && DKDEBUGRETURN(file, true);
		else if( s.st_mode & S_IFREG )
			return false && DKDEBUGRETURN(file, false); //it's a file
		else
			return false && DKDEBUGRETURN(file, false); //it's something else
	}
	return DKERROR("unknown error \n");
}

bool DKFile::MakeDir(const DKString& dir){
	DKDEBUGFUNC(dir);
	DebugPath(dir);
	DKString path = dir;
	DKFile::NormalizePath(path);
	if(path.empty())
		return DKERROR("path is empty \n");
	if(PathExists(path))
		return true;
	if (!fs::create_directories(path)) {
		fs::directory_iterator end_itr; // default construction yields past-the-end
		for (fs::directory_iterator itr(path); itr != end_itr; ++itr)
			return DKERROR("(" + path + ") failed! \n");
	}
	return true;
}

bool DKFile::PathExists(const DKString& path){
	DKDEBUGFUNC(path);
	DebugPath(path);
	if(fs::exists(path)) 
		return true;
	//DKWARN("DKFile::PathExists("+path+"): Path does not exist \n");
	return false;
}

bool DKFile::RemoveDirectory(const DKString& path){
	DKDEBUGFUNC(path);
	DebugPath(path);
	if(!PathExists(path)){ return false; }
	if (!fs::remove_all(path.c_str())) //FIXME: This can crash if a file is in use. 
		return DKERROR("fs::remove_all("+path+") failed \n");
	return true;
}

bool DKFile::RemoveExtention(DKString& file){
	DKDEBUGFUNC(file);
	DebugPath(file);
	unsigned found = file.find_last_of(".");
	file = file.substr(0,found);
	return true;
}

bool DKFile::Rename(const DKString& input, const DKString& output, const bool overwrite){
	DKDEBUGFUNC(input, output, overwrite);
	DebugPath(input);
	DebugPath(output);
	if(same(input, output)){ return true; }
	if(!PathExists(input))
		return DKWARN("Path does not exist \n");
	if(PathExists(output)){
		if(overwrite == false){
			return DKWARN("DKFile::Rename("+input+","+output+","+toString(overwrite)+") failed! Path already exists \n");
		}
		else{
			if(!DKFile::Delete(output))
				return DKERROR("Could not delete "+output+" \n");
		}
	}
	if(rename(input.c_str(), output.c_str()) != 0)
		return DKERROR("failed to rename "+input+" \n");
	DKINFO("Renamed "+input+" to-> "+output+" \n");
	return true;
}

bool DKFile::SetSetting(const DKString& file, const DKString& setting, const DKString& value){
	DKDEBUGFUNC(file, setting, value);
	DebugPath(file);
	DKString path = file;
	replace(path, "file:///", "");
	DKString filestring;
	CreateFile(path);
	if(!FileToString(path,filestring))
		return false;
	//If the variable looks like this: [VARIABLE]
	//then we return everything up to the next [VARIABLE] or to the end of the file.
	if(has(setting,"[") && has(setting,"]")){
		size_t temp = filestring.find(setting,0);
		if(temp == std::string::npos){
			filestring.append("\n" + setting + " " + value); //create entry
			DKFile::StringToFile(filestring,path);
			DKINFO("WROTE: "+filestring+" TO: "+path+" \n");
			return true;
		}
		size_t start = filestring.find("]",temp);
		size_t end = filestring.find("[",start);
		if(end == std::string::npos)
			end = filestring.size();
		//DKString string = filestring.substr(start+1, end-start-1);
		DKString out = " "+value+"\n";
		filestring.replace(start+1,end-start-1,out.c_str()); 
		DKFile::StringToFile(filestring,path);
		DKINFO("WROTE: "+filestring+" TO: "+path+" \n");
		return true;
	}
	//If the variable looks like this:  VARIABLE 
	//then we return the rest of the line
	DKString string = setting + " ";
	size_t temp = filestring.find(string,0);
	if(temp == std::string::npos){
		filestring.append("\n" + setting + " " + value); //create entry
		DKFile::StringToFile(filestring,file);
		DKINFO("WROTE: "+filestring+" TO: "+file+" \n");
		return true;
	}
	size_t start = filestring.find(" ",temp);
	size_t end = filestring.find("\n",start);
	//DKString string = filestring.substr(start+1, end-start-1);
	filestring.replace(start+1,end-start-1,value.c_str()); 
	DKFile::StringToFile(filestring,file);
	DKINFO("WROTE: "+filestring+" TO: "+file+" \n");
	return true;
}

bool DKFile::StringToFile(const DKString& string, const DKString& file){
	DKDEBUGFUNC(string, file);
	DebugPath(file);
	DKString folder;
	DKFile::GetFilePath(file,folder);
	if(!folder.empty()){
		fs::path path(folder);
		if(!(fs::exists(path))) {
			if (!fs::create_directories(path))
				return DKERROR("could not create path \n");
		}
	}
	std::ofstream t(file.c_str());
	t << string;
	t.close();
	//DKINFO("Saved file "+file+"\n");
	return true;
}

bool DKFile::VerifyPath(DKString& path){
	DKDEBUGFUNC(path);	
	DebugPath(path);
	replace(path, "file:///", ""); //Fixme: this will trigger DebugPath alarm
	if(DKFile::PathExists(path))
		return true;
	if(DKFile::PathExists(DKFile::local_assets+path)){ 
		path = DKFile::local_assets+path;
		return true;
	}
	return DKERROR("Could not find path \n");
}

bool DKFile::ValidatePath(DKString& path){
	if (has(path, "\\"))
		replace(path, "\\", "/");
	if (has(path, "://") && (substr_count(path, "//") > 0))
		replace(path, "//", "/");
	if (has(path, "://") && (substr_count(path, "//") > 1)) {
		replace(path, "//", "/");
		replace(path, ":/", "://");
	}
	if (DKFile::IsDirectory(path) && (path.back() != '/'))
		path = path + "/";
	return true;
}
