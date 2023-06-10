// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
#pragma once
#ifndef DKLocation_H
#define DKLocation_H

#include "DKInterface/DKInterface.h"

WARNING_DISABLE
#include "uriparser/Uri.h"
WARNING_ENABLE


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
	USVString _href = "";
	virtual const USVString& href()					{ return _href; }			// getter
	virtual void href(const USVString& href); 		{ 							// setter
		
		UriUriA uri;
		const char* const uriString = href.c_str();
		const char* errorPos;
 
		if (uriParseSingleUriA(&uri, uriString, &errorPos) != URI_SUCCESS) {
			// Failure (no need to call uriFreeUriMembersA)
			DKERROR("uriParseSingleUriA failed! \n");
			return;
		}
 
		DKINFO("uriParseSingleUriA parsed successfully \n");
		uriFreeUriMembersA(&uri);
	}
	
	// [LegacyUnforgeable] readonly attribute USVString origin;
	USVString _origin = "";
	virtual const USVString& origin()				{ return _origin;	}		// getter		
	virtual void origin(const USVString& origin)	{ _origin = origin; } 		// setter
	
	// [LegacyUnforgeable] attribute USVString protocol;
	USVString _protocol = "";
	virtual const USVString& protocol()				{ return _protocol; }		// getter
	virtual void protocol(const USVString& protocol){ _protocol = protocol; } 	// setter
	
	// [LegacyUnforgeable] attribute USVString host;
	USVString _host = "";
	virtual const USVString& host()					{ return _host; }			// getter
	virtual void host(const USVString& host)		{ _host = host; } 			// setter
	
	// [LegacyUnforgeable] attribute USVString hostname;
	USVString _hostname = "";
	virtual const USVString& hostname()				{ return _hostname; }		// getter
	virtual void hostname(const USVString& hostname){ _hostname = hostname; } 	// setter
	
	// [LegacyUnforgeable] attribute USVString port;
	USVString _port = "";
	virtual const USVString& port()					{ return _port; }			// getter
	virtual void port(const USVString& port)		{ _port = port; } 			// setter
	
	// [LegacyUnforgeable] attribute USVString pathname;
	USVString _pathname = "";
	virtual const USVString& pathname()				{ return _pathname; }		// getter
	virtual void pathname(const USVString& pathname){ _pathname = pathname; } 	// setter
	
	// [LegacyUnforgeable] attribute USVString search;
	USVString _search = "";
	virtual const USVString& search()				{ return _search; }			// getter
	virtual void search(const USVString& search)	{ _search = search; } 		// setter
	
	// [LegacyUnforgeable] attribute USVString hash;
	USVString _hash = "";
	virtual const USVString& hash()					{ return _hash; }			// getter
	virtual void hash(const USVString& hash)		{ _hash = hash; } 			// setter

	// [LegacyUnforgeable] undefined assign(USVString url);
	virtual void assign(const USVString& url) {
		DKDEBUGFUNC(url);
		DKTODO();
	}
	
	// [LegacyUnforgeable] undefined replace(USVString url);
	virtual void replace(const USVString& url) {
		DKDEBUGFUNC(url);
		DKTODO();
	}
	
	// [LegacyUnforgeable] undefined reload();
	virtual void reload() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
	DKString _ancestorOrigins = "";
	virtual const DKString& ancestorOrigins()						{ return _ancestorOrigins; }				// getter
	virtual void ancestorOrigins(const DKString& ancestorOrigins)	{ _ancestorOrigins = ancestorOrigins; } 	// setter
};


#endif //DKLocation_H