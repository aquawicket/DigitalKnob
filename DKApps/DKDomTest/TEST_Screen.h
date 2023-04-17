#pragma once
#ifndef TEST_Screen_H
#define TEST_Screen_H

#include "DK/DK.h"
#include "DKScreen/DKScreen.h"


class TEST_Screen : public DKObjectT<TEST_Screen>
{
public:
	bool Init(){
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_Screen, true);


#endif //TEST_Screen_H