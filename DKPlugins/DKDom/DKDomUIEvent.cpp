// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDom/DKDomEvent.h"
#include "DKDom/DKDomUIEvent.h"


/////////////////////////
bool DKDomUIEvent::Init()
{
	DKDEBUGFUNC();

	// Properties
	//DKDuktape::AttachFunction("DKDomUIEvent_cancelBubble", DKDomUIEvent::cancelBubble);

	// Methods
	DKDuktape::AttachFunction("DKDomUIEvent_initUIEvent", DKDomUIEvent::initUIEvent);

	DKClass::DKCreate("DKDom/DKDomUIEvent.js");
	return true;
}


// Properties
/*
///////////////////////////////////////////////
int DKDomUIEvent::cancelBubble(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomUIEvent::cencelBubble(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	bool flag = duk_require_boolean(ctx, 1);
	if(flag){
		event->StopPropagation();
		return true;
	}
	return true;
}
*/

// Methods
///////////////////////////////////////////////
int DKDomUIEvent::initUIEvent(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomUIEvent::initEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}


#endif //USE_DKDuktape