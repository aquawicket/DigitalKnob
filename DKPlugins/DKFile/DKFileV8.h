#ifdef USE_DKCef
#pragma once
#ifndef DKFileV8_H
#define DKFileV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////
class DKFileV8 : public DKObjectT<DKFileV8>
{
public:
	bool Init();
	bool End();
	
	static bool ChDir(CefArgs args, CefReturn retval);
	static bool Copy(CefArgs args, CefReturn retval);
	static bool CopyFolder(CefArgs args, CefReturn retval);
	static bool Delete(CefArgs args, CefReturn retval);
	static bool DirectoryContents(CefArgs args, CefReturn retval);
	static bool Exists(CefArgs args, CefReturn retval);
	static bool FileToString(CefArgs args, CefReturn retval);
	static bool GetAbsolutePath(CefArgs args, CefReturn retval);
	static bool GetSetting(CefArgs args, CefReturn retval);
	static bool GetShortName(CefArgs args, CefReturn retval);
	static bool IsDirectory(CefArgs args, CefReturn retval);
	static bool MkDir(CefArgs args, CefReturn retval);
	static bool Rename(CefArgs args, CefReturn retval);
	static bool SetSetting(CefArgs args, CefReturn retval);
	static bool StringToFile(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKFileV8, false);

#endif //DKFileV8_H
#endif //USE_DKCef