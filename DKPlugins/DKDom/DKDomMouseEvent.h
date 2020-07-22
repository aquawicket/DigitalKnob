// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

#pragma once
#ifndef DKDomMouseEvent_H
#define DKDomMouseEvent_H

#include "DKDuktape/DKDuktape.h"


/////////////////////////////////////////////////////////
class DKDomMouseEvent : public DKObjectT<DKDomMouseEvent>
{
public:
	bool Init();
	
	// Properties
	static int altKey(duk_context* ctx); //Read only
	static int button(duk_context* ctx); //Read only

	// Methods
	static int getModifierState(duk_context* ctx);
};


REGISTER_OBJECT(DKDomMouseEvent, true)

#endif //DKDomMouseEvent_H