#ifdef USE_DKDuktape
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKAssets/DKAssetsJS.h"

/////////////////////
void DKAssetsJS::Init()
{
	//DKDuktape::AttachFunction("DKAssets_AppendDataPath", DKAssetsJS::AppendDataPath);
	DKDuktape::AttachFunction("DKAssets_LocalAssets", DKAssetsJS::LocalAssets);
	DKDuktape::AttachFunction("DKAssets_Protocol", DKAssetsJS::Protocol);
}

///////////////////////////////////////////
//int DKAssetsJS::AppendDataPath(duk_context* ctx)
//{
//	DKString path = duk_require_string(ctx, 0);
//	if (!DKAssets::AppendDataPath(path)){ return 0; }
//	return 1;
//}

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


#endif //USE_DKDuktape