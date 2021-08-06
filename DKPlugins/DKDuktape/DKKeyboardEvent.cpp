// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// https://unixpapa.com/js/key.html
// https://w3c.github.io/uievents/#interface-keyboardevent

#include "DK/DKApp.h"
#include "DKDuktape/DKEvent.h"
#include "DKDuktape/DKEventTarget.h"
#include "DKDuktape/DKKeyboardEvent.h"
#include "DKDuktape/DKKeyCodes.h"

void mapKeys();

bool DKKeyboardEvent::Init()
{
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
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::altKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//int altKey = "undefined"
	//duk_push_boolean(ctx, altKey);
	return true;
}

int DKKeyboardEvent::code(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::code(): event invalid\n");
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
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::ctrlKey(): event invalid\n");
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
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::isComposing(): event invalid\n");
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
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::code(): event invalid\n");
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
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::locale(): event invalid\n");
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
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::location(): event invalid\n");
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
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::metaKey(): event invalid\n");
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
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::repeat(): event invalid\n");
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
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::shiftKey(): event invalid\n");
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
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::getModifierState(): event invalid\n");
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
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::initKeyEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool ctrlKe;
	//duk_push_boolean(ctx, ctrlKey);
	return false;
}

int DKKeyboardEvent::initKeyboardEvent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::initKeyboardEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool ctrlKey = event->GetParameter<bool>("ctrl_key", 0);
	//duk_push_boolean(ctx, ctrlKey);
	return false;
}


// Obsolete properties
////////////////////////////////////////////

int DKKeyboardEvent::char1(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::char1(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	return false;
}

int DKKeyboardEvent::charCode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::charCode(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//int charCode = keys[(Key)std::stoi(event->data[0])].charCode;
	//duk_push_int(ctx, charCode);
	return false;
}

int DKKeyboardEvent::keyCode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::keyCode(): event invalid\n");
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
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::keyIdentifier(): event invalid\n");
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
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::char1(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	return false;
}

int DKKeyboardEvent::which(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::which(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	return false;
}
