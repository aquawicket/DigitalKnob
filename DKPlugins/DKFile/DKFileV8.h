#pragma once
#ifndef DKFileV8_H
#define DKFileV8_H

#include "DKCef.h"

///////////////////////////////////////////
class DKFileV8 : public DKObjectT<DKFileV8>
{
public:
	void Init();
	void End();

	//static bool Test(CefArgs args, CefReturn retval);
	static bool DirectoryContents(CefArgs args, CefReturn retval);
	static bool GetShortName(CefArgs args, CefReturn retval);
	static bool IsDirectory(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKFileV8, false);

#endif //DKFileV8_H