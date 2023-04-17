#pragma once
#ifndef TEST_DragEvent_H
#define TEST_DragEvent_H

#include "DK/DK.h"
//#include "DKDragEvent/DKDragEvent.h"	// TODO


class TEST_DragEvent : public DKObjectT<TEST_DragEvent>
{
public:
	bool Init(){
		DKINFO("////// TEST_DragEvent.h ////// \n");
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}


};
REGISTER_OBJECT(TEST_DragEvent, true);


#endif //TEST_DragEvent_H