#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKDocument.h"
#include "DKRocket/DKRocket.h"


///////////////////////
bool DKDocument::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKDocument_href", DKDocument::href);
	
	DKClass::DKCreate("DKRocket/DKDocument.js");
	return true;
}

//////////////////////////////////////
int DKDocument::href(duk_context* ctx)
{
	if(duk_is_string(ctx, 0)){
		DKString url = duk_get_string(ctx, 0);
		DKRocket::Get()->LoadUrl(url);
	}
	duk_push_string(ctx, DKRocket::Get()->_url.c_str());
	return true;
}

#endif //USE_DKDuktape