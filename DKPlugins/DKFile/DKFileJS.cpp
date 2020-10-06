#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DK/DKFile.h"
#include "DKFile/DKFileJS.h"

/////////////////////
bool DKFileJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKFile_ChDir", DKFileJS::ChDir);
	DKDuktape::AttachFunction("CPP_DKFile_Copy", DKFileJS::Copy);
	DKDuktape::AttachFunction("CPP_DKFile_CopyFolder", DKFileJS::CopyFolder);
	DKDuktape::AttachFunction("CPP_DKFile_Delete", DKFileJS::Delete);
	DKDuktape::AttachFunction("CPP_DKFile_DirectoryContents", DKFileJS::DirectoryContents);
	DKDuktape::AttachFunction("CPP_DKFile_Exists", DKFileJS::Exists);
	DKDuktape::AttachFunction("CPP_DKFile_FileToString", DKFileJS::FileToString);
	DKDuktape::AttachFunction("CPP_DKFile_GetAbsolutePath", DKFileJS::GetAbsolutePath);
	DKDuktape::AttachFunction("CPP_DKFile_GetDrives", DKFileJS::GetDrives);
	DKDuktape::AttachFunction("CPP_DKFile_GetExeName", DKFileJS::GetExeName);
	DKDuktape::AttachFunction("CPP_DKFile_GetExePath", DKFileJS::GetExePath);
	DKDuktape::AttachFunction("CPP_DKFile_GetExtention", DKFileJS::GetExtention);
	DKDuktape::AttachFunction("CPP_DKFile_GetFilename", DKFileJS::GetFilename);
	DKDuktape::AttachFunction("CPP_DKFile_GetLocalCreationDate", DKFileJS::GetLocalCreationDate);
	DKDuktape::AttachFunction("CPP_DKFile_GetLocalModifiedDate", DKFileJS::GetLocalModifiedDate);
	DKDuktape::AttachFunction("CPP_DKFile_GetModifiedTime", DKFileJS::GetModifiedTime);
	DKDuktape::AttachFunction("CPP_DKFile_GetRelativePath", DKFileJS::GetRelativePath);
	DKDuktape::AttachFunction("CPP_DKFile_GetSetting", DKFileJS::GetSetting);
	DKDuktape::AttachFunction("CPP_DKFile_GetShortName", DKFileJS::GetShortName);
	DKDuktape::AttachFunction("CPP_DKFile_IsDirectory", DKFileJS::IsDirectory);
	DKDuktape::AttachFunction("CPP_DKFile_MkDir", DKFileJS::MkDir);
	DKDuktape::AttachFunction("CPP_DKFile_Rename", DKFileJS::Rename);
	DKDuktape::AttachFunction("CPP_DKFile_SetSetting", DKFileJS::SetSetting);
	DKDuktape::AttachFunction("CPP_DKFile_StringToFile", DKFileJS::StringToFile);
	DKDuktape::AttachFunction("CPP_DKFile_VerifyPath", DKFileJS::VerifyPath);
	return true;
}

/////////////////////////////////////
int DKFileJS::ChDir(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKFile::ChDir(path);
	return 1;
}

////////////////////////////////////
int DKFileJS::Copy(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString src = duk_require_string(ctx, 0);
	DKString dest = duk_require_string(ctx, 1);
	bool overwrite = (duk_require_boolean(ctx, 2) != 0);
	if(!DKFile::Copy(src, dest, overwrite, true)){
		return 0;
	}
	return 1;
}

//////////////////////////////////////////
int DKFileJS::CopyFolder(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString src = duk_require_string(ctx, 0);
	DKString dst = duk_require_string(ctx, 1);
	bool overwrite = (duk_require_boolean(ctx, 2) != 0);
	bool recursive = (duk_require_boolean(ctx, 3) != 0);
	DKINFO("CopyFolder(" + src + "," + dst + "," + toString(overwrite) + "," + toString(recursive) + ")\n");
	if (!DKFile::CopyFolder(src, dst, overwrite, recursive)){
		DKERROR("DKFile::CopyFolder(): failed. \n");
		return 0;
	}
	return 1;
}

//////////////////////////////////////
int DKFileJS::Delete(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKFile::Delete(path);
	return 1;
}

/////////////////////////////////////////////////
int DKFileJS::DirectoryContents(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKStringArray arry;
	if(!DKFile::GetDirectoryContents(path, arry)){
		return 0;
	}
	DKString string = toString(arry, ",");
	duk_push_string(ctx, string.c_str());
	return 1;
}

//////////////////////////////////////
int DKFileJS::Exists(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	if (!DKFile::PathExists(path)){ return 0; }
	return 1;
}

////////////////////////////////////////////
int DKFileJS::FileToString(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString string;
	if (!DKFile::FileToString(path, string)){ return 0; }
	duk_push_string(ctx, string.c_str());
	return 1;
}

///////////////////////////////////////////////
int DKFileJS::GetAbsolutePath(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString aPath;
	if (!DKFile::GetAbsolutePath(path, aPath)){ return 0; }
	duk_push_string(ctx, aPath.c_str());
	return 1;
}

/////////////////////////////////////////
int DKFileJS::GetDrives(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKStringArray drives;
	DKFile::GetDrives(drives);
	duk_push_string(ctx, toString(drives, ",").c_str());
	return 1;
}

//////////////////////////////////////////
int DKFileJS::GetExeName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString value;
	if (!DKFile::GetExeName(value)){ return 0; }
	duk_push_string(ctx, value.c_str());
	return 1;
}

//////////////////////////////////////////
int DKFileJS::GetExePath(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString value;
	if (!DKFile::GetExePath(value)){ return 0; }
	duk_push_string(ctx, value.c_str());
	return 1;
}

////////////////////////////////////////////
int DKFileJS::GetExtention(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString extension;
	if (!DKFile::GetExtention(path, extension)){ return 0; }
	duk_push_string(ctx, extension.c_str());
	return 1;
}

///////////////////////////////////////////
int DKFileJS::GetFilename(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString filename;
	if (!DKFile::GetFileName(path, filename)){ return 0; }
	duk_push_string(ctx, filename.c_str());
	return 1;
}

////////////////////////////////////////////////////
int DKFileJS::GetLocalCreationDate(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString filedate;
	if(!DKFile::GetLocalCreationDate(path, filedate)){
		return 0;
	}

	//duk_push_string(ctx, filedate.c_str());
	char* pEnd;
	unsigned long long time = strtoull(filedate.c_str(), &pEnd, 10);
	duk_push_number(ctx, (double)time);
	return 1;
}

////////////////////////////////////////////////////
int DKFileJS::GetLocalModifiedDate(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString filedate;
	if (!DKFile::GetLocalModifiedDate(path, filedate)){
		return 0;
	}

	//duk_push_string(ctx, filedate.c_str());
	char* pEnd;
	unsigned long long time = strtoull(filedate.c_str(), &pEnd, 10);
	duk_push_number(ctx, (double)time);
	return 1;
}

///////////////////////////////////////////////
int DKFileJS::GetModifiedTime(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString value;
	if (!DKFile::GetModifiedTime(path, value)){ return 0; }
	duk_push_string(ctx, value.c_str());
	return 1;
}

///////////////////////////////////////////////
int DKFileJS::GetRelativePath(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString dir = duk_require_string(ctx, 1);
	DKString rPath;
	if (!DKFile::GetRelativePath(path, dir, rPath)){ return 0; }
	duk_push_string(ctx, rPath.c_str());
	return 1;
}

//////////////////////////////////////////
int DKFileJS::GetSetting(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	DKString param = duk_require_string(ctx, 1);
	DKString value;
	DKFile::GetSetting(file, param, value);
	duk_push_string(ctx, value.c_str());
	return 1;
}

////////////////////////////////////////////
int DKFileJS::GetShortName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
#ifdef WIN32
	DKString shortname;
	if(DKFile::GetShortName(path, shortname)){
		duk_push_string(ctx, shortname.c_str());
		return 1;
	}
#endif
	duk_push_string(ctx, path.c_str());
	return 1;
}

///////////////////////////////////////////
int DKFileJS::IsDirectory(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	if(!DKFile::IsDirectory(path)){
		return 0;
	}
	duk_push_boolean(ctx, true);
	return 1;
}

/////////////////////////////////////
int DKFileJS::MkDir(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKFile::MakeDir(path);
	return 1;
}

//////////////////////////////////////
int DKFileJS::Rename(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString input = duk_require_string(ctx, 0);
	DKString output = duk_require_string(ctx, 1);
	bool overwrite = (duk_require_boolean(ctx, 2) != 0);
	if(!DKFile::Rename(input, output, overwrite)){
		return 0;
	}
	return 1;
}

//////////////////////////////////////////
int DKFileJS::SetSetting(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	DKString param = duk_require_string(ctx, 1);
	DKString value = duk_require_string(ctx, 2);
	if (!DKFile::SetSetting(file, param, value)){ return 0; }
	return 1;
}

////////////////////////////////////////////
int DKFileJS::StringToFile(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString string = duk_require_string(ctx, 0);
	DKString file = duk_require_string(ctx, 1);
	if (!DKFile::StringToFile(string, file)){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKFileJS::VerifyPath(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	if(!DKFile::VerifyPath(path)){
		return 0;
	}
	return 1;
}

#endif //USE_DKDuktape