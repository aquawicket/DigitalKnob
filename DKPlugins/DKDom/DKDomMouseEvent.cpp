// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKMouseEvent.h"
#include "DKRml/DKEvent.h"


/////////////////////////
bool DKMouseEvent::Init()
{
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("DKMouseEvent_altKey", DKMouseEvent::altKey);
	DKDuktape::AttachFunction("DKMouseEvent_button", DKMouseEvent::button);

	// Methods
	DKDuktape::AttachFunction("DKMouseEvent_getModifierState", DKMouseEvent::getModifierState);

	DKClass::DKCreate("DKRml/DKMouseEvent.js");
	return true;
}


// Properties
//////////////////////////////////////////
int DKMouseEvent::altKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKMouseEvent::altKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	
	//TODO
	return false;
}

//////////////////////////////////////////
int DKMouseEvent::button(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKMouseEvent::button(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int button = event->GetParameter<int>("button", 0); //FIXME: returns the incorrect button numbers, check CEF
	duk_push_int(ctx, button);
	return true;
}


// Methods
////////////////////////////////////////////////////
int DKMouseEvent::getModifierState(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKMouseEvent::getModifierState(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}


#endif //USE_DKDuktape