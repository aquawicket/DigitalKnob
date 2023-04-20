#pragma once
#ifndef TEST_Location_H
#define TEST_Location_H

#include "DK/DK.h"
#include "DKLocation/DKLocation.h"


class TEST_Location : public DKObjectT<TEST_Location>
{
public:
	bool Init(){
		DKINFO("////// TEST_Location.h ////// \n");
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_Location, true);


#endif //TEST_Location_H