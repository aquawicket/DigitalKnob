#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DK/DKFile.h"
#include "DKAssets/DKAssetsV8.h"

///////////////////////
bool DKAssetsV8::Init()
{
	DKLog("DKAssetsV8::Init()\n", DKDEBUG);
	DKV8::AttachFunction("DKAssets_LocalAssets", DKAssetsV8::LocalAssets);
	return true;
}

//////////////////////
bool DKAssetsV8::End()
{
	DKLog("DKAssetsV8::End()\n", DKDEBUG);
	return true;
}

////////////////////////////////////////////////////////////
bool DKAssetsV8::LocalAssets(CefArgs args, CefReturn retval)
{
	DKLog("DKAssetsV8::LocalAssets(CefArgs, CefReturn)\n", DKDEBUG);
	retval->SetString(0, DKFile::local_assets);
	return true;
}

#endif //USE_DKCef