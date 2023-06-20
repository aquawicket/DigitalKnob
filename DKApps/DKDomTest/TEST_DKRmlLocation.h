#pragma once
#ifndef TEST_DKRmlLocation_H
#define TEST_DKRmlLocation_H

#include "DKRmlLocation/DKRmlLocation.h"


class TEST_DKRmlLocation //: public DKObjectT<TEST_DKRmlLocation>
{
public:
	static DKRmlLocation* dkRmlLocation;
	//std::unique_ptr<DKRmlLocation> dkRmlLocation;
	
	TEST_DKRmlLocation() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlLocation.h //////");
		
		dkRmlLocation = new DKRmlLocation(TEST_DKRmlInterface::dkRmlInterface);
		dkRmlLocation->href("DKWebTest/index.html");
		
		printDKRmlLocationProperties(*dkRmlLocation);
	}
	
	~TEST_DKRmlLocation() {
		delete dkRmlLocation;
	}
	
	static void printDKRmlLocationProperties(DKRmlLocation& dkRmlLocation){
		DKDEBUGFUNC(dkRmlLocation);
		
		console.log("dkRmlLocation = "				+toString(dkRmlLocation));
		
		TEST_Location::printLocationProperties(dkRmlLocation);
	}
};
//REGISTER_OBJECT(TEST_DKRmlLocation, true);

DKRmlLocation* TEST_DKRmlLocation::dkRmlLocation;

#endif //TEST_DKRmlLocation_H