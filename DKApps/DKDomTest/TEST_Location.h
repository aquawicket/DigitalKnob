// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
#pragma once
#ifndef TEST_Location_H
#define TEST_Location_H

#include "DKLocation/DKLocation.h"


class TEST_Location : public DKObjectT<TEST_Location>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_Location.h //////");
		
		DKLocation location;
		printLocationProperties(location);
		return true;
	}
	
	static void printLocationProperties(DKLocation& location){
		DKDEBUGFUNC(location);
		
		// [LegacyUnforgeable] stringifier attribute USVString href;
		console.log("location.href() = "				+toString(location.href()));
		
		// [LegacyUnforgeable] readonly attribute USVString origin;
		console.log("location.origin() = "			+toString(location.origin()));
		
		// [LegacyUnforgeable] attribute USVString protocol;
		console.log("location.protocol() = "			+toString(location.protocol()));
		
		// [LegacyUnforgeable] attribute USVString host;
		console.log("location.host() = "				+toString(location.host()));
		
		// [LegacyUnforgeable] attribute USVString hostname;
		console.log("location.hostname() = "			+toString(location.hostname()));
		
		// [LegacyUnforgeable] attribute USVString port;
		console.log("location.port() = "				+toString(location.port()));
		
		// [LegacyUnforgeable] attribute USVString pathname;
		console.log("location.pathname() = "			+toString(location.pathname()));
		
		// [LegacyUnforgeable] attribute USVString search;
		console.log("location.search() = "			+toString(location.search()));
		
		// [LegacyUnforgeable] attribute USVString hash;
		console.log("location.hash() = "				+toString(location.hash()));
		
		// [LegacyUnforgeable] undefined assign(USVString url);
		// function
		
		// [LegacyUnforgeable] undefined replace(USVString url);
		// function
		
		// [LegacyUnforgeable] undefined reload();
		// function
		
		// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
		console.log("location.ancestorOrigins() = "	+toString(location.ancestorOrigins()));
	}
};
REGISTER_OBJECT(TEST_Location, true);


#endif //TEST_Location_H