// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// https://unixpapa.com/js/key.html
// https://w3c.github.io/uievents/#interface-keyboardevent

#include "DK/DKApp.h"
#include "DKDuktape/DKEvent.h"
#include "DKDuktape/DKEventTarget.h"
#include "DKDuktape/DKKeyboardEvent.h"
#include "DKDuktape/DKKeyCodes.h"



///////////////////////////////
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

	
	//MapKey(0, "undefined");
	
	return true;
}




// Properties
////////////////////////////////////////////////
int DKKeyboardEvent::altKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::altKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	bool altKey = false;  
	duk_push_boolean(ctx, altKey);
	return true;
}

///////////////////////////////////////////
int DKKeyboardEvent::code(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::code(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString code = GetCodeAttribute(std::stoi(event->data[0]));
	duk_push_string(ctx, code.c_str());
	return true;
}

//////////////////////////////////////////////
int DKKeyboardEvent::ctrlKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::ctrlKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool ctrlKey;
	//duk_push_boolean(ctx, ctrlKey);
	return true;
}

//////////////////////////////////////////////////
int DKKeyboardEvent::isComposing(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::isComposing(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	//bool isComposing;
	//duk_push_boolean(ctx, isComposing);
	return false;
}

/////////////////////////////////////////////
int DKKeyboardEvent::key(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::code(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString key = GetKeyAttribute(std::stoi(event->data[0]));
	duk_push_string(ctx, key.c_str());
	return true;
}

////////////////////////////////////////////////
int DKKeyboardEvent::locale(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::locale(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//DKString locale;
	//duk_push_string(ctx, locale.c_str());
	return false;
}

//////////////////////////////////////////////////
int DKKeyboardEvent::location(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::location(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//int location;
	//duk_push_int(ctx, location);
	return false;
}

/////////////////////////////////////////////////
int DKKeyboardEvent::metaKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::metaKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool metaKey;
	//duk_push_boolean(ctx, metaKey);
	return true;
}

////////////////////////////////////////////////
int DKKeyboardEvent::repeat(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::repeat(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool repeat;
	//duk_push_boolean(ctx, repeat);
	return false;
}

//////////////////////////////////////////////////
int DKKeyboardEvent::shiftKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::shiftKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool shiftKey;
	//duk_push_boolean(ctx, shiftKey);
	return true;
}


// Methods
///////////////////////////////////////////////////////
int DKKeyboardEvent::getModifierState(duk_context* ctx)
{
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
//////////////////////////////////////////////////////
int DKKeyboardEvent::initKeyEvent(duk_context* ctx)
{
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

///////////////////////////////////////////////////////////
int DKKeyboardEvent::initKeyboardEvent(duk_context* ctx)
{
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
///////////////////////////////////////////////
int DKKeyboardEvent::char1(duk_context* ctx)
{
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

///////////////////////////////////////////////
int DKKeyboardEvent::charCode(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::charCode(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	return false;
}

/////////////////////////////////////////////////
int DKKeyboardEvent::keyCode(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::keyCode(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	return false;
}

///////////////////////////////////////////////////////
int DKKeyboardEvent::keyIdentifier(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = DKDuktape::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::keyIdentifier(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	return false;
}

/////////////////////////////////////////////////////
int DKKeyboardEvent::keyLocation(duk_context* ctx)
{
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

///////////////////////////////////////////////
int DKKeyboardEvent::which(duk_context* ctx)
{
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


//Extra
// https://css-tricks.com/snippets/javascript/javascript-keycodes/
bool DKKeyboardEvent::TranslateKey(int key, DKString& value)
{
	value = toString(key);
	return true;
	
	/*
	switch (key) {
		case KI_UNKNOWN:
			value = "KI_UNKNOWN";
			break;
		case KI_SPACE:
			value = "Space";
			break;
		case KI_0:
			value = "Digit0";
			break;
		case KI_1:
			value = "Digit1";
			break;
		case KI_2:
			value = "Digit2";
			break;
		case KI_3:
			value = "Digit3";
			break;
		case KI_4:
			value = "Digit4";
			break;
		case KI_5:
			value = "Digit5";
			break;
		case KI_6:
			value = "Digit6";
			break;
		case KI_7:
			value = "Digit7";
			break;
		case KI_8:
			value = "Digit8";
			break;
		case KI_9:
			value = "Digit9";
			break;
		case KI_A:
			value = "KeyA";
			break;
		case KI_B:
			value = "KeyB";
			break;
		case KI_C:
			value = "KeyC";
			break;
		case KI_D:
			value = "KeyD";
			break;
		case KI_E:
			value = "KeyE";
			break;
		case KI_F:
			value = "KeyF";
			break;
		case KI_G:
			value = "KeyG";
			break;
		case KI_H:
			value = "KeyH";
			break;
		case KI_I:
			value = "KeyI";
			break;
		case KI_J:
			value = "KeyJ";
			break;
		case KI_K:
			value = "KeyK";
			break;
		case KI_L:
			value = "KeyL";
			break;
		case KI_M:
			value = "KeyM";
			break;
		case KI_N:
			value = "KeyN";
			break;
		case KI_O:
			value = "KeyO";
			break;
		case KI_P:
			value = "KeyP";
			break;
		case KI_Q:
			value = "KeyQ";
			break;
		case KI_R:
			value = "KeyR";
			break;
		case KI_S:
			value = "KeyS";
			break;
		case KI_T:
			value = "KeyT";
			break;
		case KI_U:
			value = "KeyU";
			break;
		case KI_V:
			value = "KeyV";
			break;
		case KI_W:
			value = "KeyW";
			break;
		case KI_X:
			value = "KeyX";
			break;
		case KI_Y:
			value = "KeyY";
			break;
		case KI_Z:
			value = "KeyZ";
			break;
		case KI_OEM_1:
			value = "Semicolon";
			break;				// US standard keyboard; the ';:' key.
		case KI_OEM_PLUS:
			value = "Equal";
			break;			// Any region; the '=+' key.
		case KI_OEM_COMMA:
			value = "Comma";
			break;			// Any region; the ',<' key.
		case KI_OEM_MINUS:
			value = "Minus";
			break; 		// Any region; the '-_' key.
		case KI_OEM_PERIOD:
			value = "Period";
			break;			// Any region; the '.>' key.
		case KI_OEM_2:
			value = "Slash";
			break;				// Any region; the '/?' key.
		case KI_OEM_3:
			value = "Backquote";
			break;				// Any region; the '`~' key.
		case KI_OEM_4:
			value = "BracketLeft";
			break;				// US standard keyboard; the '[{' key.
		case KI_OEM_5:
			value = "Backslash";
			break;				// US standard keyboard; the '\|' key.
		case KI_OEM_6:
			value = "BracketRight";
			break;				// US standard keyboard; the ']}' key.
		case KI_OEM_7:
			value = "Quote";
			break;				// US standard keyboard; the ''"' key.
		case KI_OEM_8:
			value = "KI_OEM_8";
			break;
		case KI_OEM_102:
			value = "KI_OEM_102";
			break;			// RT 102-key keyboard; the '<>' or '\|' key.
		case KI_NUMPAD0:
			value = "Numpad0";
			break;
		case KI_NUMPAD1:
			value = "Numpad1";
			break;
		case KI_NUMPAD2:
			value = "Numpad2";
			break;
		case KI_NUMPAD3:
			value = "Numpad3";
			break;
		case KI_NUMPAD4:
			value = "Numpad4";
			break;
		case KI_NUMPAD5:
			value = "Numpad5";
			break;
		case KI_NUMPAD6:
			value = "Numpad6";
			break;
		case KI_NUMPAD7:
			value = "Numpad7";
			break;
		case KI_NUMPAD8:
			value = "Numpad8";
			break;
		case KI_NUMPAD9:
			value = "Numpad9";
			break;
		case KI_NUMPADENTER:
			value = "NumpadEnter";
			break;
		case KI_MULTIPLY:
			value = "NumpadMultiply";
			break;			// Asterisk on the numeric keypad.
		case KI_ADD:
			value = "NumpadAdd";
			break;				// Plus on the numeric keypad.
		case KI_SEPARATOR:
			value = "NumpadMinus";
			break;
		case KI_SUBTRACT:
			value = "NumpadSubtract";
			break;			// Minus on the numeric keypad.
		case KI_DECIMAL:
			value = "NumpadDecimal";
			break;			// Period on the numeric keypad.
		case KI_DIVIDE:
			value = "NumpadDivide";
			break;				// Forward Slash on the numeric keypad.
	
	//  NEC PC-9800 kbd definitions
	 
		case KI_OEM_NEC_EQUAL:
			value = "KI_OEM_NEC_EQUAL";
			break;		// Equals key on the numeric keypad.
		case KI_BACK:
			value = "Backspace";
			break;				// Backspace key.
		case KI_TAB:
			value = "Tab";
			break;				// Tab key.
		case KI_CLEAR:
			value = "KI_CLEAR";
			break;
		case KI_RETURN:
			value = "Enter";
			break;
		case KI_PAUSE:
			value = "Pause";
			break;
		case KI_CAPITAL:
			value = "CapsLock";
			break;			// Capslock key.
		case KI_KANA:
			value = "KI_KANA";
			break;				// IME Kana mode.
		case KI_HANGUL:
			value = "KI_HANGUL";
			break;				// IME Hangul mode.
		case KI_JUNJA:
			value = "KI_JUNJA";
			break;				// IME Junja mode.
		case KI_FINAL:
			value = "KI_FINAL";
			break;				// IME final mode.
		case KI_HANJA:
			value = "KI_HANJA";
			break;				// IME Hanja mode.
		case KI_KANJI:
			value = "KI_KANJI";
			break;				// IME Kanji mode.
		case KI_ESCAPE:
			value = "Escape";
			break;				// Escape key.
		case KI_CONVERT:
			value = "KI_CONVERT";
			break;			// IME convert.
		case KI_NONCONVERT:
			value = "KI_NONCONVERT";
			break;			// IME nonconvert.
		case KI_ACCEPT:
			value = "KI_ACCEPT";
			break;				// IME accept.
		case KI_MODECHANGE:
			value = "KI_MODECHANGE";
			break;			// IME mode change request.
		case KI_PRIOR:
			value = "PageUp";
			break;				// Page Up key.
		case KI_NEXT:
			value = "PageDown";
			break;				// Page Down key.
		case KI_END:
			value = "End";
			break;
		case KI_HOME:
			value = "Home";
			break;
		case KI_LEFT:
			value = "ArrowLeft";
			break;				// Left Arrow key.
		case KI_UP:
			value = "ArrowUp";
			break;					// Up Arrow key.
		case KI_RIGHT:
			value = "ArrowRight";
			break;				// Right Arrow key.
		case KI_DOWN:
			value = "ArrowDown";
			break;				// Down Arrow key.
		case KI_SELECT:
			value = "KI_SELECT";
			break;
		case KI_PRINT:
			value = "KI_PRINT";
			break;
		case KI_EXECUTE:
			value = "KI_EXECUTE";
			break;
		case KI_SNAPSHOT:
			value = "PrintScreen";
			break;			// Print Screen key.
		case KI_INSERT:
			value = "Insert";
			break;
		case KI_DELETE:
			value = "Delete";
			break;
		case KI_HELP:
			value = "KI_HELP";
			break;
		case KI_LWIN:
			value = "KI_LWIN";
			break;				// Left Windows key.
		case KI_RWIN:
			value = "KI_RWIN";
			break;				// Right Windows key.
		case KI_APPS:
			value = "KI_APPS";
			break;				// Applications key.
		case KI_POWER:
			value = "KI_POWER";
			break;
		case KI_SLEEP:
			value = "KI_SLEEP";
			break;
		case KI_WAKE:
			value = "KI_WAKE";
			break;
		case KI_F1:
			value = "F1";
			break;
		case KI_F2:
			value = "F2";
			break;
		case KI_F3:
			value = "F3";
			break;
		case KI_F4:
			value = "F4";
			break;
		case KI_F5:
			value = "F5";
			break;
		case KI_F6:
			value = "F6";
			break;
		case KI_F7:
			value = "F7";
			break;
		case KI_F8:
			value = "F8";
			break;
		case KI_F9:
			value = "F9";
			break;
		case KI_F10:
			value = "F10";
			break;
		case KI_F11:
			value = "F11";
			break;
		case KI_F12:
			value = "F12";
			break;
		case KI_F13:
			value = "F13";
			break;
		case KI_F14:
			value = "F14";
			break;
		case KI_F15:
			value = "F15";
			break;
		case KI_F16:
			value = "F16";
			break;
		case KI_F17:
			value = "F17";
			break;
		case KI_F18:
			value = "F18";
			break;
		case KI_F19:
			value = "F19";
			break;
		case KI_F20:
			value = "F20";
			break;
		case KI_F21:
			value = "F21";
			break;
		case KI_F22:
			value = "F22";
			break;
		case KI_F23:
			value = "F23";
			break;
		case KI_F24:
			value = "F24";
			break;
		case KI_NUMLOCK:
			value = "NumLock";
			break;			// Numlock key.
		case KI_SCROLL:
			value = "ScrollLock";
			break;			// Scroll Lock key.
	
	//  Fujitsu/OASYS kbd definitions
	 
		case KI_OEM_FJ_JISHO:
			value = "KI_OEM_FJ_JISHO";
			break;		// 'Dictionary' key.
		case KI_OEM_FJ_MASSHOU:
			value = "KI_OEM_FJ_MASSHOU";
			break;	// 'Unregister word' key.
		case KI_OEM_FJ_TOUROKU:
			value = "KI_OEM_FJ_TOUROKU";
			break;	// 'Register word' key.
		case KI_OEM_FJ_LOYA:
			value = "KI_OEM_FJ_LOYA";
			break;		// 'Left OYAYUBI' key.
		case KI_OEM_FJ_ROYA:
			value = "KI_OEM_FJ_ROYA";
			break;		// 'Right OYAYUBI' key.
		case KI_LSHIFT:
			value = "ShiftLeft";
			break;
		case KI_RSHIFT:
			value = "ShiftRight";
			break;
		case KI_LCONTROL:
			value = "ControlLeft";
			break;
		case KI_RCONTROL:
			value = "ControlRight";
			break;
		case KI_LMENU:
			value = "AltLeft";
			break;
		case KI_RMENU:
			value = "AltRight";
			break;
		case KI_BROWSER_BACK:
			value = "KI_BROWSER_BACK";
			break;
		case KI_BROWSER_FORWARD:
			value = "KI_BROWSER_FORWARD";
			break;
		case KI_BROWSER_REFRESH:
			value = "KI_BROWSER_REFRESH";
			break;
		case KI_BROWSER_STOP:
			value = "KI_BROWSER_STOP";
			break;
		case KI_BROWSER_SEARCH:
			value = "KI_BROWSER_SEARCH";
			break;
		case KI_BROWSER_FAVORITES:
			value = "KI_BROWSER_FAVORITES";
			break;
		case KI_BROWSER_HOME:
			value = "KI_BROWSER_HOME";
			break;
		case KI_VOLUME_MUTE:
			value = "KI_VOLUME_MUTE";
			break;
		case KI_VOLUME_DOWN:
			value = "KI_VOLUME_DOWN";
			break;
		case KI_VOLUME_UP:
			value = "KI_VOLUME_UP";
			break;
		case KI_MEDIA_NEXT_TRACK:
			value = "KI_MEDIA_NEXT_TRACK";
			break;
		case KI_MEDIA_PREV_TRACK:
			value = "KI_MEDIA_PREV_TRACK";
			break;
		case KI_MEDIA_STOP:
			value = "KI_MEDIA_STOP";
			break;
		case KI_MEDIA_PLAY_PAUSE:
			value = "KI_MEDIA_PLAY_PAUSE";
			break;
		case KI_LAUNCH_MAIL:
			value = "KI_LAUNCH_MAIL";
			break;
		case KI_LAUNCH_MEDIA_SELECT:
			value = "KI_LAUNCH_MEDIA_SELECT";
			break;
		case KI_LAUNCH_APP1:
			value = "KI_LAUNCH_APP1";
			break;
		case KI_LAUNCH_APP2:
			value = "KI_LAUNCH_APP2";
			break;
	
	 //Various extended or enhanced keyboards
	 
		case KI_OEM_AX:
			value = "KI_OEM_AX";
			break;
		case KI_ICO_HELP:
			value = "KI_ICO_HELP";
			break;
		case KI_ICO_00:
			value = "KI_ICO_00";
			break;
		case KI_PROCESSKEY:
			value = "KI_PROCESSKEY";
			break;		// IME Process key.
		case KI_ICO_CLEAR:
			value = "KI_ICO_CLEAR";
			break;
		case KI_ATTN:
			value = "KI_ATTN";
			break;
		case KI_CRSEL:
			value = "KI_CRSEL";
			break;
		case KI_EXSEL:
			value = "KI_EXSEL";
			break;
		case KI_EREOF:
			value = "KI_EREOF";
			break;
		case KI_PLAY:
			value = "KI_PLAY";
			break;
		case KI_ZOOM:
			value = "KI_ZOOM";
			break;
		case KI_PA1:
			value = "KI_PA1";
			break;
		case KI_OEM_CLEAR:
			value = "KI_OEM_CLEAR";
			break;
		case KI_LMETA:
			value = "MetaLeft";
			break;
		case KI_RMETA:
			value = "MetaRight";
			break;
		default:
			return false;
			break;
	}
	
	//value = toString(key);
	return true;
	*/
}
