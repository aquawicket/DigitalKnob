#ifdef WIN32
#pragma once
#ifndef DKHook_H
#define DKHook_H

#include "DK/DK.h"

//Functions in DKHookDLL.dll
typedef bool(*InstallHook)(unsigned long);
typedef bool(*UnInstallHook)();

///////////////////////////////////////
class DKHook : public DKObjectT<DKHook>
{
public:
	void Init();
	void End();

	HMODULE hModule;  //dll module
};

REGISTER_OBJECT(DKHook, true);
#endif //DKHook_H
#endif //WIN32 || WIN64