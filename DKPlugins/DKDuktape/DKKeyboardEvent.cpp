// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent

#include "DK/DKApp.h"
#include "DKDuktape/DKEvent.h"
#include "DKDuktape/DKKeyboardEvent.h"


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
	return true;
}


// Properties
////////////////////////////////////////////////
int DKKeyboardEvent::altKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::altKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	bool altKey = event->GetParameter<bool>("alt_key", 0);
	duk_push_boolean(ctx, altKey);
	*/
	return true;
}

//////////////////////////////////////////////
int DKKeyboardEvent::code(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::code(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//int key = event->GetParameter<int>("key_identifier", 0);
	Rml::Input::KeyIdentifier key = (Rml::Input::KeyIdentifier) event->GetParameter<int>("key_identifier", 0);
	DKString code;
	TranslateKey(key, code);
	duk_push_string(ctx, code.c_str());
	*/
	return true;
}

/////////////////////////////////////////////////
int DKKeyboardEvent::ctrlKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::ctrlKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	bool ctrlKey = event->GetParameter<bool>("ctrl_key", 0);
	duk_push_boolean(ctx, ctrlKey);
	*/
	return true;
}

/////////////////////////////////////////////////////
int DKKeyboardEvent::isComposing(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::isComposing(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	bool isComposing = event->GetParameter<bool>("isComposing", 0);
	duk_push_boolean(ctx, isComposing);
	*/
	return false;
}

/////////////////////////////////////////////
int DKKeyboardEvent::key(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::key(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	int key = event->GetParameter<int>("key_identifier", 0);
	duk_push_int(ctx, key);
	*/
	return true;
}

////////////////////////////////////////////////
int DKKeyboardEvent::locale(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::locale(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	DKString locale = event->GetParameter<DKString>("locale", 0);
	duk_push_string(ctx, locale.c_str());
	*/
	return false;
}

//////////////////////////////////////////////////
int DKKeyboardEvent::location(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::location(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	int location = event->GetParameter<int>("location", 0);
	duk_push_int(ctx, location);
	*/
	return false;
}

/////////////////////////////////////////////////
int DKKeyboardEvent::metaKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::metaKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	bool metaKey = event->GetParameter<bool>("meta_key", 0);
	duk_push_boolean(ctx, metaKey);
	*/
	return true;
}

////////////////////////////////////////////////
int DKKeyboardEvent::repeat(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::repeat(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	bool repeat = event->GetParameter<bool>("repeat", 0);
	duk_push_boolean(ctx, repeat);
	*/
	return false;
}

//////////////////////////////////////////////////
int DKKeyboardEvent::shiftKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::shiftKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	bool shiftKey = event->GetParameter<bool>("shift_key", 0);
	duk_push_boolean(ctx, shiftKey);
	*/
	return true;
}


// Methods
///////////////////////////////////////////////////////
int DKKeyboardEvent::getModifierState(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::getModifierState(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}


// Obsolete Methods
//////////////////////////////////////////////////////
int DKKeyboardEvent::initKeyEvent(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::initKeyEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	//bool ctrlKey = event->GetParameter<bool>("ctrl_key", 0);
	//duk_push_boolean(ctx, ctrlKey);
	*/
	return false;
}

///////////////////////////////////////////////////////////
int DKKeyboardEvent::initKeyboardEvent(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::initKeyboardEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	//bool ctrlKey = event->GetParameter<bool>("ctrl_key", 0);
	//duk_push_boolean(ctx, ctrlKey);
	*/
	return false;
}


// Obsolete properties
///////////////////////////////////////////////
int DKKeyboardEvent::char1(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::char1(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	*/
	return false;
}

///////////////////////////////////////////////
int DKKeyboardEvent::charCode(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::charCode(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	*/
	return false;
}

/////////////////////////////////////////////////
int DKKeyboardEvent::keyCode(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::keyCode(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	*/
	return false;
}

///////////////////////////////////////////////////////
int DKKeyboardEvent::keyIdentifier(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::keyIdentifier(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	*/
	return false;
}

/////////////////////////////////////////////////////
int DKKeyboardEvent::keyLocation(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::char1(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	*/
	return false;
}

///////////////////////////////////////////////
int DKKeyboardEvent::which(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKKeyboardEvent::which(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	*/
	return false;
}


//Extra
bool DKKeyboardEvent::TranslateKey(int key, DKString& value)
{
	/*
	switch (key) {
		case Rml::Input::KI_UNKNOWN:
			value = "KI_UNKNOWN";
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
			value = "KI_OEM_8";
			break;
		case Rml::Input::KI_OEM_102:
			value = "KI_OEM_102";
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
			value = "KI_OEM_NEC_EQUAL";
			break;		// Equals key on the numeric keypad.
		case Rml::Input::KI_BACK:
			value = "Backspace";
			break;				// Backspace key.
		case Rml::Input::KI_TAB:
			value = "Tab";
			break;				// Tab key.
		case Rml::Input::KI_CLEAR:
			value = "KI_CLEAR";
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
			value = "KI_KANA";
			break;				// IME Kana mode.
		case Rml::Input::KI_HANGUL:
			value = "KI_HANGUL";
			break;				// IME Hangul mode.
		case Rml::Input::KI_JUNJA:
			value = "KI_JUNJA";
			break;				// IME Junja mode.
		case Rml::Input::KI_FINAL:
			value = "KI_FINAL";
			break;				// IME final mode.
		case Rml::Input::KI_HANJA:
			value = "KI_HANJA";
			break;				// IME Hanja mode.
		case Rml::Input::KI_KANJI:
			value = "KI_KANJI";
			break;				// IME Kanji mode.
		case Rml::Input::KI_ESCAPE:
			value = "Escape";
			break;				// Escape key.
		case Rml::Input::KI_CONVERT:
			value = "KI_CONVERT";
			break;			// IME convert.
		case Rml::Input::KI_NONCONVERT:
			value = "KI_NONCONVERT";
			break;			// IME nonconvert.
		case Rml::Input::KI_ACCEPT:
			value = "KI_ACCEPT";
			break;				// IME accept.
		case Rml::Input::KI_MODECHANGE:
			value = "KI_MODECHANGE";
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
			value = "KI_SELECT";
			break;
		case Rml::Input::KI_PRINT:
			value = "KI_PRINT";
			break;
		case Rml::Input::KI_EXECUTE:
			value = "KI_EXECUTE";
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
			value = "KI_HELP";
			break;
		case Rml::Input::KI_LWIN:
			value = "KI_LWIN";
			break;				// Left Windows key.
		case Rml::Input::KI_RWIN:
			value = "KI_RWIN";
			break;				// Right Windows key.
		case Rml::Input::KI_APPS:
			value = "KI_APPS";
			break;				// Applications key.
		case Rml::Input::KI_POWER:
			value = "KI_POWER";
			break;
		case Rml::Input::KI_SLEEP:
			value = "KI_SLEEP";
			break;
		case Rml::Input::KI_WAKE:
			value = "KI_WAKE";
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
			value = "KI_OEM_FJ_JISHO";
			break;		// 'Dictionary' key.
		case Rml::Input::KI_OEM_FJ_MASSHOU:
			value = "KI_OEM_FJ_MASSHOU";
			break;	// 'Unregister word' key.
		case Rml::Input::KI_OEM_FJ_TOUROKU:
			value = "KI_OEM_FJ_TOUROKU";
			break;	// 'Register word' key.
		case Rml::Input::KI_OEM_FJ_LOYA:
			value = "KI_OEM_FJ_LOYA";
			break;		// 'Left OYAYUBI' key.
		case Rml::Input::KI_OEM_FJ_ROYA:
			value = "KI_OEM_FJ_ROYA";
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
			value = "KI_BROWSER_BACK";
			break;
		case Rml::Input::KI_BROWSER_FORWARD:
			value = "KI_BROWSER_FORWARD";
			break;
		case Rml::Input::KI_BROWSER_REFRESH:
			value = "KI_BROWSER_REFRESH";
			break;
		case Rml::Input::KI_BROWSER_STOP:
			value = "KI_BROWSER_STOP";
			break;
		case Rml::Input::KI_BROWSER_SEARCH:
			value = "KI_BROWSER_SEARCH";
			break;
		case Rml::Input::KI_BROWSER_FAVORITES:
			value = "KI_BROWSER_FAVORITES";
			break;
		case Rml::Input::KI_BROWSER_HOME:
			value = "KI_BROWSER_HOME";
			break;
		case Rml::Input::KI_VOLUME_MUTE:
			value = "KI_VOLUME_MUTE";
			break;
		case Rml::Input::KI_VOLUME_DOWN:
			value = "KI_VOLUME_DOWN";
			break;
		case Rml::Input::KI_VOLUME_UP:
			value = "KI_VOLUME_UP";
			break;
		case Rml::Input::KI_MEDIA_NEXT_TRACK:
			value = "KI_MEDIA_NEXT_TRACK";
			break;
		case Rml::Input::KI_MEDIA_PREV_TRACK:
			value = "KI_MEDIA_PREV_TRACK";
			break;
		case Rml::Input::KI_MEDIA_STOP:
			value = "KI_MEDIA_STOP";
			break;
		case Rml::Input::KI_MEDIA_PLAY_PAUSE:
			value = "KI_MEDIA_PLAY_PAUSE";
			break;
		case Rml::Input::KI_LAUNCH_MAIL:
			value = "KI_LAUNCH_MAIL";
			break;
		case Rml::Input::KI_LAUNCH_MEDIA_SELECT:
			value = "KI_LAUNCH_MEDIA_SELECT";
			break;
		case Rml::Input::KI_LAUNCH_APP1:
			value = "KI_LAUNCH_APP1";
			break;
		case Rml::Input::KI_LAUNCH_APP2:
			value = "KI_LAUNCH_APP2";
			break;
	
	 //Various extended or enhanced keyboards
	 
		case Rml::Input::KI_OEM_AX:
			value = "KI_OEM_AX";
			break;
		case Rml::Input::KI_ICO_HELP:
			value = "KI_ICO_HELP";
			break;
		case Rml::Input::KI_ICO_00:
			value = "KI_ICO_00";
			break;
		case Rml::Input::KI_PROCESSKEY:
			value = "KI_PROCESSKEY";
			break;		// IME Process key.
		case Rml::Input::KI_ICO_CLEAR:
			value = "KI_ICO_CLEAR";
			break;
		case Rml::Input::KI_ATTN:
			value = "KI_ATTN";
			break;
		case Rml::Input::KI_CRSEL:
			value = "KI_CRSEL";
			break;
		case Rml::Input::KI_EXSEL:
			value = "KI_EXSEL";
			break;
		case Rml::Input::KI_EREOF:
			value = "KI_EREOF";
			break;
		case Rml::Input::KI_PLAY:
			value = "KI_PLAY";
			break;
		case Rml::Input::KI_ZOOM:
			value = "KI_ZOOM";
			break;
		case Rml::Input::KI_PA1:
			value = "KI_PA1";
			break;
		case Rml::Input::KI_OEM_CLEAR:
			value = "KI_OEM_CLEAR";
			break;
		case Rml::Input::KI_LMETA:
			value = "MetaLeft";
			break;
		case Rml::Input::KI_RMETA:
			value = "MetaRight";
			break;
		default:
			return "";
			break;
	}
*/
	return true;
}
