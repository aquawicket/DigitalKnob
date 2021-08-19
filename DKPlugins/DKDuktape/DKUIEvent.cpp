// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

#include "DK/DKApp.h"
#include "DKDuktape/DKUIEvent.h"
#include "DKDuktape/DKEvent.h"
//#include "DKRml/DKRml.h"


bool DKUIEvent::Init(){
	DKDEBUGFUNC();

	// Properties
	//DKDuktape::AttachFunction("CPP_DKUIEvent_cancelBubble", DKUIEvent::cancelBubble);

	// Methods
	DKDuktape::AttachFunction("CPP_DKUIEvent_initUIEvent", DKUIEvent::initUIEvent);

	DKClass::DKCreate("DKDuktape/DKUIEvent.js");
	return true;
}


// Properties
/*
int DKUIEvent::cancelBubble(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKEvent::addressToEvent(eventAddress);
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
*/

// Methods
int DKUIEvent::initUIEvent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKUIEvent::initEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}