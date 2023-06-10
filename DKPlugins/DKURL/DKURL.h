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
	// TODO
	
	// stringifier attribute USVString href;
	// TODO
	
	// readonly attribute USVString origin;
	// TODO
	
	// attribute USVString protocol;
	// TODO
	
	// attribute USVString username;
	// TODO
	
	// attribute USVString password;
	// TODO
	
	// attribute USVString host;
	// TODO
	
	// attribute USVString hostname;
	// TODO
	
	// attribute USVString port;
	// TODO
	
	// attribute USVString pathname;
	// TODO
	
	// attribute USVString search;
	// TODO
	
	// [SameObject] readonly attribute URLSearchParams searchParams;
	// TODO
	
	// attribute USVString hash;
	// TODO

	// USVString toJSON();
	// TODO
// };	

	// Source: File API (https://www.w3.org/TR/FileAPI/)
	// [Exposed=(Window,DedicatedWorker,SharedWorker)]
	// partial interface URL {
	// static DOMString createObjectURL((Blob or MediaSource) obj);
	// TODO
	
	// static undefined revokeObjectURL(DOMString url);
	// TODO
//};
};


#endif //DKURL_H