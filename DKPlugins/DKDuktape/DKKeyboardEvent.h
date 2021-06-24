// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// https://w3c.github.io/uievents/#interface-keyboardevent

#pragma once
#ifndef DKKeyboardEvent_H
#define DKKeyboardEvent_H

#include "DKDuktape/DKDuktape.h"


///////////////////////////////////////////////////////////////
class DKKeyboardEvent : public DKObjectT<DKKeyboardEvent>
{
public:
	bool Init();
	
	// Properties
	static int altKey(duk_context* ctx);
	static int code(duk_context* ctx);
	static int ctrlKey(duk_context* ctx);
	static int isComposing(duk_context* ctx);
	static int key(duk_context* ctx);
	static int locale(duk_context* ctx);
	static int location(duk_context* ctx);
	static int metaKey(duk_context* ctx);
	static int repeat(duk_context* ctx);
	static int shiftKey(duk_context* ctx);

	// Methods
	static int getModifierState(duk_context* ctx);

	// Obsolete methods
	static int initKeyEvent(duk_context* ctx);
	static int initKeyboardEvent(duk_context* ctx);

	//Obsolete properties
	static int char1(duk_context* ctx);
	static int charCode(duk_context* ctx);
	static int keyCode(duk_context* ctx);
	static int keyIdentifier(duk_context* ctx);
	static int keyLocation(duk_context* ctx);
	static int which(duk_context* ctx);

	//Extra
	static bool TranslateKey(int key, DKString& value);

	DKString _key;
	int _keyCode;
};


REGISTER_OBJECT(DKKeyboardEvent, true)

#endif //DKKeyboardEvent_H