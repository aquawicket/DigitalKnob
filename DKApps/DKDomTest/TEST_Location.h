// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Location.idl
// [SOURCE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
#pragma once
#ifndef TEST_Location_H
#define TEST_Location_H

#include "DK/DK.h"
#include "DKLocation/DKLocation.h"


class TEST_Location : public DKObjectT<TEST_Location>
{
public:
	bool Init(){
		DKINFO("////// TEST_Location.h ////// \n");
		
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
	
		return DKTODO();
	}
};
REGISTER_OBJECT(TEST_Location, true);


#endif //TEST_Location_H