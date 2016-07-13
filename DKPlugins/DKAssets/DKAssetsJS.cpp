#ifdef USE_DKDuktape
#include "DKAssetsJS.h"
#include "DKAssets.h"
#include "DKFile.h"

/////////////////////
void DKAssetsJS::Init()
{
	DKDuktape::AttachFunction("DKAssets_GetDataPath", DKAssetsJS::GetDataPath, 0);
	//DKDuktape::AttachFunction("DKAssets_AppendDataPath", DKAssetsJS::AppendDataPath, 1);
}

/////////////////////////////////////////////
int DKAssetsJS::GetDataPath(duk_context* ctx)
{
	duk_push_string(ctx, DKFile::local_assets.c_str());
	return 1;
}

///////////////////////////////////////////
//int DKAssetsJS::AppendDataPath(duk_context* ctx)
//{
//	DKString path = duk_require_string(ctx, 0);
//	if (!DKAssets::AppendDataPath(path)){ return 0; }
//	return 1;
//}

#endif //USE_DKDuktape