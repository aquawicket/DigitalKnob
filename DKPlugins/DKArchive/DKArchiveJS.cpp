#ifdef USE_DKDuktape 
#include "DKArchive/DKArchive.h"
#include "DKArchive/DKArchiveJS.h"

////////////////////////
bool DKArchiveJS::Init()
{
	DKDuktape::AttachFunction("DKCPP_DKArchive_Compress", DKArchiveJS::Compress);
	DKDuktape::AttachFunction("DKCPP_DKArchive_Extract", DKArchiveJS::Extract);
	//DKArchive::Instance("DKArchive0");
	return true;
}

///////////////////////////////////////////
int DKArchiveJS::Compress(duk_context* ctx)
{
	//DEBUGME
	DKString path = duk_require_string(ctx, 0);
	DKString file = duk_require_string(ctx, 1);
	if(!DKArchive::Extract(path, file)){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKArchiveJS::Extract(duk_context* ctx)
{
	//DEBUGME
	DKString file = duk_require_string(ctx, 0);
	DKString path = duk_require_string(ctx, 1);
	if(!DKArchive::Extract(file, path)){ return 0; }
	return 1;
}

#endif //USE_DKDuktape