// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// https://w3c.github.io/uievents/#interface-keyboardevent

#pragma once
#ifndef DKDomKeyboardEvent_H
#define DKDomKeyboardEvent_H

#include "DKDuktape/DKDuktape.h"
#include "DKDuktape/DKKeyCodes.h"


class DKDomKeyboardEvent : public DKObjectT<DKDomKeyboardEvent>
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
	static void MapRmlKeys();
	static std::map<int, Key> rmlKey;
};


REGISTER_OBJECT(DKDomKeyboardEvent, true)

#endif //DKDomKeyboardEvent_H