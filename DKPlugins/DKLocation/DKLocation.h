// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
#pragma once
#ifndef DKLocation_H
#define DKLocation_H

#include "DK/DK.h"
//#include "DKInterface/DKInterface.h"	// TODO


// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window]
// interface Location { // but see also additional creation steps and overridden internal methods
class DKLocation //: public DKInterface
{
public:
	DKLocation(){
		DKDEBUGFUNC();
		interfaceName = "Location";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKLocation("+interfaceAddress+") \n");
	}
	virtual ~DKLocation() {}

	// [LegacyUnforgeable] stringifier attribute USVString href;
	virtual bool href(USVString&, bool) { 
		return false;
	}  // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-href
	
	// [LegacyUnforgeable] readonly attribute USVString origin;
	virtual bool origin(USVString&, bool) { return false; } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-origin
	
	// [LegacyUnforgeable] attribute USVString protocol;
	virtual bool protocol(USVString&, bool) { return false; } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-protocol
	
	// [LegacyUnforgeable] attribute USVString host;
	virtual bool host(USVString&, bool) { return false; } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-host
	
	// [LegacyUnforgeable] attribute USVString hostname;
	virtual bool hostname(USVString&, bool) { return false; } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-hostname
	
	// [LegacyUnforgeable] attribute USVString port;
	virtual bool port(USVString&, bool) { return false; } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-port
	
	// [LegacyUnforgeable] attribute USVString pathname;
	virtual bool pathname(USVString&, bool) { return false; } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-pathname
	
	// [LegacyUnforgeable] attribute USVString search;
	virtual bool search(USVString&, bool) { return false; } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-search
	
	// [LegacyUnforgeable] attribute USVString hash;
	virtual bool hash(USVString&, bool) { return false; } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-hash

	// [LegacyUnforgeable] undefined assign(USVString url);
	virtual bool assign(USVString& url) { // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-assign
		DKDEBUGFUNC(url);
		return DKTODO();
	}
	
	// [LegacyUnforgeable] undefined replace(USVString url);
	virtual bool replace(USVString& url) { // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-replace
		DKDEBUGFUNC(url);
		return DKTODO();
	}
	
	// [LegacyUnforgeable] undefined reload();
	virtual bool reload() { // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-reload
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
	virtual bool ancestorOrigins(DKString&, bool) { return false; } // https://html.spec.whatwg.org/multipage/nav-history-apis.html#dom-location-ancestororigins


	////// DK properties //////
	DKString interfaceName = "";
	DKString interfaceAddress = "";
};


#endif //DKLocation_H