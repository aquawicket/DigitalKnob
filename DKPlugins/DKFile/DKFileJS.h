#ifdef USE_DKDuktape 
#pragma once
#ifndef DKFileJS_H
#define DKFileJS_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////
class DKFileJS : public DKObjectT<DKFileJS>
{
public:
	bool Init();
	
	static int ChDir(duk_context* ctx);
	static int Copy(duk_context* ctx);
	static int CopyFolder(duk_context* ctx);
	static int Delete(duk_context* ctx);
	static int DirectoryContents(duk_context* ctx);
	static int Exists(duk_context* ctx);
	static int FileToString(duk_context* ctx);
	static int GetAbsolutePath(duk_context* ctx);
	static int GetDrives(duk_context* ctx);
	static int GetExeName(duk_context* ctx);
	static int GetExePath(duk_context* ctx);
	static int GetExtention(duk_context* ctx);
	static int GetFilename(duk_context* ctx);
	static int GetLocalCreationDate(duk_context* ctx);
	static int GetLocalModifiedDate(duk_context* ctx);
	static int GetModifiedTime(duk_context* ctx);
	static int GetRelativePath(duk_context* ctx);
	static int GetSetting(duk_context* ctx);
	static int GetShortName(duk_context* ctx);
	static int IsDirectory(duk_context* ctx);
	static int MkDir(duk_context* ctx);
	static int Rename(duk_context* ctx);
	static int SetSetting(duk_context* ctx);
	static int StringToFile(duk_context* ctx);
	static int VerifyPath(duk_context* ctx);
};

REGISTER_OBJECT(DKFileJS, true)

#endif //DKFileJS_H
#endif //USE_DKDuktape