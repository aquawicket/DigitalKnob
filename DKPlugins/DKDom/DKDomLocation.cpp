//https://developer.mozilla.org/en-US/docs/Web/API/Location

#include "DK/DKApp.h"
#include "DKRml/DKRml.h"
#include "DKDom/DKDomLocation.h"


bool DKDomLocation::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKDomLocation_hash", DKDomLocation::hash);
	DKDuktape::AttachFunction("CPP_DKDomLocation_host", DKDomLocation::host);
	DKDuktape::AttachFunction("CPP_DKDomLocation_hostname", DKDomLocation::hostname);
	DKDuktape::AttachFunction("CPP_DKDomLocation_href", DKDomLocation::href);
	DKDuktape::AttachFunction("CPP_DKDomLocation_origin", DKDomLocation::origin);
	DKDuktape::AttachFunction("CPP_DKDomLocation_password", DKDomLocation::password);
	DKDuktape::AttachFunction("CPP_DKDomLocation_pathname", DKDomLocation::pathname);
	DKDuktape::AttachFunction("CPP_DKDomLocation_port", DKDomLocation::port);
	DKDuktape::AttachFunction("CPP_DKDomLocation_protocol", DKDomLocation::protocol);
	DKDuktape::AttachFunction("CPP_DKDomLocation_search", DKDomLocation::search);
	DKDuktape::AttachFunction("CPP_DKDomLocation_username", DKDomLocation::username);
	DKClass::DKCreate("DKDom/DKDomLocation.js");
	return true;
}

int DKDomLocation::hash(duk_context* ctx){
	int found = DKRml::Get()->href.find("#");
	DKString hash;
	if(found > 0)
		hash = DKRml::Get()->href.substr(found);
	duk_push_string(ctx, hash.c_str());
	return true;
}

int DKDomLocation::host(duk_context* ctx){
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

int DKDomLocation::hostname(duk_context* ctx){
	DKString hostname = DKRml::Get()->href;
	//TODO
	// 127.0.0.1 is the hostname of http://127.0.0.1/Test/file.html
	int found = hostname.find("//");
	if(found != std::string::npos)
		hostname.erase(0, found);
	hostname = "not implemented";
	duk_push_string(ctx, hostname.c_str());
	return true;
}

int DKDomLocation::href(duk_context* ctx){
	if(duk_is_string(ctx, 0)){
		DKString url = duk_get_string(ctx, 0);
		DKRml::Get()->LoadUrl(url);
	}
	duk_push_string(ctx, DKRml::Get()->href.c_str());
	return true;
}

int DKDomLocation::origin(duk_context* ctx){
	DKString origin = "TODO";
	duk_push_string(ctx, origin.c_str());
	return true;
}

int DKDomLocation::password(duk_context* ctx){
	DKString password = "TODO";
	duk_push_string(ctx, password.c_str());
	return true;
}

int DKDomLocation::pathname(duk_context* ctx){
	DKString pathname = "TODO";
	duk_push_string(ctx, pathname.c_str());
	return true;
}

int DKDomLocation::port(duk_context* ctx){
	DKString port = "TODO";
	duk_push_string(ctx, port.c_str());
	return true;
}

int DKDomLocation::protocol(duk_context* ctx){
	DKString protocol = "TODO";
	duk_push_string(ctx, protocol.c_str());
	return true;
}

int DKDomLocation::search(duk_context* ctx){
	DKString search = "TODO";
	duk_push_string(ctx, search.c_str());
	return true;
}

int DKDomLocation::username(duk_context* ctx){
	DKString username = "TODO";
	duk_push_string(ctx, username.c_str());
	return true;
}
