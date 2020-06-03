// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDom/DKDomEvent.h"
#include "DKDom/DKDomMouseEvent.h"


////////////////////////////
bool DKDomMouseEvent::Init()
{
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("DKDomMouseEvent_altKey", DKDomMouseEvent::altKey);
	DKDuktape::AttachFunction("DKDomMouseEvent_button", DKDomMouseEvent::button);

	// Methods
	DKDuktape::AttachFunction("DKDomMouseEvent_getModifierState", DKDomMouseEvent::getModifierState);

	DKClass::DKCreate("DKDom/DKDomMouseEvent.js");
	return true;
}


// Properties
/////////////////////////////////////////////
int DKDomMouseEvent::altKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::altKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	
	//TODO
	return false;
}

/////////////////////////////////////////////
int DKDomMouseEvent::button(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::button(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int button = event->GetParameter<int>("button", 0); //FIXME: returns the incorrect button numbers, check CEF
	duk_push_int(ctx, button);
	return true;
}


// Methods
///////////////////////////////////////////////////////
int DKDomMouseEvent::getModifierState(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::getModifierState(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}


#endif //USE_DKDuktape