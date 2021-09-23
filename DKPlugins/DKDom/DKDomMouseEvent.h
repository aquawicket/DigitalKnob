// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

#pragma once
#ifndef DKDomMouseEvent_H
#define DKDomMouseEvent_H

#include "DKDuktape/DKDuktape.h"


class DKDomMouseEvent : public DKObjectT<DKDomMouseEvent>
{
public:
	bool Init();
	
	// Properties
	static int altKey(duk_context* ctx); //Read only
	static int button(duk_context* ctx); //Read only
	static int buttons(duk_context* ctx); //Read only
	static int clientX(duk_context* ctx); //Read only
	static int clientY(duk_context* ctx); //Read only
	static int ctrlKey(duk_context* ctx); //Read only
	static int metaKey(duk_context* ctx); //Read only
	static int movementX(duk_context* ctx); //Read only
	static int movementY(duk_context* ctx); //Read only
	static int offsetX(duk_context* ctx); //Read only
	static int offsetY(duk_context* ctx); //Read only
	static int pageX(duk_context* ctx); //Read only
	static int pageY(duk_context* ctx); //Read only
	static int region(duk_context* ctx); //Read only
	static int relatedTarget(duk_context* ctx); //Read only
	static int screenX(duk_context* ctx); //Read only
	static int screenY(duk_context* ctx); //Read only
	static int shiftKey(duk_context* ctx); //Read only
	static int which(duk_context* ctx); //Read only
	static int mozPressure(duk_context* ctx); //Read only
	static int mozInputSource(duk_context* ctx); //Read only
	static int webkitForce(duk_context* ctx); //Read only
	static int x(duk_context* ctx); //Read only
	static int y(duk_context* ctx); //Read only

	// Methods
	static int getModifierState(duk_context* ctx);
	static int initMouseEvent(duk_context* ctx);
};


REGISTER_OBJECT(DKDomMouseEvent, true)

#endif //DKDomMouseEvent_H