#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DK/DK.h"


// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
class DKEventTarget : public DKObjectT<DKEventTarget>
{
public:
	bool Init();
	bool End();

	////// Instance methods //////
	void addEventListener(/* type, listener */);		// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
	void removeEventListener(/* type, listener */);		// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener
	void dispatchEvent(/* event */);					// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent
};
REGISTER_OBJECT(DKEventTarget, false);


#endif //DKEventTarget_H