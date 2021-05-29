#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKRocketLocation.h"
#include "DKRocket/DKRocket.h"


///////////////////////
bool DKRocketLocation::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKRocketLocation_hash", DKRocketLocation::hash);
	DKDuktape::AttachFunction("DKRocketLocation_host", DKRocketLocation::host);
	DKDuktape::AttachFunction("DKRocketLocation_hostname", DKRocketLocation::hostname);
	DKDuktape::AttachFunction("DKRocketLocation_href", DKRocketLocation::href);
	DKDuktape::AttachFunction("DKRocketLocation_origin", DKRocketLocation::origin);
	DKDuktape::AttachFunction("DKRocketLocation_password", DKRocketLocation::password);
	DKDuktape::AttachFunction("DKRocketLocation_pathname", DKRocketLocation::pathname);
	DKDuktape::AttachFunction("DKRocketLocation_port", DKRocketLocation::port);
	DKDuktape::AttachFunction("DKRocketLocation_protocol", DKRocketLocation::protocol);
	DKDuktape::AttachFunction("DKRocketLocation_search", DKRocketLocation::search);
	DKDuktape::AttachFunction("DKRocketLocation_username", DKRocketLocation::username);
	
	DKClass::DKCreate("DKRocket/DKRocketLocation.js");
	return true;
}

//////////////////////////////////////
int DKRocketLocation::hash(duk_context* ctx)
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
int DKRocketLocation::host(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////////
int DKRocketLocation::hostname(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////
int DKRocketLocation::href(duk_context* ctx)
{
	if(duk_is_string(ctx, 0)){
		DKString url = duk_get_string(ctx, 0);
		DKRocket::Get()->LoadUrl(url);
	}
	duk_push_string(ctx, DKRocket::Get()->href.c_str());
	return true;
}

////////////////////////////////////////
int DKRocketLocation::origin(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////////
int DKRocketLocation::password(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////////
int DKRocketLocation::pathname(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////
int DKRocketLocation::port(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////////
int DKRocketLocation::protocol(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

////////////////////////////////////////
int DKRocketLocation::search(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

//////////////////////////////////////////
int DKRocketLocation::username(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

#endif //USE_DKDuktape