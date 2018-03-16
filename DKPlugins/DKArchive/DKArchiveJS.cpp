#ifdef USE_DKDuktape 
#include "DKArchive/DKArchive.h"
#include "DKArchive/DKArchiveJS.h"

////////////////////////
bool DKArchiveJS::Init()
{
	DKDuktape::AttachFunction("DKArchive_Extract", DKArchiveJS::Extract);
	//DKArchive::Instance("DKArchive0");
	return true;
}

//////////////////////////////////////////
int DKArchiveJS::Extract(duk_context* ctx)
{
	//TODO
	//DKString url = duk_require_string(ctx, 0);
	//DKString dest = duk_require_string(ctx, 1);
	//if(!DKArchive::Get("DKArchive0")->Download(url, dest)){
	//	return 0;
	//}
	//return 1;
}

#endif //USE_DKDuktape