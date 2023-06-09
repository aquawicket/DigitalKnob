// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Location.idl
// [SOURCE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
#pragma once
#ifndef DKRmlLocation_H
#define DKRmlLocation_H

#include "DKLocation/DKLocation.h"
#include "DKRmlInterface/DKRmlInterface.h"

// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window]
// interface Location { // but see also additional creation steps and overridden internal methods
class DKRmlLocation : public DKLocation //, public DKObjectT<DKRmlLocation>
{
public:
	DKRmlInterface* _dkRmlInterface;

	DKRmlLocation(DKRmlInterface* dkRmlInterface) : DKLocation() {
		DKDEBUGFUNC();
		interfaceName = "RmlLocation";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKRmlLocation("+interfaceAddress+") \n");
		_dkRmlInterface = dkRmlInterface;
	}
	virtual ~DKRmlLocation() {}

	// [LegacyUnforgeable] stringifier attribute USVString href;
	virtual const USVString& href()				{ return _dkRmlInterface->href_; }		// getter
	virtual void href(const USVString& url)		{ _dkRmlInterface->LoadUrl(url); } 		// setter
	
	// [LegacyUnforgeable] readonly attribute USVString origin;
	virtual bool origin(DKString&, bool) { return DKTODO(); }
	
	// [LegacyUnforgeable] attribute USVString protocol;
	virtual bool protocol(DKString&, bool) { return DKTODO(); }
	
	// [LegacyUnforgeable] attribute USVString host;
	virtual bool host(DKString&, bool) { return DKTODO(); }
	
	// [LegacyUnforgeable] attribute USVString hostname;
	virtual bool hostname(DKString&, bool) { return DKTODO(); }
	
	// [LegacyUnforgeable] attribute USVString port;
	virtual bool port(DKString&, bool) { return DKTODO(); }
	
	// [LegacyUnforgeable] attribute USVString pathname;
	virtual bool pathname(DKString&, bool) { return DKTODO(); }
	
	// [LegacyUnforgeable] attribute USVString search;
	virtual bool search(DKString&, bool) { return DKTODO(); }
	
	// [LegacyUnforgeable] attribute USVString hash;
	virtual bool hash(DKString&, bool) { return DKTODO(); }

	// [LegacyUnforgeable] undefined assign(USVString url);
	virtual bool assign(DKString& url) {
		DKDEBUGFUNC(url);
		return DKTODO();
	}
	
	// [LegacyUnforgeable] undefined replace(USVString url);
	virtual bool replace(DKString& url) {
		DKDEBUGFUNC(url);
		return DKTODO();
	}
	
	// [LegacyUnforgeable] undefined reload();
	virtual void reload() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
	virtual bool ancestorOrigins(DKString&, bool) { return DKTODO(); }
};
//REGISTER_OBJECT(DKRmlLocation, true);

#endif //DKLocation_H