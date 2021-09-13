// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// https://unixpapa.com/js/key.html
// https://w3c.github.io/uievents/#interface-keyboardevent

#include "DK/DKApp.h"
#include "DKRml/DKRml.h"
#include "DKDom/DKDomEvent.h"
#include "DKDom/DKDomEventTarget.h"
#include "DKDom/DKDomKeyboardEvent.h"
#include "RmlUi/Core/Input.h"

std::map<int, Key> DKDomKeyboardEvent::rmlKey;

bool DKDomKeyboardEvent::Init(){
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

	MapRmlKeys();
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
	Rml::Input::KeyIdentifier key_identifier = (Rml::Input::KeyIdentifier)event->GetParameter<int>("key_identifier", 0);
	Key rml_key = rmlKey[key_identifier];
	DKKeyCodes::KeyboardEventMap key = DKKeyCodes::keys[rml_key];
	DKString code = key.code;
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
	bool isComposing;// = "undefined";
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
	Rml::Input::KeyIdentifier key_identifier = (Rml::Input::KeyIdentifier)event->GetParameter<int>("key_identifier", 0);
	Key rml_key = rmlKey[key_identifier];
	DKKeyCodes::KeyboardEventMap keyboardEvent = DKKeyCodes::keys[rml_key];
	DKString key = keyboardEvent.key;
	duk_push_string(ctx, key.c_str());
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
	DKString locale = "undefined";
	duk_push_string(ctx, locale.c_str());
	return true;
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
	Rml::Input::KeyIdentifier key_identifier = (Rml::Input::KeyIdentifier)event->GetParameter<int>("key_identifier", 0);
	Key rml_key = rmlKey[key_identifier];
	DKKeyCodes::KeyboardEventMap keyboardEvent = DKKeyCodes::keys[rml_key];
	int location = keyboardEvent.location;
	duk_push_int(ctx, location);
	return true;
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
	bool repeat;// = "undefined";
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
//////////////////////////////////////////////////////////

int DKDomKeyboardEvent::getModifierState(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::getModifierState(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	const DKString arg = duk_require_string(ctx, 1);

	if (same(arg, "AltGraph"))
		return event->GetParameter<bool>("alt_key", 0) && event->GetParameter<bool>("ctrl_key", 0);
	if(same(arg, "Alt"))
		return event->GetParameter<bool>("alt_key", 0);
	if (same(arg, "CapsLock"))
		return event->GetParameter<bool>("caps_lock_key", 0);
	if (same(arg, "Control"))
		return event->GetParameter<bool>("ctrl_key", 0);
	if (same(arg, "Meta"))
		return event->GetParameter<bool>("meta_key", 0);
	if (same(arg, "NumLock"))
		return event->GetParameter<bool>("num_lock_key", 0);
	if (same(arg, "Win "))
		return event->GetParameter<bool>("meta_key", 0);
	if (same(arg, "OS"))
		return event->GetParameter<bool>("meta_key", 0);
	if (same(arg, "ScrollLock"))
		return event->GetParameter<bool>("scroll_lock_key", 0);
	if (same(arg, "Scroll"))
		return event->GetParameter<bool>("scroll_lock_key", 0);
	if (same(arg, "Shift"))
		return event->GetParameter<bool>("shift_key", 0);

	DKERROR("incorrect parameters")
	return false;
}


// Obsolete Methods

int DKDomKeyboardEvent::initKeyEvent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::initKeyEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKDomKeyboardEvent::initKeyboardEvent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::initKeyboardEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}


// Obsolete properties

int DKDomKeyboardEvent::char1(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::char1(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
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
	Rml::Input::KeyIdentifier key_identifier = (Rml::Input::KeyIdentifier)event->GetParameter<int>("key_identifier", 0);
	Key rml_key = rmlKey[key_identifier];
	DKKeyCodes::KeyboardEventMap key = DKKeyCodes::keys[rml_key];
	int which = key.which;
	duk_push_int(ctx, which);
	return true;
}

int DKDomKeyboardEvent::keyIdentifier(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::keyIdentifier(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Input::KeyIdentifier key_identifier = (Rml::Input::KeyIdentifier)event->GetParameter<int>("key_identifier", 0);
	Key rml_key = rmlKey[key_identifier];
	DKKeyCodes::KeyboardEventMap keyboardEvent = DKKeyCodes::keys[rml_key];
	DKString key = keyboardEvent.key;
	duk_push_string(ctx, key.c_str());
	return true;
}

int DKDomKeyboardEvent::keyLocation(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::char1(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Input::KeyIdentifier key_identifier = (Rml::Input::KeyIdentifier)event->GetParameter<int>("key_identifier", 0);
	Key rml_key = rmlKey[key_identifier];
	DKKeyCodes::KeyboardEventMap keyboardEvent = DKKeyCodes::keys[rml_key];
	int location = keyboardEvent.location;
	duk_push_int(ctx, location);
	return true;
}

int DKDomKeyboardEvent::which(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::which(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Input::KeyIdentifier key_identifier = (Rml::Input::KeyIdentifier)event->GetParameter<int>("key_identifier", 0);
	Key rml_key = rmlKey[key_identifier];
	DKKeyCodes::KeyboardEventMap key = DKKeyCodes::keys[rml_key];
	int which = key.which;
	duk_push_int(ctx, which);
	return true;
}

// RmlUi to DK Key Map
void DKDomKeyboardEvent::MapRmlKeys() {
	using namespace Rml::Input;
	rmlKey = {
		{ KI_UNKNOWN, KEY_UNASSIGNED },
		{ KI_SPACE, KEY_SPACE },
		{ KI_0, KEY_0 },
		{ KI_1, KEY_1 },
		{ KI_2, KEY_2 },
		{ KI_3, KEY_3 },
		{ KI_4, KEY_4 },
		{ KI_5, KEY_5 },
		{ KI_6, KEY_6 },
		{ KI_7, KEY_7 },
		{ KI_8, KEY_8 },
		{ KI_9, KEY_9 },

		{ KI_A, KEY_A },
		{ KI_B, KEY_B },
		{ KI_C, KEY_C },
		{ KI_D, KEY_D },
		{ KI_E, KEY_E },
		{ KI_F, KEY_F },
		{ KI_G, KEY_G },
		{ KI_H, KEY_H },
		{ KI_I, KEY_I },
		{ KI_J, KEY_J },
		{ KI_K, KEY_K },
		{ KI_L, KEY_L },
		{ KI_M, KEY_M },
		{ KI_N, KEY_N },
		{ KI_O, KEY_O },
		{ KI_P, KEY_P },
		{ KI_Q, KEY_Q },
		{ KI_R, KEY_R },
		{ KI_S, KEY_S },
		{ KI_T, KEY_T },
		{ KI_U, KEY_U },
		{ KI_V, KEY_V },
		{ KI_W, KEY_W },
		{ KI_X, KEY_X },
		{ KI_Y, KEY_Y },
		{ KI_Z, KEY_Z },

		{ KI_OEM_1, KEY_OEM_1 },				   // US standard keyboard; the ';:' key.
		{ KI_OEM_PLUS, KEY_OEM_PLUS },		       // Any region; the '=+' key.
		{ KI_OEM_COMMA, KEY_OEM_COMMA },		   // Any region; the ',<' key.
		{ KI_OEM_MINUS, KEY_OEM_MINUS },		   // Any region; the '-_' key.
		{ KI_OEM_PERIOD, KEY_OEM_PERIOD },	       // Any region; the '.>' key.
		{ KI_OEM_2, KEY_OEM_2 },				   // Any region; the '/?' key.
		{ KI_OEM_3, KEY_OEM_3 },				   // Any region; the '`~' key.
		{ KI_OEM_4, KEY_OEM_4 },				   // US standard keyboard; the '[{' key.
		{ KI_OEM_5, KEY_OEM_5 },				   // US standard keyboard; the '\|' key.
		{ KI_OEM_6, KEY_OEM_6 },				   // US standard keyboard; the ']}' key.
		{ KI_OEM_7, KEY_OEM_7 },				   // US standard keyboard; the ''"' key.
		{ KI_OEM_8, KEY_OEM_8 },
		{ KI_OEM_102, KEY_OEM_102 },			   // RT 102-key keyboard; the '<>' or '\|' key.

		{ KI_NUMPAD0, KEY_NUMPAD0 },
		{ KI_NUMPAD1, KEY_NUMPAD1 },
		{ KI_NUMPAD2, KEY_NUMPAD2 },
		{ KI_NUMPAD3, KEY_NUMPAD3 },
		{ KI_NUMPAD4, KEY_NUMPAD4 },
		{ KI_NUMPAD5, KEY_NUMPAD5 },
		{ KI_NUMPAD6, KEY_NUMPAD6 },
		{ KI_NUMPAD7, KEY_NUMPAD7 },
		{ KI_NUMPAD8, KEY_NUMPAD8 },
		{ KI_NUMPAD9, KEY_NUMPAD9 },
		//{ KI_NUMPADENTER, KEY_NUMPADENTER },
		{ KI_MULTIPLY, KEY_MULTIPLY },             // Asterisk on the numeric keypad.
		{ KI_ADD, KEY_ADD },   				       // Plus on the numeric keypad.
		//{ KI_SEPARATOR, KEY_SEPARATOR },
		{ KI_SUBTRACT, KEY_SUBTRACT },    	       // Minus on the numeric keypad.
		{ KI_DECIMAL, KEY_DECIMAL },		       // Period on the numeric keypad.
		{ KI_DIVIDE, KEY_DIVIDE },			       // Forward Slash on the numeric keypad.

		// NEC PC-9800 kbd definitions
		//{ KI_OEM_NEC_EQUAL, KEY_OEM_NEC_EQUAL }  // Equals key on the numeric keypad.
		{ KI_BACK, KEY_BACK },			    	   // Backspace key.
		{ KI_TAB, KEY_TAB },	         		   // Tab key.

		{ KI_CLEAR, KEY_CLEAR },
		{ KI_RETURN, KEY_ENTER },

		{ KI_PAUSE, KEY_PAUSE },
		{ KI_CAPITAL, KEY_CAPSLOCK },		       // Capslock key.

		{ KI_KANA, KEY_KANA },				       // IME Kana mode.
		//{ KI_HANGUL, KEY_HANGUL },			   // IME Hangul mode.
		{ KI_JUNJA, KEY_JUNJA },				   // IME Junja mode.
		{ KI_FINAL, KEY_FINAL },                   // IME final mode.
		{ KI_HANJA, KEY_HANJA },				   // IME Hanja mode.
		//{ KI_KANJI, KEY_KANJI },	               // IME Kanji mode.

		{ KI_ESCAPE, KEY_ESCAPE },			       // Escape key.
		{ KI_CONVERT, KEY_CONVERT },		       // IME convert.
		{ KI_NONCONVERT, KEY_NONCONVERT },	       // IME nonconvert.
		{ KI_ACCEPT, KEY_ACCEPT },	               // IME accept.
		{ KI_MODECHANGE, KEY_MODECHANGE },         // IME mode change request.
		{ KI_PRIOR, KEY_PAGEUP },                  // Page Up key.
		{ KI_NEXT, KEY_PAGEDOWN },				   // Page Down key.
		{ KI_END, KEY_END },
		{ KI_HOME, KEY_HOME },
		{ KI_LEFT, KEY_LEFT },				       // Left Arrow key.
		{ KI_UP, KEY_UP },					       // Up Arrow key.
		{ KI_RIGHT, KEY_RIGHT },      		       // Right Arrow key.
		{ KI_DOWN, KEY_RIGHT },				       // Down Arrow key.
		{ KI_SELECT, KEY_SELECT },
		{ KI_PRINT, KEY_PRINT },
		{ KI_EXECUTE, KEY_EXECUTE_ },
		{ KI_SNAPSHOT, KEY_PRINTSCREEN },		   // Print Screen key.
		{ KI_INSERT, KEY_INSERT },
		{ KI_DELETE, KEY_DELETE },
		{ KI_HELP, KEY_HELP },

		{ KI_LWIN, KEY_METALEFT },				   // Left Windows key.
		{ KI_RWIN, KEY_METARIGHT },				   // Right Windows key.
		{ KI_APPS, KEY_CONTEXTMENU },			   // Applications key.
		//{ KI_POWER, KEY_POWER },
		{ KI_SLEEP, KEY_STANDBY },
		//{ KI_WAKE, KEY_WAKE },

		{ KI_F1, KEY_F1 },
		{ KI_F2, KEY_F2 },
		{ KI_F3, KEY_F3 },
		{ KI_F4, KEY_F4 },
	    { KI_F5, KEY_F5 },
		{ KI_F6, KEY_F6 },
		{ KI_F7, KEY_F7 },
		{ KI_F8, KEY_F8 },
		{ KI_F9, KEY_F9 },
		{ KI_F10, KEY_F10 },
		{ KI_F11, KEY_F11 },
		{ KI_F12, KEY_F12 },
		{ KI_F13, KEY_F13 },
		{ KI_F14, KEY_F14 },
		{ KI_F15, KEY_F15 },
		{ KI_F16, KEY_F16 },
		{ KI_F17, KEY_F17 },
		{ KI_F18, KEY_F18 },
	    { KI_F19, KEY_F19 },
		{ KI_F20, KEY_F20 },
		{ KI_F21, KEY_F21 },
		{ KI_F22, KEY_F22 },
		{ KI_F23, KEY_F23 },
		{ KI_F24, KEY_F24 },

		{ KI_NUMLOCK, KEY_NUMLOCK },	            // Numlock key.
		{ KI_SCROLL, KEY_SCROLLLOCK },			    // Scroll Lock key.

		// Fujitsu/OASYS kbd definitions
		{ KI_OEM_FJ_JISHO, KEY_OEM_FJ_JISHO },		// 'Dictionary' key.
		{ KI_OEM_FJ_MASSHOU, KEY_OEM_FJ_MASSHOU },	// 'Unregister word' key.
		{ KI_OEM_FJ_TOUROKU, KEY_OEM_FJ_TOUROKU },	// 'Register word' key.
		{ KI_OEM_FJ_LOYA, KEY_OEM_FJ_LOYA },		// 'Left OYAYUBI' key.
		{ KI_OEM_FJ_ROYA, KEY_OEM_FJ_ROYA },		// 'Right OYAYUBI' key.

		{ KI_LSHIFT, KEY_SHIFTLEFT },
		{ KI_RSHIFT, KEY_SHIFTRIGHT },
		{ KI_LCONTROL, KEY_CONTROLLEFT },
		{ KI_RCONTROL, KEY_CONTROLRIGHT },
		{ KI_LMENU, KEY_ALTLEFT },
		{ KI_RMENU, KEY_ALTRIGHT },
		{ KI_BROWSER_BACK, KEY_BROWSER_BACK },
		{ KI_BROWSER_FORWARD, KEY_BROWSER_FORWARD },
		{ KI_BROWSER_REFRESH, KEY_BROWSER_REFRESH },
		{ KI_BROWSER_STOP, KEY_BROWSER_STOP },
		{ KI_BROWSER_SEARCH, KEY_BROWSER_SEARCH },
		{ KI_BROWSER_FAVORITES, KEY_BROWSER_FAVORITES },
		{ KI_BROWSER_HOME, KEY_BROWSER_HOME },
		{ KI_VOLUME_MUTE, KEY_VOLUME_MUTE },
		{ KI_VOLUME_DOWN, KEY_VOLUME_DOWN },
		{ KI_VOLUME_UP, KEY_VOLUME_UP }, 
		{ KI_MEDIA_NEXT_TRACK, KEY_MEDIA_NEXT_TRACK },
		{ KI_MEDIA_PREV_TRACK, KEY_MEDIA_PREV_TRACK },
		{ KI_MEDIA_STOP, KEY_MEDIA_STOP },
		{ KI_MEDIA_PLAY_PAUSE, KEY_MEDIA_PLAY_PAUSE },
		{ KI_LAUNCH_MAIL, KEY_LAUNCH_MAIL }, 
		{ KI_LAUNCH_MEDIA_SELECT, KEY_LAUNCH_MEDIA_SELECT },
		{ KI_LAUNCH_APP1, KEY_LAUNCH_APP1 },
		{ KI_LAUNCH_APP2, KEY_LAUNCH_APP2 },

		// Various extended or enhanced keyboards
		{ KI_OEM_AX, KEY_OEM_AX },
		{ KI_ICO_HELP, KEY_ICO_HELP },
		{ KI_ICO_00, KEY_ICO_00 },
		{ KI_PROCESSKEY, KEY_PROCESS },		     // IME Process key.
		{ KI_ICO_CLEAR, KEY_ICO_CLEAR },
		{ KI_ATTN, KEY_ATTN },
		{ KI_CRSEL, KEY_CRSEL },
		{ KI_EXSEL, KEY_EXSEL },
		{ KI_EREOF, KEY_EREOF }, 
		{ KI_PLAY, KEY_PLAY },
		{ KI_ZOOM, KEY_ZOOM },
		{ KI_PA1, KEY_PA1 },
		{ KI_OEM_CLEAR, KEY_OEM_CLEAR }, 
		//{ KI_LMETA, KEY_LMETA }, 
		//{ KI_RMETA, KEY_RMETA },
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
	