#if HAVE_DKDuktape

#pragma once
#ifndef DKLocationDUK_H
#define DKLocationDUK_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [INTERFACE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
class DKLocationDUK : public DKObjectT<DKLocationDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKLocationDUK", DKLocationDUK::constructor);
		
		
		////// Instance properties //////
		// [Location.ancestorOrigins] https://developer.mozilla.org/en-US/docs/Web/API/Location/ancestorOrigins
		// [Location.href] https://developer.mozilla.org/en-US/docs/Web/API/Location/href
		// [Location.protocol] https://developer.mozilla.org/en-US/docs/Web/API/Location/protocol
		// [Location.host] https://developer.mozilla.org/en-US/docs/Web/API/Location/host
		// [Location.hostname] https://developer.mozilla.org/en-US/docs/Web/API/Location/hostname
		// [Location.port] https://developer.mozilla.org/en-US/docs/Web/API/Location/port
		// [Location.pathname] https://developer.mozilla.org/en-US/docs/Web/API/Location/pathname
		// [Location.search] https://developer.mozilla.org/en-US/docs/Web/API/Location/search
		// [Location.hash] https://developer.mozilla.org/en-US/docs/Web/API/Location/hash
		// [Location.origin](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Location/origin
		
		
		////// Instance methods //////
		// [Location.assign()] https://developer.mozilla.org/en-US/docs/Web/API/Location/assign
		// [Location.reload()] https://developer.mozilla.org/en-US/docs/Web/API/Location/reload
		// [Location.replace()] https://developer.mozilla.org/en-US/docs/Web/API/Location/replace
		// [Location.toString()] https://developer.mozilla.org/en-US/docs/Web/API/Location/toString
		
		
		////// Load .js files
		DKClass::DKCreate("DKLocation/DKLocationDUK.js");
		
		return true;
	}
	
	////// Constructor //////
	// [Location()]
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKLocationDUK()\n");
		DKLocation* _location = new DKLocation();
		DKString eventTargetAddress = pointerToAddress(_location);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	
	////// Instance properties //////
	// [Location.ancestorOrigins] https://developer.mozilla.org/en-US/docs/Web/API/Location/ancestorOrigins
	// [Location.href] https://developer.mozilla.org/en-US/docs/Web/API/Location/href
	// [Location.protocol] https://developer.mozilla.org/en-US/docs/Web/API/Location/protocol
	// [Location.host] https://developer.mozilla.org/en-US/docs/Web/API/Location/host
	// [Location.hostname] https://developer.mozilla.org/en-US/docs/Web/API/Location/hostname
	// [Location.port] https://developer.mozilla.org/en-US/docs/Web/API/Location/port
	// [Location.pathname] https://developer.mozilla.org/en-US/docs/Web/API/Location/pathname
	// [Location.search] https://developer.mozilla.org/en-US/docs/Web/API/Location/search
	// [Location.hash] https://developer.mozilla.org/en-US/docs/Web/API/Location/hash
	// [Location.origin](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Location/origin
		
		
	////// Instance methods //////
	// [Location.assign()] https://developer.mozilla.org/en-US/docs/Web/API/Location/assign
	// [Location.reload()] https://developer.mozilla.org/en-US/docs/Web/API/Location/reload
	// [Location.replace()] https://developer.mozilla.org/en-US/docs/Web/API/Location/replace
	// [Location.toString()] https://developer.mozilla.org/en-US/docs/Web/API/Location/toString
	
};
REGISTER_OBJECT(DKLocationDUK, true)


#endif //DKLocationDUK_H
#endif //HAVE_DKDuktape