#ifdef USE_DKDuktape
#include "DKAssetsJS.h"
#include "DKAssets.h"
#include "DKFile.h"

/////////////////////
void DKAssetsJS::Init()
{
	DKDuktape::AttachFunction("DKAssets_LocalAssets", DKAssetsJS::LocalAssets, 0);
	DKDuktape::AttachFunction("DKAssets_Protocol", DKAssetsJS::Protocol, 0);
	//DKDuktape::AttachFunction("DKAssets_AppendDataPath", DKAssetsJS::AppendDataPath, 1);
}

/////////////////////////////////////////////
int DKAssetsJS::LocalAssets(duk_context* ctx)
{
	duk_push_string(ctx, DKFile::local_assets.c_str());
	return 1;
}

//////////////////////////////////////////////
int DKAssetsJS::OnlineAssets(duk_context* ctx)
{
	duk_push_string(ctx, DKFile::online_assets.c_str());
	return 1;
}

//////////////////////////////////////////
int DKAssetsJS::Protocol(duk_context* ctx)
{
	duk_push_string(ctx, "file:");
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