// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

#ifdef USE_DKDuktape 
#pragma once
#ifndef DKMouseEvent_H
#define DKMouseEvent_H

#include "DKDuktape/DKDuktape.h"
#include "RmlUi/Core/Event.h"

///////////////////////////////////////////////////
class DKMouseEvent : public DKObjectT<DKMouseEvent>
{
public:
	bool Init();
	
	// Properties
	static int altKey(duk_context* ctx); //Read only
	static int button(duk_context* ctx); //Read only

	// Methods
	static int getModifierState(duk_context* ctx);
};


REGISTER_OBJECT(DKMouseEvent, true)

#endif //DKMouseEvent_H
#endif //USE_DKDuktape