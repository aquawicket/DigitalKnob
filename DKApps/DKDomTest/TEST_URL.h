#pragma once
#ifndef TEST_URL_H
#define TEST_URL_H

#include "DKURL/DKURL.h"


class TEST_URL //: public DKObjectT<TEST_URL>
{
public:
	DKURL* dkUrl;
	//std::unique_ptr<DKURL> dkUrl;
	
	TEST_URL() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_URL.h //////");
		
		dkUrl = new DKURL();
		
		printURLProperties(*dkUrl);
	}
	
	~TEST_URL() {
		delete dkUrl;
	}
	
	static void printURLProperties(DKURL& dkUrl){
		DKDEBUGFUNC(dkUrl);
		
		// TODO
	}
};
//REGISTER_OBJECT(TEST_URL, true);


#endif //TEST_URL_H