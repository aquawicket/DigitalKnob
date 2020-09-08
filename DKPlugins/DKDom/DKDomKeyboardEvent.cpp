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
	DKDuktape::AttachFunction("DKDomKeyboardEvent_key", DKDomKeyboardEvent::key);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_ctrlKey", DKDomKeyboardEvent::ctrlKey);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_metaKey", DKDomKeyboardEvent::metaKey);
	DKDuktape::AttachFunction("DKDomKeyboardEvent_shiftKey", DKDomKeyboardEvent::shiftKey);

	// Methods
	DKDuktape::AttachFunction("DKDomKeyboardEvent_getModifierState", DKDomKeyboardEvent::getModifierState);

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