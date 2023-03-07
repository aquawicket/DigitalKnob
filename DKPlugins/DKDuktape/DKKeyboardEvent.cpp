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
#include "DKDuktape/DKEvent.h"
#include "DKDuktape/DKEventTarget.h"
#include "DKDuktape/DKKeyboardEvent.h"
#include "DKDuktape/DKKeyCodes.h"


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

	DKClass::DKCreate("DKDuktape/DKKeyboardEvent.js");

	DKKeyCodes::mapKeys();
	return true;
}


////////////////////////
// Properties
////////////////////////

int DKKeyboardEvent::altKey(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}

int DKKeyboardEvent::code(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Key key_identifier = (Key)std::stoi(event->data[0]);
	DKString code = DKKeyCodes::keys[key_identifier].code;
	duk_push_string(ctx, code.c_str());
	return true;
}

int DKKeyboardEvent::ctrlKey(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool ctrlKey = keys[(Key)std::stoi(event->data[0])].ctrlKey;
	//duk_push_boolean(ctx, ctrlKey);
	return true;
}

int DKKeyboardEvent::isComposing(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool isComposing = keys[(Key)std::stoi(event->data[0])].isComposing;
	//duk_push_boolean(ctx, isComposing);
	return false;
}

int DKKeyboardEvent::key(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Key key_identifier = (Key)std::stoi(event->data[0]);
	DKString key = DKKeyCodes::keys[key_identifier].key;
	duk_push_string(ctx, key.c_str());
	return true;
}

int DKKeyboardEvent::locale(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//DKString locale = keys[(Key)std::stoi(event->data[0])].locale;
	//duk_push_string(ctx, locale.c_str());
	return false;
}

int DKKeyboardEvent::location(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Key key_identifier = (Key)std::stoi(event->data[0]);
	int location = DKKeyCodes::keys[key_identifier].location;
	duk_push_int(ctx, location);
	return false;
}

int DKKeyboardEvent::metaKey(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool metaKey = keys[(Key)std::stoi(event->data[0])].metaKey;
	//duk_push_boolean(ctx, metaKey);
	return true;
}

int DKKeyboardEvent::repeat(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool repeat = keys[(Key)std::stoi(event->data[0])].repeat;
	//duk_push_boolean(ctx, repeat);
	return false;
}

int DKKeyboardEvent::shiftKey(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool shiftKey = keys[(Key)std::stoi(event->data[0])].shiftKey;
	//duk_push_boolean(ctx, shiftKey);
	return true;
}


// Methods
///////////////////////////////////////////////////////

int DKKeyboardEvent::getModifierState(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}


// Obsolete Methods
///////////////////////////////////////////////////

int DKKeyboardEvent::initKeyEvent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKKeyboardEvent::initKeyboardEvent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}


// Obsolete properties
////////////////////////////////////////////

int DKKeyboardEvent::char1(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKKeyboardEvent::charCode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKKeyboardEvent::keyCode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Key key_identifier = (Key)std::stoi(event->data[0]);
	duk_push_int(ctx, key_identifier);
	return false;
}

// Deprecated
int DKKeyboardEvent::keyIdentifier(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Key key_identifier = (Key)std::stoi(event->data[0]);
	DKString key = DKKeyCodes::keys[key_identifier].key;
	duk_push_string(ctx, key.c_str());
	return true;
}

int DKKeyboardEvent::keyLocation(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKKeyboardEvent::which(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}
