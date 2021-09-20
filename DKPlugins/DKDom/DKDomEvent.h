// https://developer.mozilla.org/en-US/docs/Web/API/Event

#pragma once
#ifndef DKDomEvent_H
#define DKDomEvent_H

#include "DKDuktape/DKDuktape.h"
#include "RmlUi/Core/Event.h"

class DKDomEvent : public DKObjectT<DKDomEvent>
{
public:
	bool Init();
	// Properties
	static int bubbles(duk_context* ctx); //Read Only
	static int cancelBubble(duk_context* ctx);
	static int cancelable(duk_context* ctx); //Read Only
	static int composed(duk_context* ctx); //Read Only
	static int currentTarget(duk_context* ctx); //Read Only
	static int deepPath(duk_context* ctx); //Not standarized
	static int defaultPrevented(duk_context* ctx); //Read Only
	static int eventPhase(duk_context* ctx); //Read Only
	static int explicitOriginalTarget(duk_context* ctx); //Read Only, Not standardized
	static int originalTarget(duk_context* ctx); //Read Only, Not standardized
	static int returnValue(duk_context* ctx);
	static int srcElement(duk_context* ctx); //Not standarized
	static int target(duk_context* ctx); //Read Only
	static int timeStamp(duk_context* ctx); //Read Only
	static int type(duk_context* ctx); //Read Only
	static int isTrusted(duk_context* ctx); //Read Only

	// Obsolete properties
	static int scoped(duk_context* ctx); //Read Only, Obsolete

	// Methods
	static int createEvent(duk_context* ctx); //Deprecated
	static int composedPath(duk_context* ctx);
	static int initEvent(duk_context* ctx); //Deprecated
	static int preventDefault(duk_context* ctx);
	static int stopImmediatePropagation(duk_context* ctx);
	static int stopPropagation(duk_context* ctx);

	// Obsolete methods
	static int getPreventDefault(duk_context* ctx); //Not standardized
	static int preventBubble(duk_context* ctx); //Not standardized, Obsolete
	static int preventCapture(duk_context* ctx); //Not standardized, Obsolete

	// Extra
	static int getParameters(duk_context* ctx);
}

REGISTER_OBJECT(DKDomEvent, true)

#endif //DKDomEvent_H