#include "DK/stdafx.h"
#include "DKFile.h"
#include "DKLog.h"
#include <stdio.h>
#include <fstream>
#include <string>
#include <iostream>
#include <sys/stat.h>

DKString DKFile::exe_path;
DKString DKFile::exe_name;
DKString DKFile::app_path;
DKString DKFile::app_name;
DKString DKFile::local_assets;
DKString DKFile::online_assets;


///////////////////////////////////////////////////
bool DKFile::AppendSystemPath(const DKString& path)
{
	DKDebug(path);
	//FIXME: does not work
	DKString command = "set PATH=%PATH%;"+path;
	DKString rtn;
	return DKUtil::Execute(command, rtn);
}

///////////////////////////////////////
bool DKFile::ChDir(const DKString& dir)
{
	DKDebug(dir);
	if(!PathExists(dir)){ return false; }
	boost::filesystem::current_path(dir);
	DKLog("DKFile::ChDir("+dir+"): Path set to "+dir+"\n", DKDEBUG);
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKFile::Copy(const DKString& src, const DKString& dst, const bool overwrite, const bool recursive)
{
	DKDebug(src, dst, overwrite, recursive);
	if(!PathExists(src)){ 
		DKLog("DKFile::Copy("+src+","+dst+","+toString(overwrite)+","+toString(recursive)+"): The src path does not exits\n", DKERROR);
		return false; 
	}
	if(boost::filesystem::is_directory(src)){
		if(!CopyDirectory(src, dst, overwrite, recursive)){
			return false;
		}
	}
	else{
		if(PathExists(dst) && overwrite == false){
			DKLog("DKFile::Copy("+src+","+dst+","+toString(overwrite)+","+toString(recursive)+"): destination already exists. \n", DKWARN);
			return false;
		}
		boost::filesystem::copy_file(src, dst, boost::filesystem::copy_option::overwrite_if_exists);
	}

	DKLog("Copied to "+dst+"\n");
	return true;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKFile::CopyDirectory(boost::filesystem::path const& source, boost::filesystem::path const& destination, const bool overwrite, const bool recursive)
{
	DKDebug(source, destination, overwrite, recursive);
	namespace fs = boost::filesystem;
	try{
		// Check whether the function call is valid
		if( !fs::exists(source) || !fs::is_directory(source) ){
			DKLog("DKFile::CopyDirectory(): Source directory "+source.string()+" does not exist or is not a directory.\n", DKERROR);
			return false;
		}
		if(!fs::exists(destination)){ 
			// Create the destination directory
			if(!fs::create_directory(destination)){
				DKLog("DKFile::CopyDirectory(): Unable to create destination directory "+destination.string()+"\n", DKERROR);
				return false;
			}
		}
	}
	catch(fs::filesystem_error const & e){
		std::cerr << e.what() << '\n';
		return false;
	}
	// Iterate through the source directory
	for( fs::directory_iterator file(source); file != fs::directory_iterator(); ++file ){
		try{
			fs::path current(file->path());
			if(fs::is_directory(current) && recursive){
				// Found directory: Recursion
				if(!CopyDirectory( current, destination / current.filename(), overwrite, recursive)){
					return false;
				}
			}
			else{
				// Found file: Copy
				if(overwrite){
					if(has(current.string(), ".dll")){ continue; }//skip overwriting .dlls in case they are in use
					fs::copy_file( current, destination / current.filename(), boost::filesystem::copy_option::overwrite_if_exists);
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKFile::CopyFolder(const DKString& src, const DKString& dst, const bool overwrite, const bool recursive)
{
	DKDebug(src, dst, overwrite, recursive);
	if(!PathExists(src)){ 
		DKLog("DKFile::CopyFolder(): src is invalid\n", DKERROR);
		return false; 
	}
	if(!CopyDirectory(src,dst,overwrite,recursive)){
		DKLog("DKFile::CopyFolder():  DKFile::CopyDirectory() failed\n", DKERROR);
		return false;
	}
	return true;
}

/////////////////////////////////////////////
bool DKFile::CreateFile(const DKString& path)
{
	DKDebug(path);
	if(PathExists(path)){ return false; }
	std::ofstream outputFile(path.c_str()); //TODO: return value on success/fail
	return true;
}

/////////////////////////////////////////
bool DKFile::Delete(const DKString& path)
{	
	DKDebug(path);
	if(!PathExists(path)){ return false; }
	if(DKFile::IsDirectory(path)){
		DKFile::RemoveDirectory(path); //first delete all contents
	}
	else{
		if(remove(path.c_str()) != 0){
			DKLog("DKFile::Delete("+path+") failed! "+path+" \n", DKERROR);
			return false;
		}
	}

	DKLog("Deleted path "+path+"\n", DKWARN);
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKFile::FileToString(const DKString& file, DKString& string)
{
	DKDebug(file, string);
	if(!PathExists(file)){
		DKLog("DKFile::FileToString("+file+") path does not exist! \n", DKWARN);
		return false; 
	}
	if(IsDirectory(file)){
		DKLog("DKFile::FileToString("+file+") path is a directory! \n", DKWARN);
		return false; 
	}

	//TODO: error control
	std::ifstream t(file.c_str());
	std::string str((std::istreambuf_iterator<char>(t)), std::istreambuf_iterator<char>());
	string = str;
	return true;
}

//////////////////////////////////////////////////////////////////////////////////////////
bool DKFile::FindFile(DKString& filename, const DKString& path, const DKString& extension)
{
	DKDebug(filename, path, extension);
	if(!PathExists(path)){ return false; }
	DKStringArray files;
	if(!GetDirectoryContents(path, files)){
		DKLog("DKFile::GetFiles() failed. \n", DKERROR);
		return false;
	}

	for(unsigned int i=0; i<files.size(); ++i){
		if(has(files[i],extension)){
			filename = files[i];
			return true;
		}
	}

	DKLog("Could not find "+filename+extension+" file. \n", DKERROR);
	return false;
}

///////////////////////////////////////////////////////////////
bool DKFile::GetAbsolutePath(const DKString& in, DKString& out)
{
	DKDebug(in, out);
	if(!PathExists(in)){ 
		DKLog("DKFile::GetAbsolutePath("+in+",DKString&): Path does not exits\n", DKERROR);
		return false; 
	}
#ifdef WIN32
	char *fileExt;
	char resolved_path[256];
	GetFullPathName(in.c_str(), 256, resolved_path, &fileExt);
	out = resolved_path;
	replace(out, "\\", "/");
#else
	char *actualpath;
	actualpath = realpath(in.c_str(), NULL);
	out = actualpath;
#endif
	return true;
}

//////////////////////////////////////////
bool DKFile::GetAppName(DKString& appname)
{
	DKDebug(appname);
	DKFile::GetExeName(appname);
	replace(appname, ".exe", "");
	return true;
}

//////////////////////////////////////////
bool DKFile::GetAppPath(DKString& apppath)
{
	DKDebug(apppath);
	unsigned found = 0;
#ifdef WIN32
	apppath = DKFile::exe_path;
	found = apppath.find_last_of("\\");
	apppath.erase (apppath.begin()+found+1, apppath.end()); 
	return true;
#elif defined(ANDROID)
	apppath = "/mnt/sdcard/digitalknob/";
	return true;
#elif defined(MAC) || defined(IOS) || defined(LINUX)
	apppath = DKFile::exe_path;
	found = apppath.find_last_of("/");
	apppath.erase (apppath.begin()+found+1, apppath.end());
	return true;
#endif

	DKLog("DKFile::GetAppPath() not implemented on this OS \n", DKERROR);
	return false;
}

///////////////////////////////////////////////////////////////////////////////
bool DKFile::GetDirectoryContents(const DKString& path, DKStringArray& strings)
{
	DKDebug(path);
	if(!PathExists(path)){ return false; }
	boost::filesystem::directory_iterator end_itr;
	for (boost::filesystem::directory_iterator itr(path); itr != end_itr; ++itr){
		DKString filename;
		DKFile::GetFileName(itr->path().string(),filename);
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
	return true;
}

//////////////////////////////////////////////
bool DKFile::GetDrives(DKStringArray& strings)
{
	DKDebug();
#ifdef WIN32
	TCHAR szDrive[] = " A:";
	DWORD drives = GetLogicalDrives();
	if(drives == 0){
		DKLog("DKFile::GetDrives(): GetLogicalDrives() failed. \n", DKERROR);
		return false;
	}

	for (int i=0; i<26; i++){
		if((drives & (1 << i ))){
			TCHAR driveName[] = { TEXT('A') + i, TEXT(':'), TEXT('\0') }; 
			strings.push_back(driveName);
		}
	}
	return true;
#endif //(WIN32)
	DKLog("DKFile::GetDrives() not implemented on this OS. \n", DKERROR);
	return false;
}

//////////////////////////////////////////
bool DKFile::GetExeName(DKString& exename)
{
	DKDebug(exename);
#ifdef WIN32
	if(!DKFile::PathExists(DKFile::exe_path)){
		TCHAR appfilename[MAX_PATH];
		GetModuleFileName(NULL, appfilename, MAX_PATH);
		DKFile::exe_path = appfilename;
	}
#endif 

	if (!DKFile::PathExists(DKFile::exe_path)){
		return false;
	}
	DKString filename = DKFile::exe_path;

#ifdef WIN32
	unsigned found = filename.find_last_of("\\");
#else
	unsigned found = filename.find_last_of("/");
#endif

	exename = filename.substr(found+1);
	return true;
}

//////////////////////////////////////////
bool DKFile::GetExePath(DKString& exepath)
{
	DKDebug(exepath);
	if(!DKFile::PathExists(DKFile::exe_path)){ return false; }
	exepath = DKFile::exe_path;
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKFile::GetExtention(const DKString& file, DKString& extension)
{
	DKDebug(file, extension);
	if(!has(file,".")){return false;}
	unsigned found = file.find_last_of(".");
	extension = file.substr(found,file.size());
	return true;
}

//////////////////////////////////////////////////////////////////
bool DKFile::GetFileName(const DKString& path, DKString& filename)
{
	DKDebug(path, filename);
	unsigned found = path.find_last_of("/\\");
	if(found != std::string::npos && found < path.length()){
		filename = path.substr(found+1);
		return true;
	}
	filename = path;
	return true;
}

//////////////////////////////////////////////////////////////
bool DKFile::GetFilePath(const DKString& file, DKString& path)
{
	DKDebug(file, path);
	unsigned int found = file.find_last_of("/");
	if(found != std::string::npos && found < file.length()){
		path = file.substr(0, found+1);
		return true;
	}
	found = file.find_last_of("\\");
	if(found != std::string::npos && found < file.length()){
		path = file.substr(0, found+1);
		return true;
	}
	return false;
}

///////////////////////////////////////////////////////////////////////////
bool DKFile::GetLocalCreationDate(const DKString& path, DKString& filedate)
{
	DKDebug(path, filedate);
	if(!PathExists(path)){ return false; }
#if defined(WIN32) || defined(MAC) || defined(LINUX)// || defined(ANDROID)	
	struct tm* clock;               // create a time structure
	struct stat attrib;         // create a file attribute structure
	stat(path.c_str(), &attrib);     // get the attributes of afile.txt
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
	return true;
#endif
	DKLog("DKUpdate::GetLocalCreationDate() is not implemented for this OS. \n", DKERROR);
	return false;
}

///////////////////////////////////////////////////////////////////////////
bool DKFile::GetLocalModifiedDate(const DKString& path, DKString& filedate)
{
	DKDebug(path, filedate);
	if(!PathExists(path)){ return false; }

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
	return true;
#endif
	DKLog("DKUpdate::GetLocalModifiedDate() is not implemented for this OS. \n", DKERROR);
	return false;
}

/////////////////////////////////////;////////////////////////////
bool DKFile::GetModifiedTime(const DKString& path, DKString& time)
{
	DKDebug(path, time);
	if(!PathExists(path)){ return false; }

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
			if(st.wHour > 12){
				time += "pm";
			}
			else{
				time += "am";
			}
			return true;
		}
		DKLog("DKFile::GetModifiedTime(): localFiletime; invalid \n", DKERROR);
		return false;
	}
	else{
		DKLog("DKFile::GetModifiedTime(): file not found", DKERROR);
		return false;
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
	if(local->tm_hour > 12){
		time += "pm";
	}
	else{
		time += "am";
	}
	return true;
#endif
#endif

	DKLog("DKFile::GetModificationTime() not implemeneted on this OS.\n",DKERROR);
	return false; //TODO
}

///////////////////////////////////////////////////////////////////////////////////////
bool DKFile::GetRelativePath(const DKString& file, const DKString& path, DKString& out)
{
	DKDebug(file, path, out);
	if(!PathExists(file)){ return false; }
	DKString file2 = file;
#ifdef WIN32
	replace(file2, "/", "\\");
#endif
	DKString path2 = path;
#ifdef WIN32
	replace(path2, "/", "\\");
#endif
	DKLog("DKFile::GetRelativePath("+file2+","+path2+",DKString&)\n", DKDEBUG);

	int MAX_FILENAME_LEN = 512;
#ifdef WIN32
	int ABSOLUTE_NAME_START = 3;
	int SLASH = '\\';
#else
	int ABSOLUTE_NAME_START = 1;
	int SLASH = '/';
#endif

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
	if(cdLen > MAX_FILENAME_LEN || cdLen < ABSOLUTE_NAME_START+1 || 
		afLen > MAX_FILENAME_LEN || afLen < ABSOLUTE_NAME_START+1)
	{
		out.clear();
		return false;
	}

	// Handle DOS names that are on different drives:
	if(currentDirectory[0] != absoluteFilename[0])
	{
		// not on the same drive, so only absolute filename will do
		strcpy(relativeFilename, absoluteFilename);
		out = relativeFilename;
#ifdef WIN32
		replace(out, "\\", "/");
#endif
		return true;
	}
	// they are on the same drive, find out how much of the current directory
	// is in the absolute filename
	i = ABSOLUTE_NAME_START;
	while(i < afLen && i < cdLen && currentDirectory[i] == absoluteFilename[i])
	{
		i++;
	}
	if(i == cdLen && (absoluteFilename[i] == SLASH || absoluteFilename[i-1] == SLASH))
	{
		// the whole current directory name is in the file name,
		// so we just trim off the current directory name to get the
		// current file name.
		if(absoluteFilename[i] == SLASH)
		{
			// a directory name might have a trailing slash but a relative
			// file name should not have a leading one...
			i++;
		}
		strcpy(relativeFilename, &absoluteFilename[i]);
		out = relativeFilename;
#ifdef WIN32
		replace(out, "\\", "/");
#endif
		return true;
	}
	// The file is not in a child directory of the current directory, so we
	// need to step back the appropriate number of parent directories by
	// using "..\"s.  First find out how many levels deeper we are than the
	// common directory
	afMarker = i;
	levels = 1;
	// count the number of directory levels we have to go up to get to the
	// common directory
	while(i < cdLen)
	{
		i++;
		if(currentDirectory[i] == SLASH)
		{
			// make sure it's not a trailing slash
			i++;
			if(currentDirectory[i] != '\0')
			{
				levels++;
			}
		}
	}
	// move the absolute filename marker back to the start of the directory name
	// that it has stopped in.
	while(afMarker > 0 && absoluteFilename[afMarker-1] != SLASH)
	{
		afMarker--;
	}
	// check that the result will not be too long
	if(levels * 3 + afLen - afMarker > MAX_FILENAME_LEN)
	{
		return NULL;
	}

	// add the appropriate number of "..\"s.
	rfMarker = 0;
	for(i = 0; i < levels; i++)
	{
		relativeFilename[rfMarker++] = '.';
		relativeFilename[rfMarker++] = '.';
		relativeFilename[rfMarker++] = SLASH;
	}
	// copy the rest of the filename into the result string
	strcpy(&relativeFilename[rfMarker], &absoluteFilename[afMarker]);
	out = relativeFilename;
#ifdef WIN32
	replace(out, "\\", "/");
#endif
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////
bool DKFile::GetSetting(const DKString& file, const DKString& setting, DKString& value)
{
	DKDebug(file, setting, value);
	DKString path = file;
	replace(path, "file:///", "");

	if(!PathExists(path)){
		DKLog("DKFile::GetSetting("+path+","+setting+",DKString&): path does not exist\n", DKWARN);
		return false; 
	}
	DKString filestring;
	if(!FileToString(path, filestring)){ return false; }
	if(!getSettingFromString(filestring, setting, value)){ return false; }
	return true;
}

/*
////////////////////////////////////////////////////////////////////////////////////////////
bool DKFile::GetSettings(const DKString& file, const DKString& setting, DKStringArray& arry)
{
	DKDebug(file, setting, arry);
	if(!PathExists(file)){ 	return false; }

	DKString filestring;
	if(!FileToString(file, filestring)){
		DKLog("DKFile::FileToString failed! \n", DKERROR);
		return false;
	}

	arry = getSettingsFromString(filestring, setting);
	return true;
}
*/

////////////////////////////////////////////////////////////////////
bool DKFile::GetShortName(const DKString& file, DKString& shortname)
{
	DKDebug(file, shortname);
	if(!PathExists(file)){ return false; }
#ifdef WIN32
	long length = 0;
	TCHAR* buffer = NULL;
	length = GetShortPathName(file.c_str(), NULL, 0);
	if(length < 1){
		//DKLog("DKFile::GetShortName(): length < 1 \n", DKERROR);
		return false;
	}
	buffer = new TCHAR[length];
	length = GetShortPathName(file.c_str(), buffer, length);
	if(length < 1){
		//DKLog("DKFile::GetShortName(): length < 1 \n", DKERROR);
		return false;
	}
	DKString temp = buffer; 
	delete [] buffer;
	shortname = temp;
#else
	shortname = file;
#endif
	return true;
}

//////////////////////////////////////////////
bool DKFile::IsDirectory(const DKString& file)
{
	DKDebug(file);
	if(!PathExists(file)){ return false; }
	struct stat s;
	if( stat(file.c_str(),&s) == 0 ){
		if( s.st_mode & S_IFDIR ){
			return true;
		}
		else if( s.st_mode & S_IFREG ){
			return false; //it's a file
		}
		else{
			return false; //it's something else
		}
	}
	return false;
}

/////////////////////////////////////////
bool DKFile::MakeDir(const DKString& dir)
{
	DKDebug(dir);
	
	//FIXME: sometimes we cannot create the directory if the parent directory does not exits.
	//       EXAMPLE:  if /test does not exist, we cannot create /test/mything 
	if(dir.empty()){ return false; }
	if(PathExists(dir)){ return true; }

	//Still can crash!  It crashes because the dir is empty.
	//Maybe check if the folder is empty first?
	if(!boost::filesystem::create_directory(dir)){
		DKLog("DKFile::MakeDir("+dir+") failed! \n", DKERROR);
		return false;
	}
	return true;
}

/////////////////////////////////////////////
bool DKFile::PathExists(const DKString& path)
{
	DKDebug(path);
	if(boost::filesystem::exists(path)){
		return true;
	}

	DKLog("DKFile::PathExists("+path+"): Path does not exist\n", DKDEBUG);
	return false;
}

//////////////////////////////////////////////////
bool DKFile::RemoveDirectory(const DKString& path)
{
	DKDebug(path);
	if(!PathExists(path)){ return false; }
	if(!boost::filesystem::remove_all(path.c_str())){ //FIXME: This will crash if a file is in use. 
		DKLog("DKFile::RemoveDirectory(): boost::filesystem::remove_all failed\n", DKERROR);
		return false;
	}
	return true;
}

////////////////////////////////////////////
bool DKFile::RemoveExtention(DKString& file)
{
	DKDebug(file);
	unsigned found = file.find_last_of(".");
	file = file.substr(0,found);
	return true;
}

////////////////////////////////////////////////////////////////////////////////////////
bool DKFile::Rename(const DKString& input, const DKString& output, const bool overwrite)
{
	DKDebug(input, output, overwrite);
	if(same(input, output)){ return true; }
	if(!PathExists(input)){
		DKLog("DKFile::Rename("+input+","+output+","+toString(overwrite)+") failed! Path does not exist \n", DKERROR);
		return false; 
	}

	if(PathExists(output)){
		if(overwrite == false){
			DKLog("DKFile::Rename("+input+","+output+","+toString(overwrite)+") failed! Path already exists \n", DKERROR);
			return false;
		}
		else{
			if(!DKFile::Delete(output)){
				DKLog("DKFile::Rename("+input+","+output+","+toString(overwrite)+") failed! Could not delete "+output+" \n", DKERROR);
				return false;
			}
		}
	}

	if(rename(input.c_str(), output.c_str()) != 0){
		DKLog("DKFile::Rename("+input+","+output+","+toString(overwrite)+") failed to rename "+input+" \n", DKERROR);
		return false;
	}

	DKLog("Renamed "+input+" to-> "+output+"\n");
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////
bool DKFile::SetSetting(const DKString& file, const DKString& setting, const DKString& value)
{
	DKDebug(file, setting, value);
	DKString path = file;
	replace(path, "file:///", "");

	DKString filestring;
	CreateFile(path);
	if(!FileToString(path,filestring)){ return false; }

	//If the variable looks like this: [VARIABLE]
	//then we return everything up to the next [VARIABLE] or to the end of the file.
	if(has(setting,"[") && has(setting,"]")){
		size_t temp = filestring.find(setting,0);
		if(temp == std::string::npos){
			filestring.append("\n" + setting + " " + value); //create entry
			DKFile::StringToFile(filestring,path);
			DKLog("WROTE: "+filestring+" TO: "+path+" \n");
			return true;
		}
		size_t start = filestring.find("]",temp);
		size_t end = filestring.find("[",start);
		if(end == std::string::npos){end = filestring.size();}

		//DKString string = filestring.substr(start+1, end-start-1);
		DKString out = " "+value+"\n";
		filestring.replace(start+1,end-start-1,out.c_str()); 
		DKFile::StringToFile(filestring,path);
		DKLog("WROTE: "+filestring+" TO: "+path+" \n");
		return true;
	}

	//If the variable looks like this:  VARIABLE 
	//then we return the rest of the line
	DKString string = setting + " ";

	size_t temp = filestring.find(string,0);
	if(temp == std::string::npos){
		filestring.append("\n" + setting + " " + value); //create entry
		DKFile::StringToFile(filestring,file);
		DKLog("WROTE: "+filestring+" TO: "+file+" \n");
		return true;
	}
	size_t start = filestring.find(" ",temp);
	size_t end = filestring.find("\n",start);

	//DKString string = filestring.substr(start+1, end-start-1);
	filestring.replace(start+1,end-start-1,value.c_str()); 
	DKFile::StringToFile(filestring,file);

	DKLog("WROTE: "+filestring+" TO: "+file+" \n");
	return true;
}

///////////////////////////////////////////////////////////////////////
bool DKFile::StringToFile(const DKString& string, const DKString& file)
{
	DKDebug(string, file);
	DKString folder;
	DKFile::GetFilePath(file,folder);
	if(!folder.empty()){
		boost::filesystem::path path(folder);
		if(!(boost::filesystem::exists(path))){
			if(!boost::filesystem::create_directory(path)){
				DKLog("DKFile::StringToFile(): could not create path. \n", DKERROR);
				return false;
			}
		}
	}

	std::ofstream t(file.c_str());
	t << string;
	t.close();
	DKLog("Saved file "+file+"\n");
	return true;
}

///////////////////////////////////////
bool DKFile::VerifyPath(DKString& path)
{
	DKDebug(path);	
	replace(path, "file:///", "");

	if(DKFile::PathExists(path)){
		return true;
	}
	if(DKFile::PathExists(DKFile::local_assets+path)){ 
		path = DKFile::local_assets+path;
		return true;
	}

	DKLog("DKFile::VerifyPath("+path+") Could not find path. \n", DKERROR);
	return false;
}