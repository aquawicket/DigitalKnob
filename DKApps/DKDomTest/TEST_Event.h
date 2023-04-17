#pragma once
#ifndef TEST_Event_H
#define TEST_Event_H

#include "DK/DK.h"
#include "DKEvent/DKEvent.h"


class TEST_Event : public DKObjectT<TEST_Event>
{
public:
	bool Init(){
		return DKTODO();
	}
	bool End(){
		return DKTODO();
	}

	// https://dom.spec.whatwg.org
	////// Event //////
	static void printEventProperties(DKEvent& event){
		return DKTODO();
	}
	static bool onevent(DKEvent& event){
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_Event, false);


#endif //TEST_Event_H