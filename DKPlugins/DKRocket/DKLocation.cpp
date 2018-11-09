#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKLocation.h"
#include "DKRocket/DKRocket.h"


///////////////////////
bool DKLocation::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKLocation_hash", DKLocation::hash);
	DKDuktape::AttachFunction("DKLocation_host", DKLocation::host);
	DKDuktape::AttachFunction("DKLocation_hostname", DKLocation::hostname);
	DKDuktape::AttachFunction("DKLocation_href", DKLocation::href);
	DKDuktape::AttachFunction("DKLocation_origin", DKLocation::origin);
	DKDuktape::AttachFunction("DKLocation_password", DKLocation::password);
	DKDuktape::AttachFunction("DKLocation_pathname", DKLocation::pathname);
	DKDuktape::AttachFunction("DKLocation_port", DKLocation::port);
	DKDuktape::AttachFunction("DKLocation_protocol", DKLocation::protocol);
	DKDuktape::AttachFunction("DKLocation_search", DKLocation::search);
	DKDuktape::AttachFunction("DKLocation_username", DKLocation::username);
	
	DKClass::DKCreate("DKRocket/DKLocation.js");
	return true;
}

//////////////////////////////////////
int DKLocation::hash(duk_context* ctx)
{
	int found = DKRocket::Get()->href.find("#");
	DKString hash;
	if(found > 0){
		hash = DKRocket::Get()->href.substr(found);
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
	duk_push_string(ctx, DKRocket::Get()->href.c_str());
	return true;
}

////////////////////////////////////////
int DKLocation::origin(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////////
int DKLocation::password(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////////
int DKLocation::pathname(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////
int DKLocation::port(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////////
int DKLocation::protocol(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

////////////////////////////////////////
int DKLocation::search(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////////
int DKLocation::username(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

#endif //USE_DKDuktape