#ifdef USE_DKCef
#include "DKFileV8.h"
#include "DKFile.h"
#include "DKApp.h"

/////////////////////
void DKFileV8::Init()
{
	DKLog("DKFileV8::Init()\n", DKDEBUG);
	//DKCefApp::AttachFunction("Test", DKFileV8::Test);
	DKCefApp::AttachFunction("DKFile_ChDir", DKFileV8::ChDir);
	DKCefApp::AttachFunction("DKFile_Copy", DKFileV8::Copy);
	DKCefApp::AttachFunction("DKFile_CopyFolder", DKFileV8::CopyFolder);
	DKCefApp::AttachFunction("DKFile_Delete", DKFileV8::Delete);
	DKCefApp::AttachFunction("DKFile_DirectoryContents", DKFileV8::DirectoryContents);
	DKCefApp::AttachFunction("DKFile_Exists", DKFileV8::Exists);
	DKCefApp::AttachFunction("DKFile_FileToString", DKFileV8::FileToString);
	DKCefApp::AttachFunction("DKFile_GetAbsolutePath", DKFileV8::GetAbsolutePath);
	DKCefApp::AttachFunction("DKFile_GetSetting", DKFileV8::GetSetting);
	DKCefApp::AttachFunction("DKFile_GetShortName", DKFileV8::GetShortName);
	DKCefApp::AttachFunction("DKFile_IsDirectory", DKFileV8::IsDirectory);
	DKCefApp::AttachFunction("DKFile_MkDir", DKFileV8::MkDir);
	DKCefApp::AttachFunction("DKFile_SetSetting", DKFileV8::SetSetting);
	DKCefApp::AttachFunction("DKFile_StringToFile", DKFileV8::StringToFile);
}

///////////////////
void DKFileV8::End()
{
	DKLog("DKFileV8::End()\n", DKDEBUG);
}

/*
///////////////////////////////////////////////////
bool DKFileV8::Test(CefArgs args, CefReturn retval)
{
	DKLog("DKFileV8::Test(CefArgs,CefReturn)\n", DKDEBUG);
	DKString data = args[0]->GetStringValue();
	DKString result = data;
	retval = CefV8Value::CreateString(result);
	return true;
}
*/

////////////////////////////////////////////////////
bool DKFileV8::ChDir(CefArgs args, CefReturn retval)
{
	DKString path = args[0]->GetStringValue();
	DKFile::ChDir(path);
	return true;
}

///////////////////////////////////////////////////
bool DKFileV8::Copy(CefArgs args, CefReturn retval)
{
	DKString src = args[0]->GetStringValue();
	DKString dest = args[1]->GetStringValue();
	bool overwrite = args[2]->GetIntValue();
	if(!DKFile::Copy(src, dest, overwrite, true)){
		return false;
	}
	return true;
}

/////////////////////////////////////////////////////////
bool DKFileV8::CopyFolder(CefArgs args, CefReturn retval)
{
	DKString src = args[0]->GetStringValue();
	DKString dst = args[1]->GetStringValue();
	bool overwrite = args[2]->GetBoolValue();
	bool recursive = args[3]->GetBoolValue();
	DKLog("CopyFolder(" + src + "," + dst + "," + toString(overwrite) + "," + toString(recursive) + ")\n", DKINFO);
	if (!DKFile::CopyFolder(src, dst, overwrite, recursive)){
		DKLog("DKFile::CopyFolder(): failed. \n", DKERROR);
		return false;
	}
	return true;
}

/////////////////////////////////////////////////////
bool DKFileV8::Delete(CefArgs args, CefReturn retval)
{
	DKString path = args[0]->GetStringValue();
	DKFile::Delete(path);
	return true;
}

////////////////////////////////////////////////////////////////
bool DKFileV8::DirectoryContents(CefArgs args, CefReturn retval)
{
	DKString path = args[0]->GetStringValue();
	DKLog("DKFileV8::DirectoryContents("+path+",CefReturn)\n", DKDEBUG);
	DKStringArray arry;
	if(!DKFile::GetDirectoryContents(path, arry)){
		return true;
	}
	DKString string = toString(arry, ",");
	retval = CefV8Value::CreateString(string);
	return true;
}

/////////////////////////////////////////////////////
bool DKFileV8::Exists(CefArgs args, CefReturn retval)
{
	DKString path = args[0]->GetStringValue();
	if(!DKFile::PathExists(path)){
		retval = CefV8Value::CreateBool(false);
		return true; 
	}
	retval = CefV8Value::CreateBool(true);
	return true;
}

///////////////////////////////////////////////////////////
bool DKFileV8::FileToString(CefArgs args, CefReturn retval)
{
	DKString path = args[0]->GetStringValue();
	DKString string;
	if (!DKFile::FileToString(path, string)) { return false; }
	retval = CefV8Value::CreateString(string);
	return true;
}

//////////////////////////////////////////////////////////////
bool DKFileV8::GetAbsolutePath(CefArgs args, CefReturn retval)
{
	DKString path = args[0]->GetStringValue();
	DKLog("DKFileV8::GetAbsolutePath("+path+",CefReturn)\n", DKDEBUG);
	DKString aPath;
	if(!DKFile::GetAbsolutePath(path, aPath)){ return false; }
	retval = CefV8Value::CreateString(aPath);
	return true;
}

/////////////////////////////////////////////////////////
bool DKFileV8::GetSetting(CefArgs args, CefReturn retval)
{
	DKString file = args[0]->GetStringValue();
	DKString param = args[1]->GetStringValue();
	DKString value;
	if(!DKFile::GetSetting(file, param, value)){
		return true;
	}
	retval = CefV8Value::CreateString(value);
	return true;
}

///////////////////////////////////////////////////////////
bool DKFileV8::GetShortName(CefArgs args, CefReturn retval)
{
	DKString path = args[0]->GetStringValue();
	DKLog("DKFileV8::GetShortName("+path+",CefReturn)\n", DKDEBUG);
#ifdef WIN32
	DKString shortname;
	if(DKFile::GetShortName(path, shortname)){
		retval = CefV8Value::CreateString(shortname);
		return true;
	}
#endif
	retval = CefV8Value::CreateString(path);
	return true;
}

//////////////////////////////////////////////////////////
bool DKFileV8::IsDirectory(CefArgs args, CefReturn retval)
{
	DKString path = args[0]->GetStringValue();
	DKLog("DKFileV8::IsDirectory("+path+",CefReturn)\n", DKDEBUG);
	if(!DKFile::IsDirectory(path)){
		retval = CefV8Value::CreateBool(false);
		return true;
	}
	retval = CefV8Value::CreateBool(true);
	return true;
}

////////////////////////////////////////////////////
bool DKFileV8::MkDir(CefArgs args, CefReturn retval)
{
	DKString path = args[0]->GetStringValue();
	DKFile::MakeDir(path);
	return true;
}

/////////////////////////////////////////////////////////
bool DKFileV8::SetSetting(CefArgs args, CefReturn retval)
{
	DKString file = args[0]->GetStringValue();
	DKString param = args[1]->GetStringValue();
	DKString value = args[2]->GetStringValue();
	if(!DKFile::SetSetting(file, param, value)){ 
		return false; 
	}
	return true;
}

///////////////////////////////////////////////////////////
bool DKFileV8::StringToFile(CefArgs args, CefReturn retval)
{
	DKString string = args[0]->GetStringValue();
	DKString file = args[1]->GetStringValue();
	if (!DKFile::StringToFile(string, file)) { return false; }
	return true;
}

#endif //USE_DKCef