#include "DK/stdafx.h"
#ifdef WIN32
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKHook/DKHook.h"


///////////////////
void DKHook::Init()
{
	DKString path = DKFile::local_assets + "DKHook/hookdll.dll";
	hModule = LoadLibrary(path.c_str());
	if(NULL == hModule){
		DKLog("DKHook::DKHook(): cannot find hookdll.dll \n", DKERROR);
	}
}

//////////////////
void DKHook::End()
{
	if(hModule){FreeLibrary(hModule);}
}

#endif //WIN32