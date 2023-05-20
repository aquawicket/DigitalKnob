// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
#pragma once
#ifndef DKLocation_H
#define DKLocation_H

#include "DKInterface/DKInterface.h"


// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window]
// interface Location { // but see also additional creation steps and overridden internal methods
class DKLocation : public DKInterface
{
public:
	DKLocation() : DKInterface() {
		DKDEBUGFUNC();
		interfaceName = "Location";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKLocation("+interfaceAddress+") \n");
	}
	virtual ~DKLocation() {}

	// [LegacyUnforgeable] stringifier attribute USVString href;
	virtual USVString href()						{ return ""; }	// getter
	virtual void href(const USVString&)				{ } 			// setter
	
	// [LegacyUnforgeable] readonly attribute USVString origin;
	virtual USVString origin()						{ return ""; }	// getter
	virtual void origin(const USVString&)			{ } 			// setter
	
	// [LegacyUnforgeable] attribute USVString protocol;
	virtual USVString protocol()					{ return ""; }	// getter
	virtual void protocol(const USVString&)			{ } 			// setter
	
	// [LegacyUnforgeable] attribute USVString host;
	virtual USVString host()						{ return ""; }	// getter
	virtual void host(const USVString&)			{ } 			// setter
	
	// [LegacyUnforgeable] attribute USVString hostname;
	virtual USVString hostname()					{ return ""; }	// getter
	virtual void hostname(const USVString&)			{ } 			// setter
	
	// [LegacyUnforgeable] attribute USVString port;
	virtual USVString port()						{ return ""; }	// getter
	virtual void port(const USVString&)				{ } 			// setter
	
	// [LegacyUnforgeable] attribute USVString pathname;
	virtual USVString pathname()					{ return ""; }	// getter
	virtual void pathname(const USVString&)			{ } 			// setter
	
	// [LegacyUnforgeable] attribute USVString search;
	virtual USVString search()						{ return ""; }	// getter
	virtual void search(const USVString&)			{ } 			// setter
	
	// [LegacyUnforgeable] attribute USVString hash;
	virtual USVString hash()						{ return ""; }	// getter
	virtual void hash(const USVString&)				{ } 			// setter

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
	virtual DKString ancestorOrigins()				{ return ""; }	// getter
	virtual void ancestorOrigins(const DKString&)	{ } 			// setter
};


#endif //DKLocation_H