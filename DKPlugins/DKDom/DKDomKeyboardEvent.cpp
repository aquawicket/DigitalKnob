// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent

#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDom/DKDomEvent.h"
#include "DKDom/DKDomKeyboardEvent.h"
#include "DKRml/DKRml.h"


////////////////////////////
bool DKDomKeyboardEvent::Init()
{
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("DKDomKeyboardEvent_key", DKDomKeyboardEvent::key);

	// Methods
	DKDuktape::AttachFunction("DKDomKeyboardEvent_getModifierState", DKDomKeyboardEvent::getModifierState);

	DKClass::DKCreate("DKDom/DKDomKeyboardEvent.js");
	return true;
}


// Properties
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
	int key = event->GetParameter<int>("key", 0);
	duk_push_int(ctx, key);
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


#endif //USE_DKDuktape