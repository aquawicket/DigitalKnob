// [IDL] https://dom.spec.whatwg.org/#interface-eventtarget
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
#pragma once
#ifndef TEST_DKRmlEventTarget_H
#define TEST_DKRmlEventTarget_H

#include "DKRmlEventTarget/DKRmlEventTarget.h"


class TEST_DKRmlEventTarget //: public DKObjectT<TEST_DKRmlEventTarget>
{
public:
	DKRmlEventTarget* dkRmlEventTarget;
	//std::unique_ptr<DKRmlEventTarget> dkRmlEventTarget;

	TEST_DKRmlEventTarget() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlEventTarget.h //////");
		
		dkRmlEventTarget = new DKRmlEventTarget(TEST_DKRmlInterface::dkRmlInterface, NULL);
		
		printDKRmlEventTargetProperties(*dkRmlEventTarget);
	}
	
	~TEST_DKRmlEventTarget() {
		delete dkRmlEventTarget;
	}
	
	static void printDKRmlEventTargetProperties(DKRmlEventTarget& rmlEventTarget){
		DKDEBUGFUNC(rmlEventTarget);
		
		console.log("rmlEventTarget = "				+toString(rmlEventTarget));
		
		TEST_EventTarget::printEventTargetProperties(rmlEventTarget);
	}

};
//REGISTER_OBJECT(TEST_EventTarget, true);


#endif //TEST_EventTarget_H