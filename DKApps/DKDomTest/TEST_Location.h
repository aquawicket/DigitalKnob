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
		DKTODO();
	}
};
REGISTER_OBJECT(TEST_Location, true);


#endif //TEST_Location_H