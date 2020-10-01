// https://developer.mozilla.org/en-US/docs/Web/API/Event

#include "DK/DKApp.h"
#include "DKDom/DKDomEvent.h"
#include "DKDom/DKDomElement.h"


///////////////////////
bool DKDomEvent::Init()
{
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_bubbles", DKDomEvent::bubbles);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_cancelBubble", DKDomEvent::cancelBubble);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_cancelable", DKDomEvent::cancelable);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_composed", DKDomEvent::composed);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_currentTarget", DKDomEvent::currentTarget);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_deepPath", DKDomEvent::deepPath);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_defaultPrevented", DKDomEvent::defaultPrevented);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_eventPhase", DKDomEvent::eventPhase);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_explicitOriginalTarget", DKDomEvent::explicitOriginalTarget);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_originalTarget", DKDomEvent::originalTarget);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_returnValue", DKDomEvent::returnValue);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_srcElement", DKDomEvent::srcElement);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_target", DKDomEvent::target);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_timeStamp", DKDomEvent::timeStamp);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_type", DKDomEvent::type);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_isTrusted", DKDomEvent::isTrusted);

	// Obsolete properties
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_scoped", DKDomEvent::scoped);

	// Methods
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_createEvent", DKDomEvent::createEvent);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_composedPath", DKDomEvent::composedPath);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_initEvent", DKDomEvent::initEvent);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_preventDefault", DKDomEvent::preventDefault);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_stopImmediatePropagation", DKDomEvent::stopImmediatePropagation);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_stopPropagation", DKDomEvent::stopPropagation);

	// Obsolete methods
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_getPreventDefault", DKDomEvent::getPreventDefault);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_preventBubble", DKDomEvent::preventBubble);
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_preventCapture", DKDomEvent::preventCapture);

	// Extra
	DKDuktape::AttachFunction("DKCPP_DKDomEvent_getParameters", DKDomEvent::getParameters);

	DKClass::DKCreate("DKDom/DKDomEvent.js");
	return true;
}


// Properties
/////////////////////////////////////////
int DKDomEvent::bubbles(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if(!event){
		DKERROR("DKDomEvent::bubbles(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int phase = (int)event->GetPhase();
	if(phase == 4){
		duk_push_boolean(ctx, true);
		return true;
	}
	duk_push_boolean(ctx, false);
	return true;
}

//////////////////////////////////////////////
int DKDomEvent::cancelBubble(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::cencelBubble(): event invalid\n");
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

////////////////////////////////////////////
int DKDomEvent::cancelable(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::cancelable(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

//////////////////////////////////////////
int DKDomEvent::composed(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::composed(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

///////////////////////////////////////////////
int DKDomEvent::currentTarget(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::currentTarget(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	Rml::Element* currentElement = event->GetCurrentElement();
	DKString currentElementAddress = DKRml::elementToAddress(currentElement);
	if(currentElementAddress.empty()){ 
		DKERROR("DKDomEvent::currentTarget(): currentElementAddress invalid\n");
		return true; 
	}
	duk_push_string(ctx, currentElementAddress.c_str());
	return true;
}

//////////////////////////////////////////
int DKDomEvent::deepPath(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::deepPath(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

//////////////////////////////////////////////////
int DKDomEvent::defaultPrevented(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::defaultPrevented(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

////////////////////////////////////////////
int DKDomEvent::eventPhase(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::eventPhase(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int phase = (int)event->GetPhase();
	duk_push_int(ctx, phase);
	return true;
}

////////////////////////////////////////////////////////
int DKDomEvent::explicitOriginalTarget(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::explicitOriginalTarget(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

////////////////////////////////////////////////
int DKDomEvent::originalTarget(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::originalTarget(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

/////////////////////////////////////////////
int DKDomEvent::returnValue(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::returnValue(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

////////////////////////////////////////////
int DKDomEvent::srcElement(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::srcElement(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Element* srcElement = event->GetCurrentElement();
	DKString srcElementAddress = DKRml::elementToAddress(srcElement);
	if (srcElementAddress.empty()) {
		DKERROR("DKDomEvent::srcElement(): srcElementAddress invalid\n");
		return true;
	}
	duk_push_string(ctx, srcElementAddress.c_str());
	return true;
}

////////////////////////////////////////
int DKDomEvent::target(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::target(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Element* targetElement = event->GetCurrentElement();
	DKString targetElementAddress = DKRml::elementToAddress(targetElement);
	if (targetElementAddress.empty()) {
		DKERROR("DKDomEvent::target(): targetElementAddress invalid\n");
		return true;
	}
	duk_push_string(ctx, targetElementAddress.c_str());
	return true;
}

///////////////////////////////////////////
int DKDomEvent::timeStamp(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::timeStamp(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

//////////////////////////////////////
int DKDomEvent::type(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::type(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString type = event->GetType();
	if(type.empty()){
		DKERROR("DKDomEvent::type(): event type invalid\n");
		return true; 
	}

	if(same(type, "mouseup") && event->GetParameter<int>("button", 0) == 1){
		type = "contextmenu";
	}

	duk_push_string(ctx, type.c_str());
	return true;
}

///////////////////////////////////////////
int DKDomEvent::isTrusted(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::isTrusted(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}


// Obsolete properties
////////////////////////////////////////
int DKDomEvent::scoped(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::scoped(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}


// Methods
/////////////////////////////////////////////
int DKDomEvent::createEvent(duk_context* ctx) 
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::createEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

//////////////////////////////////////////////
int DKDomEvent::composedPath(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::composedPath(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

///////////////////////////////////////////
int DKDomEvent::initEvent(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::initEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

////////////////////////////////////////////////
int DKDomEvent::preventDefault(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::preventDefault(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

//////////////////////////////////////////////////////////
int DKDomEvent::stopImmediatePropagation(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if(!event){
		DKERROR("DKDomEvent::stopImmediatePropagation(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	event->StopImmediatePropagation();
	return true;
}

/////////////////////////////////////////////////
int DKDomEvent::stopPropagation(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if(!event){
		DKERROR("DKDomEvent::stopPropagation(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	event->StopPropagation();
	return true;
}


// Obsolete methods
///////////////////////////////////////////////////
int DKDomEvent::getPreventDefault(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::getPreventDefault(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

///////////////////////////////////////////////
int DKDomEvent::preventBubble(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::preventBubble(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

////////////////////////////////////////////////
int DKDomEvent::preventCapture(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::preventCapture(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}


// Extra
///////////////////////////////////////////////
int DKDomEvent::getParameters(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::getParameters(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//List event parameters and values
	DKINFO("LISTING EVENT PARAMETERS\n");
	const auto& p = event->GetParameters();
	DKString output = "";
	for(auto& entry : p){
		output += entry.first + ": " + entry.second.Get<Rml::String>() + "\n";
	}
	DKINFO(output);
	duk_push_string(ctx, output.c_str());
	return true;
}