#pragma once
#ifndef TEST_DKRmlLocation_H
#define TEST_DKRmlLocation_H

#include "DKRmlLocation/DKRmlLocation.h"


class TEST_DKRmlLocation //: public DKObjectT<TEST_DKRmlLocation>
{
public:
	//DKRmlLocation dkRmlLocation;					// goes out of scope
	DKRmlLocation* dkRmlLocation;					// dangling pointer
	//std::unique_ptr<DKRmlLocation> dkRmlLocation;
	
	TEST_DKRmlLocation(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlLocation.h //////");
		
		dkRmlLocation = new DKRmlLocation(TEST_DKRmlDocument::dkRmlDocument);
		
		printDKRmlLocationProperties(*dkRmlLocation);
		
		dkRmlLocation->href("DKWebTest/index.html");
	}
	
	static void printDKRmlLocationProperties(DKRmlLocation& dkRmlLocation){
		DKDEBUGFUNC(dkRmlLocation);
		
		TEST_Location::printLocationProperties(dynamic_cast<DKLocation&>(dkRmlLocation));	//TODO: try to remove the need for dynamic_cast
	}
};
//REGISTER_OBJECT(TEST_DKRmlLocation, true);


#endif //TEST_DKRmlLocation_H