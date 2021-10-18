// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

#include "DK/DKApp.h"
#include "DKDom.h"
#include "DKDom/DKDomEvent.h"
#include "DKDom/DKDomMouseEvent.h"
//#include "DKRml/DKRml.h"


bool DKDomMouseEvent::Init(){
	DKDEBUGFUNC();
	// Properties
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_altKey", DKDomMouseEvent::altKey);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_button", DKDomMouseEvent::button);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_buttons", DKDomMouseEvent::buttons);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_clientX", DKDomMouseEvent::clientX);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_clientY", DKDomMouseEvent::clientY);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_ctrlKey", DKDomMouseEvent::ctrlKey);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_metaKey", DKDomMouseEvent::metaKey);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_movementX", DKDomMouseEvent::movementX);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_movementY", DKDomMouseEvent::movementY);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_offsetX", DKDomMouseEvent::offsetX);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_offsetY", DKDomMouseEvent::offsetY);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_offsetX", DKDomMouseEvent::offsetX);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_pageX", DKDomMouseEvent::pageX);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_pageY", DKDomMouseEvent::pageY);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_region", DKDomMouseEvent::region);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_relatedTarget", DKDomMouseEvent::relatedTarget);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_screenX", DKDomMouseEvent::screenX);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_screenY", DKDomMouseEvent::screenY);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_shiftKey", DKDomMouseEvent::shiftKey);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_which", DKDomMouseEvent::which);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_mozPressure", DKDomMouseEvent::mozPressure);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_mozIputSource", DKDomMouseEvent::mozInputSource);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_webkitForce", DKDomMouseEvent::webkitForce);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_x", DKDomMouseEvent::x);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_y", DKDomMouseEvent::y);

	// Methods
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_getModifierState", DKDomMouseEvent::getModifierState);
	DKDuktape::AttachFunction("CPP_DKDomMouseEvent_initMouseEvent", DKDomMouseEvent::initMouseEvent);

	DKClass::DKCreate("DKDom/DKDomMouseEvent.js");
	return true;
}


// Properties

int DKDomMouseEvent::altKey(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::altKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	bool altKey = event->GetParameter<bool>("alt_key", 0);
	duk_push_boolean(ctx, altKey);
	return true && DKDEBUGRETURN(ctx, altKey);
}

int DKDomMouseEvent::button(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::button(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	int button = event->GetParameter<int>("button", 0);
	if(button == 1){ button = 2; } //renumber right button to 2
	else if(button == 2){ button = 1; } //renunmber middle button to 1
	duk_push_int(ctx, button);
	return true && DKDEBUGRETURN(ctx, button);
}

int DKDomMouseEvent::buttons(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::buttons(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::clientX(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::clientX(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	int clientX = event->GetParameter<int>("mouse_x", 0);
	duk_push_int(ctx, clientX);
	return true && DKDEBUGRETURN(ctx, clientX);
}

int DKDomMouseEvent::clientY(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::clientY(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	int clientY = event->GetParameter<int>("mouse_y", 0);
	duk_push_int(ctx, clientY);
	return true && DKDEBUGRETURN(ctx, clientY);
}

int DKDomMouseEvent::ctrlKey(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::ctrlKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	bool ctrlKey = event->GetParameter<bool>("ctrl_key", 0);
	duk_push_boolean(ctx, ctrlKey);
	return true && DKDEBUGRETURN(ctx, ctrlKey);
}

int DKDomMouseEvent::metaKey(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::metaKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	bool metaKey = event->GetParameter<bool>("meta_key", 0);
	duk_push_boolean(ctx, metaKey);
	return true && DKDEBUGRETURN(ctx, metaKey);
}

int DKDomMouseEvent::movementX(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::altKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::movementY(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::movementY(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::offsetX(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::offSetX(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::offsetY(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::offsetY(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::pageX(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::pageX(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::pageY(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::pageY(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::region(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::region(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::relatedTarget(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::relatedTarget(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::screenX(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::screenX(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	int x, y;
	DKUtil::GetMousePos(x, y);
	duk_push_int(ctx, x);
	return true && DKDEBUGRETURN(ctx, x);
}

int DKDomMouseEvent::screenY(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::screenY(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	int x, y;
	DKUtil::GetMousePos(x, y);
	duk_push_int(ctx, y);
	return true && DKDEBUGRETURN(ctx, y);
}

int DKDomMouseEvent::shiftKey(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::shiftKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	bool shiftKey = event->GetParameter<bool>("shift_key", 0);
	duk_push_boolean(ctx, shiftKey);
	return true && DKDEBUGRETURN(ctx, shiftKey);
}

int DKDomMouseEvent::which(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::altKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::mozPressure(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::mozPressure(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::mozInputSource(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::mozInputSource(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::webkitForce(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::webkitForce(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::x(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::x(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	int clientX = event->GetParameter<int>("mouse_x", 0);
	duk_push_int(ctx, clientX);
	return true && DKDEBUGRETURN(ctx, clientX);
}

int DKDomMouseEvent::y(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::y(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	int clientY = event->GetParameter<int>("mouse_y", 0);
	duk_push_int(ctx, clientY);
	return true && DKDEBUGRETURN(ctx, clientY);
}


// Methods
///////////////////////////////////////////////////////
int DKDomMouseEvent::getModifierState(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::getModifierState(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	//TODO
	return false && DKDEBUGRETURN(ctx, false);
}

int DKDomMouseEvent::initMouseEvent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::initMouseEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}
