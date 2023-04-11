/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// https://unixpapa.com/js/key.html
// https://w3c.github.io/uievents/#interface-keyboardevent

#include "DK/DKApp.h"
#include "DKDuktapeDom/DKEvent.h"
#include "DKDuktapeDom/DKEventTarget.h"
#include "DKDuktapeDom/DKKeyboardEvent.h"
#include "DKDuktapeDom/DKKeyCodes.h"
#include "DKDuktapeDom/ConsoleWindow.h"


void mapKeys();

bool DKKeyboardEvent::Init(){
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_altKey", DKKeyboardEvent::altKey);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_code", DKKeyboardEvent::code);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_ctrlKey", DKKeyboardEvent::ctrlKey);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_isComposing", DKKeyboardEvent::isComposing);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_key", DKKeyboardEvent::key);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_locale", DKKeyboardEvent::locale);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_location", DKKeyboardEvent::location);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_metaKey", DKKeyboardEvent::metaKey);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_repeat", DKKeyboardEvent::repeat);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_shiftKey", DKKeyboardEvent::shiftKey);

	// Methods
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_getModifierState", DKKeyboardEvent::getModifierState);

	// Obsolete methods
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_initKeyEvent", DKKeyboardEvent::initKeyEvent);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_initKeyboardEvent", DKKeyboardEvent::initKeyboardEvent);

	//Obsolete properties
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_char", DKKeyboardEvent::char1);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_charCode", DKKeyboardEvent::charCode);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_keyCode", DKKeyboardEvent::keyCode);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_keyIdentifier", DKKeyboardEvent::keyIdentifier);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_keyLocation", DKKeyboardEvent::keyLocation);
	DKDuktape::AttachFunction("CPP_DKKeyboardEvent_which", DKKeyboardEvent::which);

	DKClass::DKCreate("DKDuktapeDom/DKKeyboardEvent.js");

	DKKeyCodes::mapKeys();
	return true;
}


////////////////////////
// Properties
////////////////////////

int DKKeyboardEvent::altKey(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	bool altKey = event->altKey;
	duk_push_boolean(ctx, altKey);
	return true;
}

int DKKeyboardEvent::code(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString code = event->code;
	duk_push_string(ctx, code.c_str());
	return true;
}

int DKKeyboardEvent::ctrlKey(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	bool ctrlKey = event->ctrlKey;
	duk_push_boolean(ctx, ctrlKey);
	return true;
}

int DKKeyboardEvent::isComposing(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	bool isComposing = event->isComposing;
	duk_push_boolean(ctx, isComposing);
	return true;
}

int DKKeyboardEvent::key(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString key = toString(event->key);
	duk_push_string(ctx, key.c_str());
	return true;
}

int DKKeyboardEvent::locale(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString locale = event->locale;
	duk_push_string(ctx, locale.c_str());
	return true;
}

int DKKeyboardEvent::location(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int location = event->location;
	duk_push_int(ctx, location);
	return true;
}

int DKKeyboardEvent::metaKey(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	bool metaKey = event->metaKey;
	duk_push_boolean(ctx, metaKey);
	return true;
}

int DKKeyboardEvent::repeat(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	bool repeat = event->repeat;
	duk_push_boolean(ctx, repeat);
	return true;
}

int DKKeyboardEvent::shiftKey(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	bool shiftKey = event->shiftKey;
	duk_push_boolean(ctx, shiftKey);
	return true;
}


// Methods
///////////////////////////////////////////////////////

int DKKeyboardEvent::getModifierState(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}


// Obsolete Methods
///////////////////////////////////////////////////

int DKKeyboardEvent::initKeyEvent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}

int DKKeyboardEvent::initKeyboardEvent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}


// Obsolete properties
////////////////////////////////////////////

int DKKeyboardEvent::char1(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}

int DKKeyboardEvent::charCode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}

int DKKeyboardEvent::keyCode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	// TODO
	return true;
}

// Deprecated
int DKKeyboardEvent::keyIdentifier(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}

int DKKeyboardEvent::keyLocation(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}

int DKKeyboardEvent::which(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleWindow* event = (ConsoleWindow*)addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}
