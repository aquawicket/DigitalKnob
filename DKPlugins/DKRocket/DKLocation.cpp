#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKLocation.h"
#include "DKRocket/DKRocket.h"


///////////////////////
bool DKLocation::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKLocation_href", DKLocation::href);
	
	DKClass::DKCreate("DKDuktape/DKLocation.js");
	return true;
}

//////////////////////////////////////
int DKLocation::href(duk_context* ctx)
{
	duk_push_string(ctx, DKRocket::Get()->_url.c_str());
	return true;
}

#endif //USE_DKDuktape