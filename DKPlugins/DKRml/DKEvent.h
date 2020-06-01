/*
//https://developer.mozilla.org/en-US/docs/Web/API/Event

#ifdef USE_DKDuktape 
#pragma once
#ifndef DKEvent_H
#define DKEvent_H

#include "DKDuktape/DKDuktape.h"

//////////////////////////////////////////
class DKEvent : public DKObjectT<DKEvent>
{
public:
	bool Init();
	
	//Properties
	static int bubbles(duk_context* ctx);

	//Methods
	static int createEvent(duk_context* ctx);
};


REGISTER_OBJECT(DKEvent, true)

#endif //DKEvent_H
#endif //USE_DKDuktape
*/