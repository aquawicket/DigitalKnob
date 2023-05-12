#pragma once
#ifndef TEST_DKRmlLocation_H
#define TEST_DKRmlLocation_H

#include "DKRmlLocation/DKRmlLocation.h"


class TEST_DKRmlLocation : public DKObjectT<TEST_DKRmlLocation>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_DKRmlLocation.h //////\n");
		
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_DKRmlLocation, true);


#endif //TEST_DKRmlLocation_H