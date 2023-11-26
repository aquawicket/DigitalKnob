// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
#if HAVE_DKDuktape

#pragma once
#ifndef DKLocationDUK_H
#define DKLocationDUK_H

#include "DKDuktape/DKDuktape.h"


// [Exposed=Window]
// interface Location { // but see also additional creation steps and overridden internal methods
class DKLocationDUK : public DKObjectT<DKLocationDUK>
{
public:
	bool Init(){
		
		DKDuktape::AttachFunction("CPP_DKLocationDUK_constructor", 		DKLocationDUK::constructor);
		
		// [LegacyUnforgeable] stringifier attribute USVString href;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_href", 			DKLocationDUK::href);
		
		// [LegacyUnforgeable] readonly attribute USVString origin;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_origin", 			DKLocationDUK::origin);
		
		// [LegacyUnforgeable] attribute USVString protocol;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_protocol", 		DKLocationDUK::protocol);
		
		// [LegacyUnforgeable] attribute USVString host;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_host", 			DKLocationDUK::host);
		
		// [LegacyUnforgeable] attribute USVString hostname;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_hostname", 		DKLocationDUK::hostname);
		
		// [LegacyUnforgeable] attribute USVString port;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_port", 			DKLocationDUK::port);
		
		// [LegacyUnforgeable] attribute USVString pathname;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_pathname",		 	DKLocationDUK::pathname);
		
		// [LegacyUnforgeable] attribute USVString search;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_search", 			DKLocationDUK::search);

		// [LegacyUnforgeable] attribute USVString hash;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_hash", 			DKLocationDUK::hash);
		
		// [LegacyUnforgeable] undefined assign(USVString url);
		DKDuktape::AttachFunction("CPP_DKLocationDUK_assign", 			DKLocationDUK::assign);
		
		// [LegacyUnforgeable] undefined replace(USVString url);
		DKDuktape::AttachFunction("CPP_DKLocationDUK_replace", 			DKLocationDUK::replace);
		
		// [LegacyUnforgeable] undefined reload();
		DKDuktape::AttachFunction("CPP_DKLocationDUK_reload", 			DKLocationDUK::reload);
		
		// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_ancestorOrigins", 	DKLocationDUK::ancestorOrigins);
		
		
		////// Load .js files //////
		DKClass::DKCreate("DKLocation/DKLocationDUK.js");
		
		return true;
	}
	
	static DKLocation* location(duk_context* ctx){
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
		DKString locationAddress = interface->address["Location"];
		DKLocation* _location = (DKLocation*)addressToPointer(locationAddress);
		return _location;
	}
	static bool GetBool(duk_context* ctx){
		if (duk_is_boolean(ctx, 1))
			return duk_to_boolean(ctx, 1);
		return false;
	}
	static double GetDouble(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_number(ctx, 1);
		return 0.0;
	}
	static int GetInt(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_int(ctx, 1);
		return 0;
	}
	static DKString GetString(duk_context* ctx){
		if (duk_is_string(ctx, 1))
			return duk_to_string(ctx, 1);
		return "";
	}
	static unsigned int GetUint(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_uint(ctx, 1);
		return 0;
	}
	
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		
		DKINFO("CPP_DKLocationDUK_constructor()\n");
		DKLocation* _location = new DKLocation();
		dukglue_push(ctx, _location->interfaceAddress);
		return true;
	}
	
	// [LegacyUnforgeable] stringifier attribute USVString href;
	static int href(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			location(ctx)->href(GetString(ctx));
		dukglue_push(ctx, location(ctx)->href());
		return true;
	}
	
	// [LegacyUnforgeable] readonly attribute USVString origin;
	static int origin(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			location(ctx)->origin(GetString(ctx));
		dukglue_push(ctx, location(ctx)->origin());
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString protocol;
	static int protocol(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			location(ctx)->protocol(GetString(ctx));
		dukglue_push(ctx, location(ctx)->protocol());
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString host;
	static int host(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			location(ctx)->host(GetString(ctx));
		dukglue_push(ctx, location(ctx)->host());
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString hostname;
	static int hostname(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			location(ctx)->hostname(GetString(ctx));
		dukglue_push(ctx, location(ctx)->hostname());
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString port;
	static int port(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			location(ctx)->port(GetString(ctx));
		dukglue_push(ctx, location(ctx)->port());
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString pathname;
	static int pathname(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			location(ctx)->pathname(GetString(ctx));
		dukglue_push(ctx, location(ctx)->pathname());
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString search;
	static int search(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			location(ctx)->search(GetString(ctx));
		dukglue_push(ctx, location(ctx)->search());
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString hash;
	static int hash(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			location(ctx)->hash(GetString(ctx));
		dukglue_push(ctx, location(ctx)->hash());
		return true;
	}
	
	// [LegacyUnforgeable] undefined assign(USVString url);
	static int assign(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString url = GetString(ctx);
		location(ctx)->assign(url);
		return true;
	}
	
	// [LegacyUnforgeable] undefined replace(USVString url);
	static int replace(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString url = GetString(ctx);
		location(ctx)->replace(url);
		return true;
	}
	
	// [LegacyUnforgeable] undefined reload();
	static int reload(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		location(ctx)->reload();
		return true;
	}
	
	// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
	static int ancestorOrigins(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			location(ctx)->ancestorOrigins(GetString(ctx));
		dukglue_push(ctx, location(ctx)->ancestorOrigins());
		return true;
	}
	
};
REGISTER_OBJECT(DKLocationDUK, true)


#endif //DKLocationDUK_H
#endif //HAVE_DKDuktape