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
		DKConsole::log("\n////// TEST_Location.h //////");
		
		DKLocation location;
		printLocationProperties(location);
		return true;
	}
	
	static void printLocationProperties(DKLocation& location){
		DKDEBUGFUNC(location);
		
		// [LegacyUnforgeable] stringifier attribute USVString href;
		DKConsole::log("location.href() = "				+toString(location.href()));
		
		// [LegacyUnforgeable] readonly attribute USVString origin;
		DKConsole::log("location.origin() = "			+toString(location.origin()));
		
		// [LegacyUnforgeable] attribute USVString protocol;
		DKConsole::log("location.protocol() = "			+toString(location.protocol()));
		
		// [LegacyUnforgeable] attribute USVString host;
		DKConsole::log("location.host() = "				+toString(location.host()));
		
		// [LegacyUnforgeable] attribute USVString hostname;
		DKConsole::log("location.hostname() = "			+toString(location.hostname()));
		
		// [LegacyUnforgeable] attribute USVString port;
		DKConsole::log("location.port() = "				+toString(location.port()));
		
		// [LegacyUnforgeable] attribute USVString pathname;
		DKConsole::log("location.pathname() = "			+toString(location.pathname()));
		
		// [LegacyUnforgeable] attribute USVString search;
		DKConsole::log("location.search() = "			+toString(location.search()));
		
		// [LegacyUnforgeable] attribute USVString hash;
		DKConsole::log("location.hash() = "				+toString(location.hash()));
		
		// [LegacyUnforgeable] undefined assign(USVString url);
		// function
		
		// [LegacyUnforgeable] undefined replace(USVString url);
		// function
		
		// [LegacyUnforgeable] undefined reload();
		// function
		
		// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
		DKConsole::log("location.ancestorOrigins() = "	+toString(location.ancestorOrigins()));
	}
};
REGISTER_OBJECT(TEST_Location, true);


#endif //TEST_Location_H