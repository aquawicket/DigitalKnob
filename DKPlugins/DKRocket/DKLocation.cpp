#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKLocation.h"
#include "DKRocket/DKRocket.h"


///////////////////////
bool DKLocation::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKLocation_hash", DKLocation::hash);
	//DKDuktape::AttachFunction("DKLocation_host", DKLocation::host); //TODO
	//DKDuktape::AttachFunction("DKLocation_hostname", DKLocation::hostname); //TODO
	DKDuktape::AttachFunction("DKLocation_href", DKLocation::href);
	
	DKClass::DKCreate("DKRocket/DKLocation.js");
	return true;
}

//////////////////////////////////////
int DKLocation::hash(duk_context* ctx)
{
	int found = DKRocket::Get()->_url.find("#");
	DKString hash;
	if(found > 0){
		hash = DKRocket::Get()->_url.substr(found);
	}
	duk_push_string(ctx, hash.c_str());
	return true;
}

//////////////////////////////////////
int DKLocation::host(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////////
int DKLocation::hostname(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////
int DKLocation::href(duk_context* ctx)
{
	if(duk_is_string(ctx, 0)){
		DKString url = duk_get_string(ctx, 0);
		DKRocket::Get()->LoadUrl(url);
	}
	duk_push_string(ctx, DKRocket::Get()->_url.c_str());
	return true;
}

#endif //USE_DKDuktape