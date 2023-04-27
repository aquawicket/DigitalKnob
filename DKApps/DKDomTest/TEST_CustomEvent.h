// [IDL] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
#pragma once
#ifndef TEST_CustomEvent_H
#define TEST_CustomEvent_H

#include "DK/DK.h"
#include "DKCustomEvent/DKCustomEvent.h"
#include "TEST_Event.h"


class TEST_CustomEvent : public DKObjectT<TEST_CustomEvent>
{
public:
	bool Init(){
		DKINFO("////// TEST_CustomEvent.h ////// \n");
		
		////// CustomEvent //////
		DKINFO("\n");
		DKEventTarget myTargetA;
		myTargetA.addEventListener("customevent", &TEST_CustomEvent::oncustomevent);
		DKCustomEvent customevent("customevent", "");
		customevent.detail = "{name : 'mycustomevent'}";
		myTargetA.dispatchEvent(customevent);
		return true;
	}

	////// CustomEvent //////
	static void printCustomEventProperties(DKCustomEvent& customevent) {
		////// Instance properties //////
		DKINFO("customevent.detail = "	+toString(customevent.detail)	+"\n");
	}
	static bool oncustomevent(DKEvent& event) {
		DKDEBUGFUNC(event);
		DKINFO("TEST_CustomEvent::oncustom() \n");
		TEST_Event::printEventProperties(event);
		printCustomEventProperties(dynamic_cast<DKCustomEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}

};
REGISTER_OBJECT(TEST_CustomEvent, true);


#endif //TEST_CustomEvent_H