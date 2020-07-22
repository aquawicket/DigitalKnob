//https://developer.mozilla.org/en-US/docs/Web/API/EventTarget

#pragma once
#ifndef DKDomEventTarget_H
#define DKDomEventTarget_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////////////
class DKDomEventTarget : public DKObjectT<DKDomEventTarget>
{
public:
	bool Init();
	static bool OnEvent(DKEvents* event);

	static int addEventListener(duk_context* ctx);
	static int removeEventListener(duk_context* ctx);

	// non-standard
	static int id(duk_context* ctx);
	static int idLike(duk_context* ctx);
	static int type(duk_context* ctx);
	static int value(duk_context* ctx);
};


REGISTER_OBJECT(DKDomEventTarget, true)

#endif //DKDomEventTarget_H