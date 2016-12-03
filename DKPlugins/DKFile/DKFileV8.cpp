#include "DKFileV8.h"
#include "DKFile.h"
#include "DKApp.h"

////////////////////
void DKFileV8::Init()
{
	//DKCefApp::AttachFunction("Test", DKFileV8::Test);
	DKCefApp::AttachFunction("DKFile_DirectoryContents", DKFileV8::DirectoryContents);
	DKCefApp::AttachFunction("DKFile_GetShortName", DKFileV8::GetShortName);
	DKCefApp::AttachFunction("DKFile_IsDirectory", DKFileV8::IsDirectory);
}

///////////////////
void DKFileV8::End()
{

}

/*
///////////////////////////////////////////////////
bool DKFileV8::Test(CefArgs args, CefReturn retval)
{
	DKString data = args[0]->GetStringValue();
	DKString result = data;
	retval = CefV8Value::CreateString(result);
	return true;
}
*/

////////////////////////////////////////////////////////////////
bool DKFileV8::DirectoryContents(CefArgs args, CefReturn retval)
{
	DKString path = args[0]->GetStringValue();
	DKStringArray arry;
	if(!DKFile::GetDirectoryContents(path, arry)){
		return true;
	}
	DKString string = toString(arry, ",");
	retval = CefV8Value::CreateString(string);
	return true;
}

///////////////////////////////////////////////////////////
bool DKFileV8::GetShortName(CefArgs args, CefReturn retval)
{
	DKString path = args[0]->GetStringValue();
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
	if(!DKFile::IsDirectory(path)){
		retval = CefV8Value::CreateBool(false);
		return true;
	}
	retval = CefV8Value::CreateBool(true);
	return true;
}
