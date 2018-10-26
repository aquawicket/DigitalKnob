#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DK/DKFile.h"
#include "DKAssets/DKAssetsV8.h"

///////////////////////
bool DKAssetsV8::Init()
{
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKAssets_LocalAssets", DKAssetsV8::LocalAssets);
	return true;
}

//////////////////////
bool DKAssetsV8::End()
{
	DKDEBUGFUNC();
	return true;
}

////////////////////////////////////////////////////////////
bool DKAssetsV8::LocalAssets(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	retval->SetString(0, DKFile::local_assets);
	return true;
}

#endif //USE_DKCef