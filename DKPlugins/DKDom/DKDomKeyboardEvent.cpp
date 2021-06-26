// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// https://unixpapa.com/js/key.html
// https://w3c.github.io/uievents/#interface-keyboardevent

#include "DK/DKApp.h"
#include "DKRml/DKRml.h"
#include "DKDom/DKDomEvent.h"
#include "DKDom/DKDomEventTarget.h"
#include "DKDom/DKDomKeyboardEvent.h"
#include "RmlUi/Core/Input.h"
#include "DKDuktape/DKKeyCodes.h"


bool DKDomKeyboardEvent::Init()
{
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_altKey", DKDomKeyboardEvent::altKey);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_code", DKDomKeyboardEvent::code);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_ctrlKey", DKDomKeyboardEvent::ctrlKey);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_isComposing", DKDomKeyboardEvent::isComposing);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_key", DKDomKeyboardEvent::key);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_locale", DKDomKeyboardEvent::locale);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_location", DKDomKeyboardEvent::location);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_metaKey", DKDomKeyboardEvent::metaKey);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_repeat", DKDomKeyboardEvent::repeat);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_shiftKey", DKDomKeyboardEvent::shiftKey);

	// Methods
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_getModifierState", DKDomKeyboardEvent::getModifierState);

	// Obsolete methods
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_initKeyEvent", DKDomKeyboardEvent::initKeyEvent);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_initKeyboardEvent", DKDomKeyboardEvent::initKeyboardEvent);

	//Obsolete properties
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_char", DKDomKeyboardEvent::char1);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_charCode", DKDomKeyboardEvent::charCode);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_keyCode", DKDomKeyboardEvent::keyCode);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_keyIdentifier", DKDomKeyboardEvent::keyIdentifier);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_keyLocation", DKDomKeyboardEvent::keyLocation);
	DKDuktape::AttachFunction("CPP_DKDomKeyboardEvent_which", DKDomKeyboardEvent::which);

	DKClass::DKCreate("DKDom/DKDomKeyboardEvent.js");

	mapKeys();
	return true;
}



////////////////////////
// Properties
////////////////////////

int DKDomKeyboardEvent::altKey(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::altKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	bool altKey = event->GetParameter<bool>("alt_key", 0);
	duk_push_boolean(ctx, altKey);
	return true;
}

int DKDomKeyboardEvent::code(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::code(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Input::KeyIdentifier key = (Rml::Input::KeyIdentifier)event->GetParameter<int>("key_identifier", 0);
	DKString code;
	//TranslateKey(key, code);
	duk_push_string(ctx, code.c_str());
	return true;
}

int DKDomKeyboardEvent::ctrlKey(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::ctrlKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	bool ctrlKey = event->GetParameter<bool>("ctrl_key", 0);
	duk_push_boolean(ctx, ctrlKey);
	return true;
}

int DKDomKeyboardEvent::isComposing(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::isComposing(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	bool isComposing = event->GetParameter<bool>("isComposing", 0);
	duk_push_boolean(ctx, isComposing);
	return false;
}

int DKDomKeyboardEvent::key(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::code(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int key = event->GetParameter<int>("key_identifier", 0);
	DKString code;
	//TranslateKey(key, code);
	duk_push_string(ctx, code.c_str());
	return true;
}

int DKDomKeyboardEvent::locale(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::locale(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	DKString locale = event->GetParameter<DKString>("locale", 0);
	duk_push_string(ctx, locale.c_str());
	return false;
}

int DKDomKeyboardEvent::location(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::location(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	int location = event->GetParameter<int>("location", 0);
	duk_push_int(ctx, location);
	return false;
}

int DKDomKeyboardEvent::metaKey(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::metaKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	bool metaKey = event->GetParameter<bool>("meta_key", 0);
	duk_push_boolean(ctx, metaKey);
	return true;
}

int DKDomKeyboardEvent::repeat(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::repeat(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	bool repeat = event->GetParameter<bool>("repeat", 0);
	duk_push_boolean(ctx, repeat);
	return false;
}

int DKDomKeyboardEvent::shiftKey(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::shiftKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	bool shiftKey = event->GetParameter<bool>("shift_key", 0);
	duk_push_boolean(ctx, shiftKey);
	return true;
}


// Methods
///////////////////////////////////////////////////////
int DKDomKeyboardEvent::getModifierState(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::getModifierState(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}


// Obsolete Methods
//////////////////////////////////////////////////////
int DKDomKeyboardEvent::initKeyEvent(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::initKeyEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool ctrlKe;
	//duk_push_boolean(ctx, ctrlKey);
	return false;
}

///////////////////////////////////////////////////////////
int DKDomKeyboardEvent::initKeyboardEvent(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::initKeyboardEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool ctrlKey = event->GetParameter<bool>("ctrl_key", 0);
	//duk_push_boolean(ctx, ctrlKey);
	return false;
}


// Obsolete properties
///////////////////////////////////////////////
int DKDomKeyboardEvent::char1(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::char1(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	return false;
}

int DKDomKeyboardEvent::charCode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::charCode(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//int charCode = keys[(Key)std::stoi(event->data[0])].charCode;
	//duk_push_int(ctx, charCode);
	return false;
}

int DKDomKeyboardEvent::keyCode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::keyCode(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//int charCode = keys[(Key)std::stoi(event->data[0])].keyCode;
	//duk_push_int(ctx, keyCode);
	return false;
}

///////////////////////////////////////////////////////
int DKDomKeyboardEvent::keyIdentifier(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::keyIdentifier(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	return false;
}

/////////////////////////////////////////////////////
int DKDomKeyboardEvent::keyLocation(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::char1(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	return false;
}

///////////////////////////////////////////////
int DKDomKeyboardEvent::which(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::which(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	return false;
}

/*
//Extra
// https://css-tricks.com/snippets/javascript/javascript-keycodes/
bool DKDomKeyboardEvent::TranslateKey(int key, DKString& value){
	switch (key) {
		case Rml::Input::KI_UNKNOWN:
			value = "Rml::Input::KI_UNKNOWN";
			break;
		case Rml::Input::KI_SPACE:
			value = "Space";
			break;
		case Rml::Input::KI_0:
			value = "Digit0";
			break;
		case Rml::Input::KI_1:
			value = "Digit1";
			break;
		case Rml::Input::KI_2:
			value = "Digit2";
			break;
		case Rml::Input::KI_3:
			value = "Digit3";
			break;
		case Rml::Input::KI_4:
			value = "Digit4";
			break;
		case Rml::Input::KI_5:
			value = "Digit5";
			break;
		case Rml::Input::KI_6:
			value = "Digit6";
			break;
		case Rml::Input::KI_7:
			value = "Digit7";
			break;
		case Rml::Input::KI_8:
			value = "Digit8";
			break;
		case Rml::Input::KI_9:
			value = "Digit9";
			break;
		case Rml::Input::KI_A:
			value = "KeyA";
			break;
		case Rml::Input::KI_B:
			value = "KeyB";
			break;
		case Rml::Input::KI_C:
			value = "KeyC";
			break;
		case Rml::Input::KI_D:
			value = "KeyD";
			break;
		case Rml::Input::KI_E:
			value = "KeyE";
			break;
		case Rml::Input::KI_F:
			value = "KeyF";
			break;
		case Rml::Input::KI_G:
			value = "KeyG";
			break;
		case Rml::Input::KI_H:
			value = "KeyH";
			break;
		case Rml::Input::KI_I:
			value = "KeyI";
			break;
		case Rml::Input::KI_J:
			value = "KeyJ";
			break;
		case Rml::Input::KI_K:
			value = "KeyK";
			break;
		case Rml::Input::KI_L:
			value = "KeyL";
			break;
		case Rml::Input::KI_M:
			value = "KeyM";
			break;
		case Rml::Input::KI_N:
			value = "KeyN";
			break;
		case Rml::Input::KI_O:
			value = "KeyO";
			break;
		case Rml::Input::KI_P:
			value = "KeyP";
			break;
		case Rml::Input::KI_Q:
			value = "KeyQ";
			break;
		case Rml::Input::KI_R:
			value = "KeyR";
			break;
		case Rml::Input::KI_S:
			value = "KeyS";
			break;
		case Rml::Input::KI_T:
			value = "KeyT";
			break;
		case Rml::Input::KI_U:
			value = "KeyU";
			break;
		case Rml::Input::KI_V:
			value = "KeyV";
			break;
		case Rml::Input::KI_W:
			value = "KeyW";
			break;
		case Rml::Input::KI_X:
			value = "KeyX";
			break;
		case Rml::Input::KI_Y:
			value = "KeyY";
			break;
		case Rml::Input::KI_Z:
			value = "KeyZ";
			break;
		case Rml::Input::KI_OEM_1:
			value = "Semicolon";
			break;				// US standard keyboard; the ';:' key.
		case Rml::Input::KI_OEM_PLUS:
			value = "Equal";
			break;			// Any region; the '=+' key.
		case Rml::Input::KI_OEM_COMMA:
			value = "Comma";
			break;			// Any region; the ',<' key.
		case Rml::Input::KI_OEM_MINUS:
			value = "Minus";
			break; 		// Any region; the '-_' key.
		case Rml::Input::KI_OEM_PERIOD:
			value = "Period";
			break;			// Any region; the '.>' key.
		case Rml::Input::KI_OEM_2:
			value = "Slash";
			break;				// Any region; the '/?' key.
		case Rml::Input::KI_OEM_3:
			value = "Backquote";
			break;				// Any region; the '`~' key.
		case Rml::Input::KI_OEM_4:
			value = "BracketLeft";
			break;				// US standard keyboard; the '[{' key.
		case Rml::Input::KI_OEM_5:
			value = "Backslash";
			break;				// US standard keyboard; the '\|' key.
		case Rml::Input::KI_OEM_6:
			value = "BracketRight";
			break;				// US standard keyboard; the ']}' key.
		case Rml::Input::KI_OEM_7:
			value = "Quote";
			break;				// US standard keyboard; the ''"' key.
		case Rml::Input::KI_OEM_8:
			value = "Rml::Input::KI_OEM_8";
			break;
		case Rml::Input::KI_OEM_102:
			value = "Rml::Input::KI_OEM_102";
			break;			// RT 102-key keyboard; the '<>' or '\|' key.
		case Rml::Input::KI_NUMPAD0:
			value = "Numpad0";
			break;
		case Rml::Input::KI_NUMPAD1:
			value = "Numpad1";
			break;
		case Rml::Input::KI_NUMPAD2:
			value = "Numpad2";
			break;
		case Rml::Input::KI_NUMPAD3:
			value = "Numpad3";
			break;
		case Rml::Input::KI_NUMPAD4:
			value = "Numpad4";
			break;
		case Rml::Input::KI_NUMPAD5:
			value = "Numpad5";
			break;
		case Rml::Input::KI_NUMPAD6:
			value = "Numpad6";
			break;
		case Rml::Input::KI_NUMPAD7:
			value = "Numpad7";
			break;
		case Rml::Input::KI_NUMPAD8:
			value = "Numpad8";
			break;
		case Rml::Input::KI_NUMPAD9:
			value = "Numpad9";
			break;
		case Rml::Input::KI_NUMPADENTER:
			value = "NumpadEnter";
			break;
		case Rml::Input::KI_MULTIPLY:
			value = "NumpadMultiply";
			break;			// Asterisk on the numeric keypad.
		case Rml::Input::KI_ADD:
			value = "NumpadAdd";
			break;				// Plus on the numeric keypad.
		case Rml::Input::KI_SEPARATOR:
			value = "NumpadMinus";
			break;
		case Rml::Input::KI_SUBTRACT:
			value = "NumpadSubtract";
			break;			// Minus on the numeric keypad.
		case Rml::Input::KI_DECIMAL:
			value = "NumpadDecimal";
			break;			// Period on the numeric keypad.
		case Rml::Input::KI_DIVIDE:
			value = "NumpadDivide";
			break;				// Forward Slash on the numeric keypad.
	
	//  NEC PC-9800 kbd definitions
	 
		case Rml::Input::KI_OEM_NEC_EQUAL:
			value = "Rml::Input::KI_OEM_NEC_EQUAL";
			break;		// Equals key on the numeric keypad.
		case Rml::Input::KI_BACK:
			value = "Backspace";
			break;				// Backspace key.
		case Rml::Input::KI_TAB:
			value = "Tab";
			break;				// Tab key.
		case Rml::Input::KI_CLEAR:
			value = "Rml::Input::KI_CLEAR";
			break;
		case Rml::Input::KI_RETURN:
			value = "Enter";
			break;
		case Rml::Input::KI_PAUSE:
			value = "Pause";
			break;
		case Rml::Input::KI_CAPITAL:
			value = "CapsLock";
			break;			// Capslock key.
		case Rml::Input::KI_KANA:
			value = "Rml::Input::KI_KANA";
			break;				// IME Kana mode.
		case Rml::Input::KI_HANGUL:
			value = "Rml::Input::KI_HANGUL";
			break;				// IME Hangul mode.
		case Rml::Input::KI_JUNJA:
			value = "Rml::Input::KI_JUNJA";
			break;				// IME Junja mode.
		case Rml::Input::KI_FINAL:
			value = "Rml::Input::KI_FINAL";
			break;				// IME final mode.
		case Rml::Input::KI_HANJA:
			value = "Rml::Input::KI_HANJA";
			break;				// IME Hanja mode.
		case Rml::Input::KI_KANJI:
			value = "Rml::Input::KI_KANJI";
			break;				// IME Kanji mode.
		case Rml::Input::KI_ESCAPE:
			value = "Escape";
			break;				// Escape key.
		case Rml::Input::KI_CONVERT:
			value = "Rml::Input::KI_CONVERT";
			break;			// IME convert.
		case Rml::Input::KI_NONCONVERT:
			value = "Rml::Input::KI_NONCONVERT";
			break;			// IME nonconvert.
		case Rml::Input::KI_ACCEPT:
			value = "Rml::Input::KI_ACCEPT";
			break;				// IME accept.
		case Rml::Input::KI_MODECHANGE:
			value = "Rml::Input::KI_MODECHANGE";
			break;			// IME mode change request.
		case Rml::Input::KI_PRIOR:
			value = "PageUp";
			break;				// Page Up key.
		case Rml::Input::KI_NEXT:
			value = "PageDown";
			break;				// Page Down key.
		case Rml::Input::KI_END:
			value = "End";
			break;
		case Rml::Input::KI_HOME:
			value = "Home";
			break;
		case Rml::Input::KI_LEFT:
			value = "ArrowLeft";
			break;				// Left Arrow key.
		case Rml::Input::KI_UP:
			value = "ArrowUp";
			break;					// Up Arrow key.
		case Rml::Input::KI_RIGHT:
			value = "ArrowRight";
			break;				// Right Arrow key.
		case Rml::Input::KI_DOWN:
			value = "ArrowDown";
			break;				// Down Arrow key.
		case Rml::Input::KI_SELECT:
			value = "Rml::Input::KI_SELECT";
			break;
		case Rml::Input::KI_PRINT:
			value = "Rml::Input::KI_PRINT";
			break;
		case Rml::Input::KI_EXECUTE:
			value = "Rml::Input::KI_EXECUTE";
			break;
		case Rml::Input::KI_SNAPSHOT:
			value = "PrintScreen";
			break;			// Print Screen key.
		case Rml::Input::KI_INSERT:
			value = "Insert";
			break;
		case Rml::Input::KI_DELETE:
			value = "Delete";
			break;
		case Rml::Input::KI_HELP:
			value = "Rml::Input::KI_HELP";
			break;
		case Rml::Input::KI_LWIN:
			value = "Rml::Input::KI_LWIN";
			break;				// Left Windows key.
		case Rml::Input::KI_RWIN:
			value = "Rml::Input::KI_RWIN";
			break;				// Right Windows key.
		case Rml::Input::KI_APPS:
			value = "Rml::Input::KI_APPS";
			break;				// Applications key.
		case Rml::Input::KI_POWER:
			value = "Rml::Input::KI_POWER";
			break;
		case Rml::Input::KI_SLEEP:
			value = "Rml::Input::KI_SLEEP";
			break;
		case Rml::Input::KI_WAKE:
			value = "Rml::Input::KI_WAKE";
			break;
		case Rml::Input::KI_F1:
			value = "F1";
			break;
		case Rml::Input::KI_F2:
			value = "F2";
			break;
		case Rml::Input::KI_F3:
			value = "F3";
			break;
		case Rml::Input::KI_F4:
			value = "F4";
			break;
		case Rml::Input::KI_F5:
			value = "F5";
			break;
		case Rml::Input::KI_F6:
			value = "F6";
			break;
		case Rml::Input::KI_F7:
			value = "F7";
			break;
		case Rml::Input::KI_F8:
			value = "F8";
			break;
		case Rml::Input::KI_F9:
			value = "F9";
			break;
		case Rml::Input::KI_F10:
			value = "F10";
			break;
		case Rml::Input::KI_F11:
			value = "F11";
			break;
		case Rml::Input::KI_F12:
			value = "F12";
			break;
		case Rml::Input::KI_F13:
			value = "F13";
			break;
		case Rml::Input::KI_F14:
			value = "F14";
			break;
		case Rml::Input::KI_F15:
			value = "F15";
			break;
		case Rml::Input::KI_F16:
			value = "F16";
			break;
		case Rml::Input::KI_F17:
			value = "F17";
			break;
		case Rml::Input::KI_F18:
			value = "F18";
			break;
		case Rml::Input::KI_F19:
			value = "F19";
			break;
		case Rml::Input::KI_F20:
			value = "F20";
			break;
		case Rml::Input::KI_F21:
			value = "F21";
			break;
		case Rml::Input::KI_F22:
			value = "F22";
			break;
		case Rml::Input::KI_F23:
			value = "F23";
			break;
		case Rml::Input::KI_F24:
			value = "F24";
			break;
		case Rml::Input::KI_NUMLOCK:
			value = "NumLock";
			break;			// Numlock key.
		case Rml::Input::KI_SCROLL:
			value = "ScrollLock";
			break;			// Scroll Lock key.
	
	//  Fujitsu/OASYS kbd definitions
	 
		case Rml::Input::KI_OEM_FJ_JISHO:
			value = "Rml::Input::KI_OEM_FJ_JISHO";
			break;		// 'Dictionary' key.
		case Rml::Input::KI_OEM_FJ_MASSHOU:
			value = "Rml::Input::KI_OEM_FJ_MASSHOU";
			break;	// 'Unregister word' key.
		case Rml::Input::KI_OEM_FJ_TOUROKU:
			value = "Rml::Input::KI_OEM_FJ_TOUROKU";
			break;	// 'Register word' key.
		case Rml::Input::KI_OEM_FJ_LOYA:
			value = "Rml::Input::KI_OEM_FJ_LOYA";
			break;		// 'Left OYAYUBI' key.
		case Rml::Input::KI_OEM_FJ_ROYA:
			value = "Rml::Input::KI_OEM_FJ_ROYA";
			break;		// 'Right OYAYUBI' key.
		case Rml::Input::KI_LSHIFT:
			value = "ShiftLeft";
			break;
		case Rml::Input::KI_RSHIFT:
			value = "ShiftRight";
			break;
		case Rml::Input::KI_LCONTROL:
			value = "ControlLeft";
			break;
		case Rml::Input::KI_RCONTROL:
			value = "ControlRight";
			break;
		case Rml::Input::KI_LMENU:
			value = "AltLeft";
			break;
		case Rml::Input::KI_RMENU:
			value = "AltRight";
			break;
		case Rml::Input::KI_BROWSER_BACK:
			value = "Rml::Input::KI_BROWSER_BACK";
			break;
		case Rml::Input::KI_BROWSER_FORWARD:
			value = "Rml::Input::KI_BROWSER_FORWARD";
			break;
		case Rml::Input::KI_BROWSER_REFRESH:
			value = "Rml::Input::KI_BROWSER_REFRESH";
			break;
		case Rml::Input::KI_BROWSER_STOP:
			value = "Rml::Input::KI_BROWSER_STOP";
			break;
		case Rml::Input::KI_BROWSER_SEARCH:
			value = "Rml::Input::KI_BROWSER_SEARCH";
			break;
		case Rml::Input::KI_BROWSER_FAVORITES:
			value = "Rml::Input::KI_BROWSER_FAVORITES";
			break;
		case Rml::Input::KI_BROWSER_HOME:
			value = "Rml::Input::KI_BROWSER_HOME";
			break;
		case Rml::Input::KI_VOLUME_MUTE:
			value = "Rml::Input::KI_VOLUME_MUTE";
			break;
		case Rml::Input::KI_VOLUME_DOWN:
			value = "Rml::Input::KI_VOLUME_DOWN";
			break;
		case Rml::Input::KI_VOLUME_UP:
			value = "Rml::Input::KI_VOLUME_UP";
			break;
		case Rml::Input::KI_MEDIA_NEXT_TRACK:
			value = "Rml::Input::KI_MEDIA_NEXT_TRACK";
			break;
		case Rml::Input::KI_MEDIA_PREV_TRACK:
			value = "Rml::Input::KI_MEDIA_PREV_TRACK";
			break;
		case Rml::Input::KI_MEDIA_STOP:
			value = "Rml::Input::KI_MEDIA_STOP";
			break;
		case Rml::Input::KI_MEDIA_PLAY_PAUSE:
			value = "Rml::Input::KI_MEDIA_PLAY_PAUSE";
			break;
		case Rml::Input::KI_LAUNCH_MAIL:
			value = "Rml::Input::KI_LAUNCH_MAIL";
			break;
		case Rml::Input::KI_LAUNCH_MEDIA_SELECT:
			value = "Rml::Input::KI_LAUNCH_MEDIA_SELECT";
			break;
		case Rml::Input::KI_LAUNCH_APP1:
			value = "Rml::Input::KI_LAUNCH_APP1";
			break;
		case Rml::Input::KI_LAUNCH_APP2:
			value = "Rml::Input::KI_LAUNCH_APP2";
			break;
	
	 //Various extended or enhanced keyboards
	 
		case Rml::Input::KI_OEM_AX:
			value = "Rml::Input::KI_OEM_AX";
			break;
		case Rml::Input::KI_ICO_HELP:
			value = "Rml::Input::KI_ICO_HELP";
			break;
		case Rml::Input::KI_ICO_00:
			value = "Rml::Input::KI_ICO_00";
			break;
		case Rml::Input::KI_PROCESSKEY:
			value = "Rml::Input::KI_PROCESSKEY";
			break;		// IME Process key.
		case Rml::Input::KI_ICO_CLEAR:
			value = "Rml::Input::KI_ICO_CLEAR";
			break;
		case Rml::Input::KI_ATTN:
			value = "Rml::Input::KI_ATTN";
			break;
		case Rml::Input::KI_CRSEL:
			value = "Rml::Input::KI_CRSEL";
			break;
		case Rml::Input::KI_EXSEL:
			value = "Rml::Input::KI_EXSEL";
			break;
		case Rml::Input::KI_EREOF:
			value = "Rml::Input::KI_EREOF";
			break;
		case Rml::Input::KI_PLAY:
			value = "Rml::Input::KI_PLAY";
			break;
		case Rml::Input::KI_ZOOM:
			value = "Rml::Input::KI_ZOOM";
			break;
		case Rml::Input::KI_PA1:
			value = "Rml::Input::KI_PA1";
			break;
		case Rml::Input::KI_OEM_CLEAR:
			value = "Rml::Input::KI_OEM_CLEAR";
			break;
		case Rml::Input::KI_LMETA:
			value = "MetaLeft";
			break;
		case Rml::Input::KI_RMETA:
			value = "MetaRight";
			break;
		default:
			return false;
			break;
	}
	return true;
}
*/

// RmlUi to DK Key Map
//static const unsigned int rmlKey[] = {
std::map<int, Key> rmlKey;

void DKDomKeyboardEvent::MapRmlKeys() {
	using namespace Rml::Input;
	rmlKey = {
		{KI_UNKNOWN, KEY_UNASSIGNED},
		{KI_SPACE, KEY_SPACE},
		{KI_0, KEY_0},
		{KI_1, KEY_1},
		{KI_2, KEY_2},
		{KI_3, KEY_3},
		{KI_4, KEY_4},
		{KI_5, KEY_5},
		{KI_6, KEY_6},
		{KI_7, KEY_7},
		{KI_8, KEY_8},
		{KI_9, KEY_9},

		{KI_A, KEY_A},
		{KI_B, KEY_B},
		{KI_C, KEY_C},
		{KI_D, KEY_D},
		{KI_E, KEY_E},
		{KI_F, KEY_F},
		{KI_G, KEY_G},
		{KI_H, KEY_H},
		{KI_I, KEY_I},
		{KI_J, KEY_J},
		{KI_K, KEY_K},
		{KI_L, KEY_L},
		{KI_M, KEY_M},
		{KI_N, KEY_N},
		{KI_O, KEY_O},
		{KI_P, KEY_P},
		{KI_Q, KEY_Q},
		{KI_R, KEY_R},
		{KI_S, KEY_S},
		{KI_T, KEY_T},
		{KI_U, KEY_U},
		{KI_V, KEY_V},
		{KI_W, KEY_W},
		{KI_X, KEY_X},
		{KI_Y, KEY_Y},
		{KI_Z, KEY_Z},

		{KI_OEM_1, KEY_OEM_1},				// US standard keyboard; the ';:' key.
		{KI_OEM_PLUS, KEY_OEM_PLUS},			// Any region; the '=+' key.
		{KI_OEM_COMMA, KEY_OEM_COMMA},			// Any region; the ',<' key.
		{KI_OEM_MINUS, KEY_OEM_MINUS},			// Any region; the '-_' key.
		{KI_OEM_PERIOD, KEY_OEM_PERIOD},			// Any region; the '.>' key.
		{KI_OEM_2, KEY_OEM_2},				// Any region; the '/?' key.
		{KI_OEM_3, KEY_OEM_3},				// Any region; the '`~' key.
		{KI_OEM_4, KEY_OEM_4},				// US standard keyboard; the '[{' key.
		{KI_OEM_5, KEY_OEM_5},				// US standard keyboard; the '\|' key.
		{KI_OEM_6, KEY_OEM_6},				// US standard keyboard; the ']}' key.
		{KI_OEM_7, KEY_OEM_7},				// US standard keyboard; the ''"' key.
		{KI_OEM_8, KEY_OEM_8},
		{KI_OEM_102, KEY_OEM_102},			// RT 102-key keyboard; the '<>' or '\|' key.

		{KI_NUMPAD0, KEY_NUMPAD0},
		{KI_NUMPAD1, KEY_NUMPAD1},
		{KI_NUMPAD2, KEY_NUMPAD2},
		{KI_NUMPAD3, KEY_NUMPAD3},
		{KI_NUMPAD4, KEY_NUMPAD4},
		{KI_NUMPAD5, KEY_NUMPAD5},
		{KI_NUMPAD6, KEY_NUMPAD6},
		{KI_NUMPAD7, KEY_NUMPAD7},
		{KI_NUMPAD8, KEY_NUMPAD8},
		{KI_NUMPAD9, KEY_NUMPAD9},
		//{KI_NUMPADENTER, KEY_NUMPADENTER},
		{KI_MULTIPLY, KEY_MULTIPLY}//,        // Asterisk on the numeric keypad.
		/*
		KI_ADD,				// Plus on the numeric keypad.
		KI_SEPARATOR,
		KI_SUBTRACT,			// Minus on the numeric keypad.
		KI_DECIMAL,			// Period on the numeric keypad.
		KI_DIVIDE,				// Forward Slash on the numeric keypad.

		// NEC PC-9800 kbd definitions
		KI_OEM_NEC_EQUAL,		// Equals key on the numeric keypad.
		KI_BACK,				// Backspace key.
		KI_TAB,				// Tab key.

		KI_CLEAR,
		KI_RETURN,

		KI_PAUSE,
		KI_CAPITAL,			// Capslock key.

		KI_KANA,				// IME Kana mode.
		KI_HANGUL,				// IME Hangul mode.
		KI_JUNJA,				// IME Junja mode.
		KI_FINAL,				// IME final mode.
		KI_HANJA,				// IME Hanja mode.
		KI_KANJI,				// IME Kanji mode.

		KI_ESCAPE,				// Escape key.
		KI_CONVERT,			// IME convert.
		KI_NONCONVERT,			// IME nonconvert.
		KI_ACCEPT,				// IME accept.
		KI_MODECHANGE,			// IME mode change request.
		KI_PRIOR,				// Page Up key.
		KI_NEXT,				// Page Down key.
		KI_END,
		KI_HOME,
		KI_LEFT,				// Left Arrow key.
		KI_UP,					// Up Arrow key.
		KI_RIGHT,				// Right Arrow key.
		KI_DOWN,				// Down Arrow key.
		KI_SELECT,
		KI_PRINT,
		KI_EXECUTE,
		KI_SNAPSHOT,			// Print Screen key.
		KI_INSERT,
		KI_DELETE,
		KI_HELP,

		KI_LWIN,				// Left Windows key.
		KI_RWIN,				// Right Windows key.
		KI_APPS,				// Applications key.
		KI_POWER,
		KI_SLEEP,
		KI_WAKE,

		KI_F1,
		KI_F2,
		KI_F3,
		KI_F4,
		KI_F5,
		KI_F6,
		KI_F7,
		KI_F8,
		KI_F9,
		KI_F10,
		KI_F11,
		KI_F12,
		KI_F13,
		KI_F14,
		KI_F15,
		KI_F16,
		KI_F17,
		KI_F18,
		KI_F19,
		KI_F20,
		KI_F21,
		KI_F22,
		KI_F23,
		KI_F24,

		KI_NUMLOCK,			// Numlock key.
		KI_SCROLL,			// Scroll Lock key.

		// Fujitsu/OASYS kbd definitions
		KI_OEM_FJ_JISHO,		// 'Dictionary' key.
		KI_OEM_FJ_MASSHOU,	// 'Unregister word' key.
		KI_OEM_FJ_TOUROKU,	// 'Register word' key.
		KI_OEM_FJ_LOYA,		// 'Left OYAYUBI' key.
		KI_OEM_FJ_ROYA,		// 'Right OYAYUBI' key.

		KI_LSHIFT,
		KI_RSHIFT,
		KI_LCONTROL,
		KI_RCONTROL,
		KI_LMENU,
		KI_RMENU,
		KI_BROWSER_BACK,
		KI_BROWSER_FORWARD,
		KI_BROWSER_REFRESH,
		KI_BROWSER_STOP,
		KI_BROWSER_SEARCH,
		KI_BROWSER_FAVORITES,
		KI_BROWSER_HOME,
		KI_VOLUME_MUTE,
		KI_VOLUME_DOWN,
		KI_VOLUME_UP,
		KI_MEDIA_NEXT_TRACK,
		KI_MEDIA_PREV_TRACK,
		KI_MEDIA_STOP,
		KI_MEDIA_PLAY_PAUSE,
		KI_LAUNCH_MAIL,
		KI_LAUNCH_MEDIA_SELECT,
		KI_LAUNCH_APP1,
		KI_LAUNCH_APP2,

		// Various extended or enhanced keyboards
		KI_OEM_AX,
		KI_ICO_HELP,
		KI_ICO_00,
		KI_PROCESSKEY,		// IME Process key.
		KI_ICO_CLEAR,
		KI_ATTN,
		KI_CRSEL,
		KI_EXSEL,
		KI_EREOF,
		KI_PLAY,
		KI_ZOOM,
		KI_PA1,
		KI_OEM_CLEAR,
		KI_LMETA,
		KI_RMETA
	};
	*/
	};
}

/*
	enum KeyModifier
	{
		KM_CTRL = 1 << 0,		// Set if at least one Ctrl key is depressed.
		KM_SHIFT = 1 << 1,		// Set if at least one Shift key is depressed.
		KM_ALT = 1 << 2,		// Set if at least one Alt key is depressed.
		KM_META = 1 << 3,		// Set if at least one Meta key (the command key) is depressed.
		KM_CAPSLOCK = 1 << 4,	// Set if caps lock is enabled.
		KM_NUMLOCK = 1 << 5,	// Set if num lock is enabled.
		KM_SCROLLLOCK = 1 << 6	// Set if scroll lock is enabled.
	};
*/
	