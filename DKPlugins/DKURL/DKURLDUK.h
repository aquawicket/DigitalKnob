// [IDL] https://url.spec.whatwg.org/#url-class
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/URL
#if HAVE_DKDuktape

#pragma once
#ifndef DKURLDUK_H
#define DKURLDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: URL Standard (https://url.spec.whatwg.org/)
// [Exposed=*,
// LegacyWindowAlias=webkitURL]
// interface URL {
class DKURLDUK : public DKObjectT<DKURLDUK>
{
public:
	bool Init(){
		
		// constructor(USVString url, optional USVString base);
		DKDuktape::AttachFunction("CPP_DKURLDUK_constructor", 		DKURLDUK::constructor);
		
		// static boolean canParse(USVString url, optional USVString base);
		DKDuktape::AttachFunction("CPP_DKURLDUK_canParse", 			DKURLDUK::canParse);
		
		// stringifier attribute USVString href;
		DKDuktape::AttachFunction("CPP_DKURLDUK_href", 				DKURLDUK::href);
		
		// readonly attribute USVString origin;
		DKDuktape::AttachFunction("CPP_DKURLDUK_origin", 			DKURLDUK::origin);
		
		// attribute USVString protocol;
		DKDuktape::AttachFunction("CPP_DKURLDUK_protocol", 			DKURLDUK::protocol);
		
		// attribute USVString username;
		DKDuktape::AttachFunction("CPP_DKURLDUK_username", 			DKURLDUK::username);
		
		// attribute USVString password;
		DKDuktape::AttachFunction("CPP_DKURLDUK_password", 			DKURLDUK::password);
		
		// attribute USVString host;
		DKDuktape::AttachFunction("CPP_DKURLDUK_host", 				DKURLDUK::host);
		
		// attribute USVString hostname;
		DKDuktape::AttachFunction("CPP_DKURLDUK_hostname", 			DKURLDUK::hostname);
		
		// attribute USVString port;
		DKDuktape::AttachFunction("CPP_DKURLDUK_port", 				DKURLDUK::port);
		
		// attribute USVString pathname;
		DKDuktape::AttachFunction("CPP_DKURLDUK_pathname", 			DKURLDUK::pathname);
		
		// attribute USVString search;
		DKDuktape::AttachFunction("CPP_DKURLDUK_search", 			DKURLDUK::search);
		
		// [SameObject] readonly attribute URLSearchParams searchParams;
		DKDuktape::AttachFunction("CPP_DKURLDUK_searchParams", 		DKURLDUK::searchParams);
		
		// attribute USVString hash;
		DKDuktape::AttachFunction("CPP_DKURLDUK_hash", 				DKURLDUK::hash);
		
		// USVString toJSON();
		DKDuktape::AttachFunction("CPP_DKURLDUK_toJSON", 			DKURLDUK::toJSON);
		
		// };	

		// Source: File API (https://www.w3.org/TR/FileAPI/)
		// [Exposed=(Window,DedicatedWorker,SharedWorker)]
		// partial interface URL {
		// static DOMString createObjectURL((Blob or MediaSource) obj);
		DKDuktape::AttachFunction("CPP_DKURLDUK_createObjectURL", 	DKURLDUK::createObjectURL);
		
		// static undefined revokeObjectURL(DOMString url);
		DKDuktape::AttachFunction("CPP_DKURLDUK_revokeObjectURL", 	DKURLDUK::revokeObjectURL);
		
		//};
		
		
		////// Load .js files //////
		DKClass::DKCreate("DKURL/DKURLDUK.js");
		
		return true;
	}
	
	static DKURL* url(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKURL*)addressToPointer(eventTargetAddress);
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
	
	// constructor(USVString url, optional USVString base);
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKURLDUK_constructor()\n");
		USVString url = GetString(ctx);
		USVString base = ""; // TODO
		DKURL* _url = new DKURL(url, base);
		DKString eventTargetAddress = pointerToAddress(_url);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	// static boolean canParse(USVString url, optional USVString base);
	static int canParse(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// stringifier attribute USVString href;
	static int href(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			url(ctx)->href(GetString(ctx));
		dukglue_push(ctx, url(ctx)->href());
		return true;
	}
	
	// readonly attribute USVString origin;
	static int origin(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			url(ctx)->origin(GetString(ctx));
		dukglue_push(ctx, url(ctx)->origin());
		return true;
	}
	
	// attribute USVString protocol;
	static int protocol(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			url(ctx)->protocol(GetString(ctx));
		dukglue_push(ctx, url(ctx)->protocol());
		return true;
	}
	
	// attribute USVString username;
	static int username(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			url(ctx)->username(GetString(ctx));
		dukglue_push(ctx, url(ctx)->username());
		return true;
	}
	
	// attribute USVString password;
	static int password(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			url(ctx)->password(GetString(ctx));
		dukglue_push(ctx, url(ctx)->password());
		return true;
	}
	
	// attribute USVString host;
	static int host(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			url(ctx)->host(GetString(ctx));
		dukglue_push(ctx, url(ctx)->host());
		return true;
	}
	
	// attribute USVString hostname;
	static int hostname(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			url(ctx)->hostname(GetString(ctx));
		dukglue_push(ctx, url(ctx)->hostname());
		return true;
	}
	
	// attribute USVString port;
	static int port(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			url(ctx)->port(GetString(ctx));
		dukglue_push(ctx, url(ctx)->port());
		return true;
	}
	
	// attribute USVString pathname;
	static int pathname(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			url(ctx)->pathname(GetString(ctx));
		dukglue_push(ctx, url(ctx)->pathname());
		return true;
	}
	
	// attribute USVString search;
	static int search(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			url(ctx)->search(GetString(ctx));
		dukglue_push(ctx, url(ctx)->search());
		return true;
	}
	
	// [SameObject] readonly attribute URLSearchParams searchParams;
	static int searchParams(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			url(ctx)->searchParams(GetString(ctx));
		dukglue_push(ctx, url(ctx)->searchParams());
		return true;
	}
	
	// attribute USVString hash;
	static int hash(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// USVString toJSON();
	static int toJSON(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// };	
	// Source: File API (https://www.w3.org/TR/FileAPI/)
	// [Exposed=(Window,DedicatedWorker,SharedWorker)]
	// partial interface URL {
	// static DOMString createObjectURL((Blob or MediaSource) obj);
	static int createObjectURL(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// static undefined revokeObjectURL(DOMString url);
	static int revokeObjectURL(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	//};
};
REGISTER_OBJECT(DKURLDUK, true)


#endif //DKURLDUK_H
#endif //HAVE_DKDuktape