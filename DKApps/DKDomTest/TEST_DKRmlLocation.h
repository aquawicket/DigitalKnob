#pragma once
#ifndef TEST_DKRmlLocation_H
#define TEST_DKRmlLocation_H

#include "DKRmlLocation/DKRmlLocation.h"


class TEST_DKRmlLocation //: public DKObjectT<TEST_DKRmlLocation>
{
public:
	static DKRmlLocation* _dkRmlLocation;
	
	TEST_DKRmlLocation() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlLocation.h //////");
		
		_dkRmlLocation = new DKRmlLocation(TEST_DKRmlInterface::dkRmlInterface, TEST_DKRmlEventListener::_dkRmlEventListener);
		_dkRmlLocation->href("DKWebTest/index.html");
		
		printDKRmlLocationProperties(*_dkRmlLocation);
	}
	
	~TEST_DKRmlLocation() {
		delete _dkRmlLocation;
	}
	
	static void printDKRmlLocationProperties(DKRmlLocation& dkRmlLocation){
		DKDEBUGFUNC(dkRmlLocation);
		console.log("dkRmlLocation = "		+toString(dkRmlLocation));
		
		TEST_Location::printLocationProperties(dkRmlLocation);
	}
};
//REGISTER_OBJECT(TEST_DKRmlLocation, true);

DKRmlLocation* TEST_DKRmlLocation::_dkRmlLocation;

#endif //TEST_DKRmlLocation_H