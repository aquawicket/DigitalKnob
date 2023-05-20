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
		DKINFO("\n////// TEST_Location.h //////\n");
		
		DKLocation location;
		printLocationProperties(location);
		return true;
	}
	
	static void printLocationProperties(DKLocation& location){
		DKDEBUGFUNC(location);
		
		// [LegacyUnforgeable] stringifier attribute USVString href;
		DKINFO("location.href() = "				+toString(location.href())				+"\n");
		
		// [LegacyUnforgeable] readonly attribute USVString origin;
		DKINFO("location.origin() = "			+toString(location.origin())			+"\n");
		
		// [LegacyUnforgeable] attribute USVString protocol;
		DKINFO("location.protocol() = "			+toString(location.protocol())			+"\n");
		
		// [LegacyUnforgeable] attribute USVString host;
		DKINFO("location.host() = "				+toString(location.host())				+"\n");
		
		// [LegacyUnforgeable] attribute USVString hostname;
		DKINFO("location.hostname() = "			+toString(location.hostname())			+"\n");
		
		// [LegacyUnforgeable] attribute USVString port;
		DKINFO("location.port() = "				+toString(location.port())				+"\n");
		
		// [LegacyUnforgeable] attribute USVString pathname;
		DKINFO("location.pathname() = "			+toString(location.pathname())			+"\n");
		
		// [LegacyUnforgeable] attribute USVString search;
		DKINFO("location.search() = "			+toString(location.search())			+"\n");
		
		// [LegacyUnforgeable] attribute USVString hash;
		DKINFO("location.hash() = "				+toString(location.hash())				+"\n");
		
		// [LegacyUnforgeable] undefined assign(USVString url);
		// function
		
		// [LegacyUnforgeable] undefined replace(USVString url);
		// function
		
		// [LegacyUnforgeable] undefined reload();
		// function
		
		// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
		DKINFO("location.ancestorOrigins() = "	+toString(location.ancestorOrigins())	+"\n");
	}
};
REGISTER_OBJECT(TEST_Location, true);


#endif //TEST_Location_H