// [IDL] https://url.spec.whatwg.org/#url-class
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/URL
#pragma once
#ifndef DKURL_H
#define DKURL_H

#include "DKInterface/DKInterface.h"


// Source: URL Standard (https://url.spec.whatwg.org/)
// [Exposed=*,
// LegacyWindowAlias=webkitURL]
// interface URL {
class DKURL : public DKInterface
{
public:
	
	// constructor(USVString url, optional USVString base);
	DKURL(const USVString& url, const USVString& base = "") : DKInterface() {
		DKDEBUGFUNC();
		interfaceName = "URL";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKURL("+interfaceAddress+") \n");
	}
	
	virtual ~DKURL() {}
	
	// static boolean canParse(USVString url, optional USVString base);
	bool _canParse = false;
	virtual const bool& canParse(const USVString& url, const USVString& base = "") {
		DKDEBUGFUNC(url, base);
		DKTODO();
		return _canParse;
	}
	
	// stringifier attribute USVString href;
	USVString _href = "";
	virtual const USVString& 	href()									{ return _href; }					// getter
	virtual void 				href(const USVString& href) 			{ _href = href; } 					// setter
	
	// readonly attribute USVString origin;
	USVString _origin = "";
	virtual const USVString& 	origin()								{ return _origin; }					// getter
	virtual void 				origin(const USVString& origin) 		{ _origin = origin; } 				// setter
	
	// attribute USVString protocol;
	USVString _protocol = "";
	virtual const USVString& 	protocol()								{ return _protocol; }				// getter
	virtual void 				protocol(const USVString& protocol) 	{ _protocol = protocol; } 			// setter
	
	// attribute USVString username;
	USVString _username = "";
	virtual const USVString& 	username()								{ return _username; }				// getter
	virtual void 				username(const USVString& protocol) 	{ _username = username; } 			// setter
	
	// attribute USVString password;
	USVString _password = "";
	virtual const USVString& 	password()								{ return _password; }				// getter
	virtual void 				password(const USVString& protocol) 	{ _password = password; } 			// setter
	
	// attribute USVString host;
	USVString _host = "";
	virtual const USVString& 	host()									{ return _host; }					// getter
	virtual void 				host(const USVString& protocol) 		{ _host = host; } 					// setter
	
	// attribute USVString hostname;
	USVString _hostname = "";
	virtual const USVString& 	hostname()								{ return _hostname; }				// getter
	virtual void 				hostname(const USVString& protocol) 	{ _hostname = hostname; } 			// setter
	
	// attribute USVString port;
	USVString _port = "";
	virtual const USVString& 	port()									{ return _port; }					// getter
	virtual void 				port(const USVString& protocol) 		{ _port = port; } 					// setter
	
	// attribute USVString pathname;
	USVString _pathname = "";
	virtual const USVString& 	pathname()								{ return _pathname; }				// getter
	virtual void 				pathname(const USVString& protocol) 	{ _pathname = pathname; } 			// setter
	
	// attribute USVString search;
	USVString _search = "";
	virtual const USVString& 	search()								{ return _search; }					// getter
	virtual void 				search(const USVString& protocol) 		{ _search = search; } 				// setter
	
	// [SameObject] readonly attribute URLSearchParams searchParams;
	DKString _searchParams = "";
	virtual const DKString& 	searchParams()							{ return _searchParams; }			// getter
	virtual void 				searchParams(const DKString& protocol)	{ _searchParams = searchParams; } 	// setter
	
	// attribute USVString hash;
	USVString _hash = "";
	virtual const USVString& 	hash()									{ return _hash; }					// getter
	virtual void 				hash(const USVString& protocol) 		{ _hash = hash; } 					// setter

	// USVString toJSON();
	USVString _toJSON = "";
	virtual const USVString& toJSON() {
		DKDEBUGFUNC();
		DKTODO();
		return _toJSON;
	}
// };	

	// Source: File API (https://www.w3.org/TR/FileAPI/)
	// [Exposed=(Window,DedicatedWorker,SharedWorker)]
	// partial interface URL {
	// static DOMString createObjectURL((Blob or MediaSource) obj);
	DOMString _createObjectURL = "";
	virtual const DOMString& createObjectURL() {
		DKDEBUGFUNC();
		DKTODO();
		return _createObjectURL;
	}
	
	// static undefined revokeObjectURL(DOMString url);
	virtual void revokeObjectURL(const DOMString& url) {
		DKDEBUGFUNC(url);
		DKTODO();
	}
//};
};


#endif //DKURL_H