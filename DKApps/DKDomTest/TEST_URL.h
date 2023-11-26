#pragma once
#ifndef TEST_URL_H
#define TEST_URL_H

#include "DKURL/DKURL.h"


class TEST_URL //: public DKObjectT<TEST_URL>
{
public:
	DKURL* _dkUrl;
	
	TEST_URL() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_URL.h //////");
		
		_dkUrl = new DKURL("http://www.google.com");
		
		printURLProperties(*_dkUrl);
	}
	
	~TEST_URL() {
		delete _dkUrl;
	}
	
	static void printURLProperties(DKURL& url){
		DKDEBUGFUNC(url);
		
		console.log("url = "				+toString(url));
		
		// constructor(USVString url, optional USVString base);
		// function
		
		// static boolean canParse(USVString url, optional USVString base);
		// function
		
		// stringifier attribute USVString href;
		console.log("url.href() = "			+toString(url.href()));
		
		// readonly attribute USVString origin;
		console.log("url.origin() = "		+toString(url.origin()));
		
		// attribute USVString protocol;
		console.log("url.protocol() = "		+toString(url.protocol()));
		
		// attribute USVString username;
		console.log("url.username() = "		+toString(url.username()));
		
		// attribute USVString password;
		console.log("url.password() = "		+toString(url.password()));
		
		// attribute USVString host;
		console.log("url.host() = "			+toString(url.host()));
		
		// attribute USVString hostname;
		console.log("url.hostname() = "		+toString(url.hostname()));
		
		// attribute USVString port;
		console.log("url.port() = "			+toString(url.port()));
		
		// attribute USVString pathname;
		console.log("url.pathname() = "		+toString(url.pathname()));
		
		// attribute USVString search;
		console.log("url.search() = "		+toString(url.search()));
		
		// [SameObject] readonly attribute URLSearchParams searchParams;
		console.log("url.searchParams() = "	+toString(url.searchParams()));
		
		// attribute USVString hash;
		console.log("url.hash() = "			+toString(url.hash()));
		
		// USVString toJSON();
		// function
		
		// };	

		// Source: File API (https://www.w3.org/TR/FileAPI/)
		// [Exposed=(Window,DedicatedWorker,SharedWorker)]
		// partial interface URL {
		// static DOMString createObjectURL((Blob or MediaSource) obj);
		// function
		
		// static undefined revokeObjectURL(DOMString url);
		// function
		
		//};
	}
};
//REGISTER_OBJECT(TEST_URL, true);


#endif //TEST_URL_H