// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

#ifdef USE_DKDuktape 
#pragma once
#ifndef DKUIEvent_H
#define DKUIEvent_H

#include "DKDuktape/DKDuktape.h"
#include "RmlUi/Core/Event.h"

/////////////////////////////////////////////
class DKUIEvent : public DKObjectT<DKUIEvent>
{
public:
	bool Init();
	
	// Properties
	static int cancelBubble(duk_context* ctx); //Not standardized, Deprecated

	// Methods
	static int initUIEvent(duk_context* ctx); //Deprecated
};


REGISTER_OBJECT(DKUIEvent, true)

#endif //DKUIEvent_H
#endif //USE_DKDuktape