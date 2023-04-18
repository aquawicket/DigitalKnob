#pragma once
#ifndef TEST_EventTarget_H
#define TEST_EventTarget_H

#include "DK/DK.h"
#include "DKEventTarget/DKEventTarget.h"


// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
class TEST_EventTarget : public DKObjectT<TEST_EventTarget>
{
public:
	bool Init(){
		DKINFO("////// TEST_EventTarget.h ////// \n");
		
		////// Constructor //////
		// [EventTarget()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/EventTarget
	
			
		////// Instance methods //////
		// [EventTarget.addEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
		// [EventTarget.removeEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener
		// [EventTarget.dispatchEvent()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent
	
	
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}


};
REGISTER_OBJECT(TEST_EventTarget, true);


#endif //TEST_EventTarget_H