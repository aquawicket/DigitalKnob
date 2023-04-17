#pragma once
#ifndef TEST_CustomEvent_H
#define TEST_CustomEvent_H

#include "DK/DK.h"
#include "DKCustomEvent/DKCustomEvent.h"


class TEST_CustomEvent : public DKObjectT<TEST_CustomEvent>
{
public:
	bool Init(){
		////// CustomEvent //////
		DKINFO("\n");
		DKEventTarget myTargetA;
		//myTargetA.addEventListener("customevent", &TEST_CustomEvent::oncustom);
		DKCustomEvent customevent("customevent", "");
		customevent.detail = "{name : 'mycustomevent'}";
		myTargetA.dispatchEvent(customevent);
		return true;
	}
	
	bool End(){
		return DKTODO();
	}

	////// CustomEvent //////
	void printCustomEventProperties(DKCustomEvent& customevent) {
		////// Instance properties //////
		DKINFO("customevent.detail = "	+toString(customevent.detail)	+"\n");
	}
	bool oncustom(DKEvent& event) {
		DKDEBUGFUNC(event);
		DKINFO("cpp->oncustom() \n");
		//printEventProperties(event);
		printCustomEventProperties(dynamic_cast<DKCustomEvent&>(event));	//FIXME: try to remove the need for dynamic_cast
		return true;
	}

};
REGISTER_OBJECT(TEST_CustomEvent, false);


#endif //TEST_CustomEvent_H