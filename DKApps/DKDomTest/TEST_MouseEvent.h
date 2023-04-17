#pragma once
#ifndef TEST_MouseEvent_H
#define TEST_MouseEvent_H

#include "DK/DK.h"
#include "DKMouseEvent/DKMouseEvent.h"


class TEST_MouseEvent : public DKObjectT<TEST_MouseEvent>
{
public:
	bool Init(){
		DKINFO("////// TEST_MouseEvent.h ////// \n");
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}


};
REGISTER_OBJECT(TEST_MouseEvent, true);


#endif //TEST_MouseEvent_H