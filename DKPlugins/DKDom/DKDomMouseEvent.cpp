// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

#include "DK/DKApp.h"
#include "DKDom/DKDomEvent.h"
#include "DKDom/DKDomMouseEvent.h"
#include "DKRml/DKRml.h"


////////////////////////////
bool DKDomMouseEvent::Init()
{
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("DKDomMouseEvent_altKey", DKDomMouseEvent::altKey);
	DKDuktape::AttachFunction("DKDomMouseEvent_button", DKDomMouseEvent::button);
	DKDuktape::AttachFunction("DKDomMouseEvent_buttons", DKDomMouseEvent::buttons);
	DKDuktape::AttachFunction("DKDomMouseEvent_clientX", DKDomMouseEvent::clientX);
	DKDuktape::AttachFunction("DKDomMouseEvent_clientY", DKDomMouseEvent::clientY);
	DKDuktape::AttachFunction("DKDomMouseEvent_ctrlKey", DKDomMouseEvent::ctrlKey);
	DKDuktape::AttachFunction("DKDomMouseEvent_metaKey", DKDomMouseEvent::metaKey);
	DKDuktape::AttachFunction("DKDomMouseEvent_movementX", DKDomMouseEvent::movementX);
	DKDuktape::AttachFunction("DKDomMouseEvent_movementY", DKDomMouseEvent::movementY);
	DKDuktape::AttachFunction("DKDomMouseEvent_offsetX", DKDomMouseEvent::offsetX);
	DKDuktape::AttachFunction("DKDomMouseEvent_offsetY", DKDomMouseEvent::offsetY);
	DKDuktape::AttachFunction("DKDomMouseEvent_offsetX", DKDomMouseEvent::offsetX);
	DKDuktape::AttachFunction("DKDomMouseEvent_pageX", DKDomMouseEvent::pageX);
	DKDuktape::AttachFunction("DKDomMouseEvent_pageY", DKDomMouseEvent::pageY);
	DKDuktape::AttachFunction("DKDomMouseEvent_region", DKDomMouseEvent::region);
	DKDuktape::AttachFunction("DKDomMouseEvent_relatedTarget", DKDomMouseEvent::relatedTarget);
	DKDuktape::AttachFunction("DKDomMouseEvent_screenX", DKDomMouseEvent::screenX);
	DKDuktape::AttachFunction("DKDomMouseEvent_screenY", DKDomMouseEvent::screenY);
	DKDuktape::AttachFunction("DKDomMouseEvent_shiftKey", DKDomMouseEvent::shiftKey);
	DKDuktape::AttachFunction("DKDomMouseEvent_which", DKDomMouseEvent::which);
	DKDuktape::AttachFunction("DKDomMouseEvent_mozPressure", DKDomMouseEvent::mozPressure);
	DKDuktape::AttachFunction("DKDomMouseEvent_mozIputSource", DKDomMouseEvent::mozInputSource);
	DKDuktape::AttachFunction("DKDomMouseEvent_webkitForce", DKDomMouseEvent::webkitForce);
	DKDuktape::AttachFunction("DKDomMouseEvent_x", DKDomMouseEvent::x);
	DKDuktape::AttachFunction("DKDomMouseEvent_y", DKDomMouseEvent::y);

	// Methods
	DKDuktape::AttachFunction("DKDomMouseEvent_getModifierState", DKDomMouseEvent::getModifierState);
	DKDuktape::AttachFunction("DKDomMouseEvent_initMouseEvent", DKDomMouseEvent::initMouseEvent);

	DKClass::DKCreate("DKDom/DKDomMouseEvent.js");
	return true;
}


// Properties
/////////////////////////////////////////////
int DKDomMouseEvent::altKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::altKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	
	bool altKey = event->GetParameter<bool>("alt_key", 0);
	duk_push_boolean(ctx, altKey);
	return true;
}

/////////////////////////////////////////////
int DKDomMouseEvent::button(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::button(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int button = event->GetParameter<int>("button", 0);
	if(button == 1){ button = 2; } //renumber right button to 2
	if(button == 2){ button = 1; } //renunmber middle button to 1
	duk_push_int(ctx, button);
	return true;
}

/////////////////////////////////////////////
int DKDomMouseEvent::buttons(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::buttons(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

/////////////////////////////////////////////
int DKDomMouseEvent::clientX(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::clientX(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	int clientX = event->GetParameter<int>("mouse_x", 0);
	duk_push_int(ctx, clientX);
	return true;
}

//////////////////////////////////////////////
int DKDomMouseEvent::clientY(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::clientY(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	int clientY = event->GetParameter<int>("mouse_y", 0);
	duk_push_int(ctx, clientY);
	return true;
}

/////////////////////////////////////////////
int DKDomMouseEvent::ctrlKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::ctrlKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	bool ctrlKey = event->GetParameter<bool>("ctrl_key", 0);
	duk_push_boolean(ctx, ctrlKey);
	return true;
}

/////////////////////////////////////////////
int DKDomMouseEvent::metaKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::metaKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	bool metaKey = event->GetParameter<bool>("meta_key", 0);
	duk_push_boolean(ctx, metaKey);
	return true;
}

////////////////////////////////////////////////
int DKDomMouseEvent::movementX(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::altKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

////////////////////////////////////////////////
int DKDomMouseEvent::movementY(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::movementY(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

//////////////////////////////////////////////
int DKDomMouseEvent::offsetX(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::offSetX(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

//////////////////////////////////////////////
int DKDomMouseEvent::offsetY(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::offsetY(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

////////////////////////////////////////////
int DKDomMouseEvent::pageX(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::pageX(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

////////////////////////////////////////////
int DKDomMouseEvent::pageY(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::pageY(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

/////////////////////////////////////////////
int DKDomMouseEvent::region(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::region(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

////////////////////////////////////////////////////
int DKDomMouseEvent::relatedTarget(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::relatedTarget(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

//////////////////////////////////////////////
int DKDomMouseEvent::screenX(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::screenX(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	int x, y;
	DKUtil::GetMousePos(x, y);
	duk_push_int(ctx, x);
	return true;
}

//////////////////////////////////////////////
int DKDomMouseEvent::screenY(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::screenY(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	int x, y;
	DKUtil::GetMousePos(x, y);
	duk_push_int(ctx, y);
	return true;
}

///////////////////////////////////////////////
int DKDomMouseEvent::shiftKey(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::shiftKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	bool shiftKey = event->GetParameter<bool>("shift_key", 0);
	duk_push_boolean(ctx, shiftKey);
	return true;
}

////////////////////////////////////////////
int DKDomMouseEvent::which(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::altKey(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

//////////////////////////////////////////////////
int DKDomMouseEvent::mozPressure(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::mozPressure(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

/////////////////////////////////////////////////////
int DKDomMouseEvent::mozInputSource(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::mozInputSource(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

//////////////////////////////////////////////////
int DKDomMouseEvent::webkitForce(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::webkitForce(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

////////////////////////////////////////
int DKDomMouseEvent::x(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::x(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	int clientX = event->GetParameter<int>("mouse_x", 0);
	duk_push_int(ctx, clientX);
	return true;
}

////////////////////////////////////////
int DKDomMouseEvent::y(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::y(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	int clientY = event->GetParameter<int>("mouse_y", 0);
	duk_push_int(ctx, clientY);
	return true;
}


// Methods
///////////////////////////////////////////////////////
int DKDomMouseEvent::getModifierState(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomMouseEvent::getModifierState(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

/////////////////////////////////////////////////////
int DKDomMouseEvent::initMouseEvent(duk_context* ctx)
{
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