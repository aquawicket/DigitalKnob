#pragma once
#ifndef TEST_Navigator_H
#define TEST_Navigator_H

#include "DK/DK.h"
#include "DKNavigator/DKNavigator.h"


class TEST_Navigator : public DKObjectT<TEST_Navigator>
{
public:
	bool Init(){
		DKINFO("////// TEST_Navigator.h ////// \n");
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_Navigator, true);


#endif //TEST_Navigator_H