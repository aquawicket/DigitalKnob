// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

#pragma once
#ifndef DKDomUIEvent_H
#define DKDomUIEvent_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////
class DKDomUIEvent : public DKObjectT<DKDomUIEvent>
{
public:
	bool Init();
	
	// Properties
	//static int cancelBubble(duk_context* ctx); //Not standardized, Deprecated

	// Methods
	static int initUIEvent(duk_context* ctx); //Deprecated
};


REGISTER_OBJECT(DKDomUIEvent, true)

#endif //DKDomUIEvent_H