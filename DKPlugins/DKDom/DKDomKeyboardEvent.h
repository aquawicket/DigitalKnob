// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent

#pragma once
#ifndef DKDomKeyboardEvent_H
#define DKDomKeyboardEvent_H

#include "DKDuktape/DKDuktape.h"


///////////////////////////////////////////////////////////////
class DKDomKeyboardEvent : public DKObjectT<DKDomKeyboardEvent>
{
public:
	bool Init();
	
	// Properties
	static int altKey(duk_context* ctx);
	static int key(duk_context* ctx);

	// Methods
	static int getModifierState(duk_context* ctx);
};


REGISTER_OBJECT(DKDomKeyboardEvent, true)

#endif //DKDomKeyboardEvent_H