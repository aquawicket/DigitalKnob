//https://developer.mozilla.org/en-US/docs/Web/API/Location

#include "DK/DKApp.h"
#include "DKRml/DKRml.h"
#include "DKDom/DKDomLocation.h"


///////////////////////
bool DKDomLocation::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKDomLocation_hash", DKDomLocation::hash);
	DKDuktape::AttachFunction("DKDomLocation_host", DKDomLocation::host);
	DKDuktape::AttachFunction("DKDomLocation_hostname", DKDomLocation::hostname);
	DKDuktape::AttachFunction("DKDomLocation_href", DKDomLocation::href);
	DKDuktape::AttachFunction("DKDomLocation_origin", DKDomLocation::origin);
	DKDuktape::AttachFunction("DKDomLocation_password", DKDomLocation::password);
	DKDuktape::AttachFunction("DKDomLocation_pathname", DKDomLocation::pathname);
	DKDuktape::AttachFunction("DKDomLocation_port", DKDomLocation::port);
	DKDuktape::AttachFunction("DKDomLocation_protocol", DKDomLocation::protocol);
	DKDuktape::AttachFunction("DKDomLocation_search", DKDomLocation::search);
	DKDuktape::AttachFunction("DKDomLocation_username", DKDomLocation::username);
	
	DKClass::DKCreate("DKDom/DKDomLocation.js");
	return true;
}

/////////////////////////////////////////
int DKDomLocation::hash(duk_context* ctx)
{
	int found = DKRml::Get()->href.find("#");
	DKString hash;
	if(found > 0){
		hash = DKRml::Get()->href.substr(found);
	}
	duk_push_string(ctx, hash.c_str());
	return true;
}

/////////////////////////////////////////
int DKDomLocation::host(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

/////////////////////////////////////////////
int DKDomLocation::hostname(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

/////////////////////////////////////////
int DKDomLocation::href(duk_context* ctx)
{
	if(duk_is_string(ctx, 0)){
		DKString url = duk_get_string(ctx, 0);
		DKRml::Get()->LoadUrl(url);
	}
	duk_push_string(ctx, DKRml::Get()->href.c_str());
	return true;
}

///////////////////////////////////////////
int DKDomLocation::origin(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

/////////////////////////////////////////////
int DKDomLocation::password(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

/////////////////////////////////////////////
int DKDomLocation::pathname(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

/////////////////////////////////////////
int DKDomLocation::port(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

/////////////////////////////////////////////
int DKDomLocation::protocol(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

///////////////////////////////////////////
int DKDomLocation::search(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

/////////////////////////////////////////////
int DKDomLocation::username(duk_context* ctx)
{
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}