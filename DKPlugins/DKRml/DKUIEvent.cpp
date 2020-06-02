// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKUIEvent.h"


//////////////////////
bool DKUIEvent::Init()
{
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("DKUIEvent_cancelBubble", DKUIEvent::cancelBubble);

	// Methods
	DKDuktape::AttachFunction("DKUIEvent_initUIEvent", DKEvent::initUIEvent);

	DKClass::DKCreate("DKRml/DKUIEvent.js");
	return true;
}


// Properties
/////////////////////////////////////////////
int DKUIEvent::cancelBubble(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKUIEvent::cencelBubble(): event invalid\n");
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


// Methods
//////////////////////////////////////////
int DKUIEvent::initEvent(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKUIEvent::initEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}


#endif //USE_DKDuktape