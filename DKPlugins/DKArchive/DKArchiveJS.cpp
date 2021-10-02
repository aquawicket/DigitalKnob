#ifdef USE_DKDuktape 
#include "DKArchive/DKArchive.h"
#include "DKArchive/DKArchiveJS.h"

bool DKArchiveJS::Init(){
	DKDuktape::AttachFunction("CPP_DKArchive_Compress", DKArchiveJS::Compress);
	DKDuktape::AttachFunction("CPP_DKArchive_Extract", DKArchiveJS::Extract);
	return true;
}

int DKArchiveJS::Compress(duk_context* ctx){
	DKString path = duk_require_string(ctx, 0);
	DKString file = duk_require_string(ctx, 1);
	if(!DKArchive::Compress(path, file))
		return DKERROR("DKArchive::Extract() failed");
	return true;
}

int DKArchiveJS::Extract(duk_context* ctx){
	DKString file = duk_require_string(ctx, 0);
	DKString path = duk_require_string(ctx, 1);
	if(!DKArchive::Extract(file, path)) 
		return DKERROR("DKArchive::Extract() failed");
	return true;
}

#endif //USE_DKDuktape