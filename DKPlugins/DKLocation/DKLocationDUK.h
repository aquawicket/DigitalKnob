// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Location.idl
// [SOURCE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
#if HAVE_DKDuktape

#pragma once
#ifndef DKLocationDUK_H
#define DKLocationDUK_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window]
// interface Location { // but see also additional creation steps and overridden internal methods
class DKLocationDUK : public DKObjectT<DKLocationDUK>
{
public:
	bool Init(){
		
		DKDuktape::AttachFunction("CPP_DKLocationDUK", DKLocationDUK::constructor);
		
		// [LegacyUnforgeable] stringifier attribute USVString href;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_href", DKLocationDUK::href);
		
		// [LegacyUnforgeable] readonly attribute USVString origin;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_origin", DKLocationDUK::origin);
		
		// [LegacyUnforgeable] attribute USVString protocol;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_protocol", DKLocationDUK::protocol);
		
		// [LegacyUnforgeable] attribute USVString host;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_host", DKLocationDUK::host);
		
		// [LegacyUnforgeable] attribute USVString hostname;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_hostname", DKLocationDUK::hostname);
		
		// [LegacyUnforgeable] attribute USVString port;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_port", DKLocationDUK::port);
		
		// [LegacyUnforgeable] attribute USVString pathname;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_pathname", DKLocationDUK::pathname);
		
		// [LegacyUnforgeable] attribute USVString search;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_search", DKLocationDUK::search);
		
		// [LegacyUnforgeable] attribute USVString hash;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_hash", DKLocationDUK::hash);
		
		// [LegacyUnforgeable] undefined assign(USVString url);
		DKDuktape::AttachFunction("CPP_DKLocationDUK_assign", DKLocationDUK::assign);
		
		// [LegacyUnforgeable] undefined replace(USVString url);
		DKDuktape::AttachFunction("CPP_DKLocationDUK_replace", DKLocationDUK::replace);
		
		// [LegacyUnforgeable] undefined reload();
		DKDuktape::AttachFunction("CPP_DKLocationDUK_reload", DKLocationDUK::reload);
		
		// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
		DKDuktape::AttachFunction("CPP_DKLocationDUK_ancestorOrigins", DKLocationDUK::ancestorOrigins);
		
		
		////// Load .js files //////
		DKClass::DKCreate("DKLocation/DKLocationDUK.js");
		
		return true;
	}
	
	static DKLocation* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKLocation*)addressToPointer(eventTargetAddress);
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
		DKINFO("CPP_DKLocationDUK()\n");
		DKLocation* _location = new DKLocation();
		DKString eventTargetAddress = pointerToAddress(_location);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	// [LegacyUnforgeable] stringifier attribute USVString href;
	static int href(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _href = GetString(ctx);
		if(!eventTarget(ctx)->href(_href, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _href);
		return true;
	}
	
	// [LegacyUnforgeable] readonly attribute USVString origin;
	static int origin(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _origin = GetString(ctx);
		if(!eventTarget(ctx)->origin(_origin, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _origin);
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString protocol;
	static int protocol(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _protocol = GetString(ctx);
		if(!eventTarget(ctx)->protocol(_protocol, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _protocol);
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString host;
	static int host(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _host = GetString(ctx);
		if(!eventTarget(ctx)->host(_host, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _host);
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString hostname;
	static int hostname(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _hostname = GetString(ctx);
		if(!eventTarget(ctx)->hostname(_hostname, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _hostname);
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString port;
	static int port(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _port = GetString(ctx);
		if(!eventTarget(ctx)->port(_port, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _port);
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString pathname;
	static int pathname(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _pathname = GetString(ctx);
		if(!eventTarget(ctx)->pathname(_pathname, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _pathname);
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString search;
	static int search(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _search = GetString(ctx);
		if(!eventTarget(ctx)->search(_search, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _search);
		return true;
	}
	
	// [LegacyUnforgeable] attribute USVString hash;
	static int hash(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _hash = GetString(ctx);
		if(!eventTarget(ctx)->hash(_hash, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _hash);
		return true;
	}
	
	// [LegacyUnforgeable] undefined assign(USVString url);
	static int assign(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString url = GetString(ctx);
		if(!eventTarget(ctx)->assign(url))
			return false;
		return true;
	}
	
	// [LegacyUnforgeable] undefined replace(USVString url);
	static int replace(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString url = GetString(ctx);
		if(!eventTarget(ctx)->replace(url))
			return false;
		return true;
	}
	
	// [LegacyUnforgeable] undefined reload();
	static int reload(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(!eventTarget(ctx)->reload())
			return false;
		return true;
	}
	
	// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
	static int ancestorOrigins(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _ancestorOrigins = GetString(ctx);
		if(!eventTarget(ctx)->ancestorOrigins(_ancestorOrigins, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _ancestorOrigins);
		return true;
	}
	
};
REGISTER_OBJECT(DKLocationDUK, true)


#endif //DKLocationDUK_H
#endif //HAVE_DKDuktape