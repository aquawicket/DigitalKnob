// [IDL] https://dom.spec.whatwg.org/#interface-eventtarget
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
#pragma once
#ifndef TEST_EventTarget_H
#define TEST_EventTarget_H

#include "DKEventTarget/DKEventTarget.h"


class TEST_EventTarget //: public DKObjectT<TEST_EventTarget>
{
public:
	TEST_EventTarget() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_EventTarget.h //////");
		
		DKEventTarget eventTarget;
		printEventTargetProperties(eventTarget);
	}
	
	static void printEventTargetProperties(DKEventTarget& evenTarget){
		DKDEBUGFUNC(evenTarget);
		
		console.log("evenTarget = "		+toString(evenTarget));
	}

};
//REGISTER_OBJECT(TEST_EventTarget, true);


#endif //TEST_EventTarget_H