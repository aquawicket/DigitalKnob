// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Location.idl
// [SOURCE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
#pragma once
#ifndef DKRmlLocation_H
#define DKRmlLocation_H

#include "DK/DK.h"
#include "DKLocation/DKLocation.h"

// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window]
// interface Location { // but see also additional creation steps and overridden internal methods
class DKRmlLocation : public DKLocation, public DKObjectT<DKRmlLocation>
{
public:
	DKRmlLocation() : DKLocation() {
		DKDEBUGFUNC();
		interfaceName = "RmlLocation";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKRmlLocation("+interfaceAddress+") \n");
	}
	virtual ~DKRmlLocation() {}

	// [LegacyUnforgeable] stringifier attribute USVString href;
	virtual bool href(DKString&, bool) { 
		return DKTODO();
	}  // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-href
	
	// [LegacyUnforgeable] readonly attribute USVString origin;
	virtual bool origin(DKString&, bool) { return DKTODO(); } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-origin
	
	// [LegacyUnforgeable] attribute USVString protocol;
	virtual bool protocol(DKString&, bool) { return DKTODO(); } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-protocol
	
	// [LegacyUnforgeable] attribute USVString host;
	virtual bool host(DKString&, bool) { return DKTODO(); } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-host
	
	// [LegacyUnforgeable] attribute USVString hostname;
	virtual bool hostname(DKString&, bool) { return DKTODO(); } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-hostname
	
	// [LegacyUnforgeable] attribute USVString port;
	virtual bool port(DKString&, bool) { return DKTODO(); } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-port
	
	// [LegacyUnforgeable] attribute USVString pathname;
	virtual bool pathname(DKString&, bool) { return DKTODO(); } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-pathname
	
	// [LegacyUnforgeable] attribute USVString search;
	virtual bool search(DKString&, bool) { return DKTODO(); } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-search
	
	// [LegacyUnforgeable] attribute USVString hash;
	virtual bool hash(DKString&, bool) { return DKTODO(); } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-hash

	// [LegacyUnforgeable] undefined assign(USVString url);
	virtual bool assign(DKString& url) { // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-assign
		DKDEBUGFUNC(url);
		return DKTODO();
	}
	
	// [LegacyUnforgeable] undefined replace(USVString url);
	virtual bool replace(DKString& url) { // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-replace
		DKDEBUGFUNC(url);
		return DKTODO();
	}
	
	// [LegacyUnforgeable] undefined reload();
	virtual bool reload() { // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-reload
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
	virtual bool ancestorOrigins(DKString&, bool) { return DKTODO(); } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-ancestororigins
};
REGISTER_OBJECT(DKRmlLocation, true);

#endif //DKLocation_H