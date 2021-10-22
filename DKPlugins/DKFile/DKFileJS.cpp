#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DK/DKFile.h"
#include "DKFile/DKFileJS.h"

bool DKFileJS::Init(){
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
	DKDuktape::AttachFunction("CPP_DKFile_GetPaths", DKFileJS::GetPaths);
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

int DKFileJS::ChDir(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKFile::ChDir(path);
	return true;
}

int DKFileJS::Copy(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString src = duk_require_string(ctx, 0);
	DKString dest = duk_require_string(ctx, 1);
	bool overwrite = (duk_require_boolean(ctx, 2) != 0);
	if(!DKFile::Copy(src, dest, overwrite, true))
		return DKERROR("DKFile::Copy() failed\n");
	return true;
}

int DKFileJS::CopyFolder(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString src = duk_require_string(ctx, 0);
	DKString dst = duk_require_string(ctx, 1);
	bool overwrite = (duk_require_boolean(ctx, 2) != 0);
	bool recursive = (duk_require_boolean(ctx, 3) != 0);
	DKINFO("CopyFolder(" + src + "," + dst + "," + toString(overwrite) + "," + toString(recursive) + ")\n");
	if (!DKFile::CopyFolder(src, dst, overwrite, recursive))
		return DKERROR("DKFile::CopyFolder(): failed. \n");
	return true;
}

int DKFileJS::Delete(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKFile::Delete(path);
	return true;
}

int DKFileJS::DirectoryContents(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKStringArray arry;
	if(!DKFile::GetDirectoryContents(path, arry))
		return DKERROR("DKFile::GetDirectoryContents("+path+") failed \n");
	DKString string = toString(arry, ",");
	duk_push_string(ctx, string.c_str());
	return true;
}

int DKFileJS::Exists(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	if(!DKFile::PathExists(path)){
		duk_push_boolean(ctx, false);
		return true;
	}
	duk_push_boolean(ctx, true);
	return true;
}

int DKFileJS::FileToString(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString string;
	if (!DKFile::FileToString(path, string))
		return DKERROR("DKFile::FileToString() failed\n")
	duk_push_string(ctx, string.c_str());
	return true;
}

int DKFileJS::GetAbsolutePath(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString aPath;
	if (!DKFile::GetAbsolutePath(path, aPath))
		return DKERROR("DKFile::GetAbsolutePath() failed\n")
	duk_push_string(ctx, aPath.c_str());
	return true;
}

int DKFileJS::GetDrives(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKStringArray drives;
	DKFile::GetDrives(drives);
	duk_push_string(ctx, toString(drives, ",").c_str());
	return true;
}

int DKFileJS::GetExeName(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString value;
	if (!DKFile::GetExeName(value))
		return DKERROR("DKFile::GetExeName() failed \n")
	duk_push_string(ctx, value.c_str());
	return true;
}

int DKFileJS::GetExePath(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString value;
	if (!DKFile::GetExePath(value))
		return DKERROR("DKFile::GetExePath() failed \n");
	duk_push_string(ctx, value.c_str());
	return true;
}

int DKFileJS::GetExtention(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString extension;
	if (!DKFile::GetExtention(path, extension))
		return DKERROR("DKFile::GetExtention() failed \n");
	duk_push_string(ctx, extension.c_str());
	return true;
}

int DKFileJS::GetFilename(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString filename;
	if (!DKFile::GetFileName(path, filename))
		return DKERROR("DKFile::GetFileName() failed \n");
	duk_push_string(ctx, filename.c_str());
	return true;
}

int DKFileJS::GetLocalCreationDate(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString filedate;
	if(!DKFile::GetLocalCreationDate(path, filedate))
		return DKERROR("DKFile::GetLocalCreationDate() failed \n");
	//duk_push_string(ctx, filedate.c_str());
	char* pEnd;
	unsigned long long time = strtoull(filedate.c_str(), &pEnd, 10);
	duk_push_number(ctx, (double)time);
	return true;
}

int DKFileJS::GetLocalModifiedDate(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString filedate;
	if (!DKFile::GetLocalModifiedDate(path, filedate))
		return DKERROR("DKFile::GetLocalModifiedDat() failed \n");
	//duk_push_string(ctx, filedate.c_str());
	char* pEnd;
	unsigned long long time = strtoull(filedate.c_str(), &pEnd, 10);
	duk_push_number(ctx, (double)time);
	return true;
}

int DKFileJS::GetModifiedTime(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString value;
	if (!DKFile::GetModifiedTime(path, value))
		return DKERROR("DKFile::GetModifiedTime() failed \n");
	duk_push_string(ctx, value.c_str());
	return true;
}

//TODO
int DKFileJS::GetPaths(duk_context* ctx) {
	DKString path = duk_require_string(ctx, 0);
	DKString aPath;
	if (!DKFile::GetAbsolutePath(path, aPath))
		return DKERROR("DKFile::GetAbsolutePath() failed\n");
	DKString root;
	DKString dir;
	if (!DKFile::GetFilePath(path, dir))
		return DKERROR("DKFile::GetFilePath() failed \n");
	DKString rPath;
	if (!DKFile::GetRelativePath(path, dir, rPath))
		return DKERROR("DKFile::GetRelativePath() failed \n");
	DKString realpath;
	DKString basename;
	DKString extension;
	if (!DKFile::GetExtention(path, extension))
		return DKERROR("DKFile::GetExtention() failed \n");
	DKString filename;
	if (!DKFile::GetFileName(path, filename))
		return DKERROR("DKFile::GetFileName() failed \n");
	DKString output = path+","+aPath+","+root+","+rPath+","+realpath+","+dir+","+basename+","+extension+","+filename;
	duk_push_string(ctx, output.c_str());
	DKDEBUGRETURN(ctx, output);
	return true;
}

int DKFileJS::GetRelativePath(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString dir = duk_require_string(ctx, 1);
	DKString rPath;
	if (!DKFile::GetRelativePath(path, dir, rPath))
		return DKERROR("DKFile::GetRelativePath() failed \n");
	duk_push_string(ctx, rPath.c_str());
	return true;
}

int DKFileJS::GetSetting(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	DKString param = duk_require_string(ctx, 1);
	DKString value;
	DKFile::GetSetting(file, param, value);
	duk_push_string(ctx, value.c_str());
	return true;
}

int DKFileJS::GetShortName(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
#ifdef WIN32
	DKString shortname;
	if(DKFile::GetShortName(path, shortname)){
		duk_push_string(ctx, shortname.c_str());
		return true;
	}
#endif
	duk_push_string(ctx, path.c_str());
	return true;
}

int DKFileJS::IsDirectory(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	if(!DKFile::IsDirectory(path)){
		duk_push_boolean(ctx, false);
		return true;
	}
	duk_push_boolean(ctx, true);
	return true;
}

int DKFileJS::MkDir(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKFile::MakeDir(path);
	return true;
}

int DKFileJS::Rename(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString input = duk_require_string(ctx, 0);
	DKString output = duk_require_string(ctx, 1);
	bool overwrite = (duk_require_boolean(ctx, 2) != 0);
	if(!DKFile::Rename(input, output, overwrite))
		return DKWARN("DKFile::Rename() failed \n");
	return true;
}

int DKFileJS::SetSetting(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	DKString param = duk_require_string(ctx, 1);
	DKString value = duk_require_string(ctx, 2);
	if (!DKFile::SetSetting(file, param, value))
		return DKERROR("DKFile::SetSetting() failed \n");
	return true;
}

int DKFileJS::StringToFile(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString string = duk_require_string(ctx, 0);
	DKString file = duk_require_string(ctx, 1);
	if (!DKFile::StringToFile(string, file))
		return DKERROR("DKFile::StringToFile() failed \n");
	return true;
}

int DKFileJS::VerifyPath(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	if(!DKFile::VerifyPath(path))
		return DKERROR("DKFile::VerifyPath() failed \n");
	return true;
}

#endif //USE_DKDuktape