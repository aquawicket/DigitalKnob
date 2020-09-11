// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent

#include "DK/DKApp.h"
#include "DKDom/DKDomEvent.h"
#include "DKDom/DKDomKeyboardEvent.h"
#include "DKRml/DKRml.h"


///////////////////////////////
bool DKDomKeyboardEvent::Init()
{
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("DKDomKeyboardEvent_altKey", DKDomKeyboardEvent::altKey);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_code", DKDomKeyboardEvent::code);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_ctrlKey", DKDomKeyboardEvent::ctrlKey);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_isComposing", DKDomKeyboardEvent::isComposing);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_key", DKDomKeyboardEvent::key);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_locale", DKDomKeyboardEvent::locale);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_location", DKDomKeyboardEvent::location);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_metaKey", DKDomKeyboardEvent::metaKey);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_repeat", DKDomKeyboardEvent::repeat);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_shiftKey", DKDomKeyboardEvent::shiftKey);

	// Methods
	DKDuktape::AttachFunction("DKDomKeyboardEvent_getModifierState", DKDomKeyboardEvent::getModifierState);

	// Obsolete methods
	DKDuktape::AttachFunction("DKDomKeyboardEvent_initKeyEvent", DKDomKeyboardEvent::initKeyEvent);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_initKeyboardEvent", DKDomKeyboardEvent::initKeyboardEvent);

	//Obsolete properties
	DKDuktape::AttachFunction("DKDomKeyboardEvent_char", DKDomKeyboardEvent::char1);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_charCode", DKDomKeyboardEvent::charCode);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_keyCode", DKDomKeyboardEvent::keyCode);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_keyIdentifier", DKDomKeyboardEvent::keyIdentifier);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_keyLocation", DKDomKeyboardEvent::keyLocation);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_which", DKDomKeyboardEvent::which);

	DKClass::DKCreate("DKDom/DKDomKeyboardEvent.js");
	return true;
}


// Properties
////////////////////////////////////////////////
int DKDomKeyboardEvent::altKey(duk_context* ctx)
{
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

//////////////////////////////////////////////
int DKDomKeyboardEvent::code(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::code(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	DKString code = event->GetParameter<DKString>("code", 0);
	duk_push_string(ctx, code.c_str());
	return false;
}

/////////////////////////////////////////////////
int DKDomKeyboardEvent::ctrlKey(duk_context* ctx)
{
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

/////////////////////////////////////////////////////
int DKDomKeyboardEvent::isComposing(duk_context* ctx)
{
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

/////////////////////////////////////////////
int DKDomKeyboardEvent::key(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::key(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	int key = event->GetParameter<int>("key_identifier", 0);
	duk_push_int(ctx, key);
	return true;
}

////////////////////////////////////////////////
int DKDomKeyboardEvent::locale(duk_context* ctx)
{
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

//////////////////////////////////////////////////
int DKDomKeyboardEvent::location(duk_context* ctx)
{
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

/////////////////////////////////////////////////
int DKDomKeyboardEvent::metaKey(duk_context* ctx)
{
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

////////////////////////////////////////////////
int DKDomKeyboardEvent::repeat(duk_context* ctx)
{
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

//////////////////////////////////////////////////
int DKDomKeyboardEvent::shiftKey(duk_context* ctx)
{
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
int DKDomKeyboardEvent::getModifierState(duk_context* ctx)
{
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
	//bool ctrlKey = event->GetParameter<bool>("ctrl_key", 0);
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

///////////////////////////////////////////////
int DKDomKeyboardEvent::charCode(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::charCode(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
	return false;
}

/////////////////////////////////////////////////
int DKDomKeyboardEvent::keyCode(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomKeyboardEvent::keyCode(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	//bool char1 = event->GetParameter<bool>("char", 0);
	//duk_push_int(ctx, char1);
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