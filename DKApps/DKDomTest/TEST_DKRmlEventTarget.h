// [IDL] https://dom.spec.whatwg.org/#interface-eventtarget
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
#pragma once
#ifndef TEST_DKRmlEventTarget_H
#define TEST_DKRmlEventTarget_H

#include "DKRmlEventTarget/DKRmlEventTarget.h"


class TEST_DKRmlEventTarget //: public DKObjectT<TEST_DKRmlEventTarget>
{
public:
	TEST_DKRmlEventTarget() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlEventTarget.h //////");
		
		DKRmlEventTarget rmlEventTarget;
		printDKRmlEventTargetProperties(rmlEventTarget);
	}
	
	static void printDKRmlEventTargetProperties(DKRmlEventTarget& rmlEventTarget){
		DKDEBUGFUNC(rmlEventTarget);
		
		TEST_EventTarget::printEventTargetProperties(dynamic_cast<DKEventTarget&>(rmlEventTarget));	//TODO: try to remove the need for dynamic_cast
	}

};
//REGISTER_OBJECT(TEST_EventTarget, true);


#endif //TEST_EventTarget_H