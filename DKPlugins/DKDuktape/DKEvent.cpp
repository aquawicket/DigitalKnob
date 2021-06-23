// https://developer.mozilla.org/en-US/docs/Web/API/Event

#include "DK/DKApp.h"
#include "DKDuktape/DKEvent.h"
//#include "DKDom/DKElement.h"


///////////////////////
bool DKEvent::Init()
{
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("CPP_DKEvent_bubbles", DKEvent::bubbles);
	DKDuktape::AttachFunction("CPP_DKEvent_cancelBubble", DKEvent::cancelBubble);
	DKDuktape::AttachFunction("CPP_DKEvent_cancelable", DKEvent::cancelable);
	DKDuktape::AttachFunction("CPP_DKEvent_composed", DKEvent::composed);
	DKDuktape::AttachFunction("CPP_DKEvent_currentTarget", DKEvent::currentTarget);
	DKDuktape::AttachFunction("CPP_DKEvent_deepPath", DKEvent::deepPath);
	DKDuktape::AttachFunction("CPP_DKEvent_defaultPrevented", DKEvent::defaultPrevented);
	DKDuktape::AttachFunction("CPP_DKEvent_eventPhase", DKEvent::eventPhase);
	DKDuktape::AttachFunction("CPP_DKEvent_explicitOriginalTarget", DKEvent::explicitOriginalTarget);
	DKDuktape::AttachFunction("CPP_DKEvent_originalTarget", DKEvent::originalTarget);
	DKDuktape::AttachFunction("CPP_DKEvent_returnValue", DKEvent::returnValue);
	DKDuktape::AttachFunction("CPP_DKEvent_srcElement", DKEvent::srcElement);
	DKDuktape::AttachFunction("CPP_DKEvent_target", DKEvent::target);
	DKDuktape::AttachFunction("CPP_DKEvent_timeStamp", DKEvent::timeStamp);
	DKDuktape::AttachFunction("CPP_DKEvent_type", DKEvent::type);
	DKDuktape::AttachFunction("CPP_DKEvent_isTrusted", DKEvent::isTrusted);

	// Obsolete properties
	DKDuktape::AttachFunction("CPP_DKEvent_scoped", DKEvent::scoped);

	// Methods
	DKDuktape::AttachFunction("CPP_DKEvent_createEvent", DKEvent::createEvent);
	DKDuktape::AttachFunction("CPP_DKEvent_composedPath", DKEvent::composedPath);
	DKDuktape::AttachFunction("CPP_DKEvent_initEvent", DKEvent::initEvent);
	DKDuktape::AttachFunction("CPP_DKEvent_preventDefault", DKEvent::preventDefault);
	DKDuktape::AttachFunction("CPP_DKEvent_stopImmediatePropagation", DKEvent::stopImmediatePropagation);
	DKDuktape::AttachFunction("CPP_DKEvent_stopPropagation", DKEvent::stopPropagation);

	// Obsolete methods
	DKDuktape::AttachFunction("CPP_DKEvent_getPreventDefault", DKEvent::getPreventDefault);
	DKDuktape::AttachFunction("CPP_DKEvent_preventBubble", DKEvent::preventBubble);
	DKDuktape::AttachFunction("CPP_DKEvent_preventCapture", DKEvent::preventCapture);

	// Extra
	DKDuktape::AttachFunction("CPP_DKEvent_getParameters", DKEvent::getParameters);

	DKClass::DKCreate("DKDuktape/DKEvent.js");
	return true;
}


// Properties
//////////////////////////////////////
int DKEvent::bubbles(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if(!event){
		DKERROR("DKEvent::bubbles(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int phase = (int)event->GetPhase();
	if(phase == 4){
		duk_push_boolean(ctx, true);
		return true;
	}
	duk_push_boolean(ctx, false);
	*/
	return true;
}

//////////////////////////////////////////////
int DKEvent::cancelBubble(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::cencelBubble(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	bool flag = duk_require_boolean(ctx, 1);
	if(flag){
		event->StopPropagation();
		return true;
	}
	*/
	return true;
}

////////////////////////////////////////////
int DKEvent::cancelable(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::cancelable(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}

//////////////////////////////////////////
int DKEvent::composed(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::composed(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}

///////////////////////////////////////////////
int DKEvent::currentTarget(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::currentTarget(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	Rml::Element* currentElement = event->GetCurrentElement();
	DKString currentElementAddress = DKRml::elementToAddress(currentElement);
	if(currentElementAddress.empty()){ 
		DKERROR("DKEvent::currentTarget(): currentElementAddress invalid\n");
		return true; 
	}
	duk_push_string(ctx, currentElementAddress.c_str());
	*/
	return true;
}

//////////////////////////////////////////
int DKEvent::deepPath(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::deepPath(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}

//////////////////////////////////////////////////
int DKEvent::defaultPrevented(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::defaultPrevented(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}

////////////////////////////////////////////
int DKEvent::eventPhase(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::eventPhase(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int phase = (int)event->GetPhase();
	duk_push_int(ctx, phase);
	*/
	return true;
}

////////////////////////////////////////////////////////
int DKEvent::explicitOriginalTarget(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::explicitOriginalTarget(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}

////////////////////////////////////////////////
int DKEvent::originalTarget(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::originalTarget(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}

/////////////////////////////////////////////
int DKEvent::returnValue(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::returnValue(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}

////////////////////////////////////////////
int DKEvent::srcElement(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::srcElement(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Element* srcElement = event->GetCurrentElement();
	DKString srcElementAddress = DKRml::elementToAddress(srcElement);
	if (srcElementAddress.empty()) {
		DKERROR("DKEvent::srcElement(): srcElementAddress invalid\n");
		return true;
	}
	duk_push_string(ctx, srcElementAddress.c_str());
	*/
	return true;
}

////////////////////////////////////////
int DKEvent::target(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::target(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Element* targetElement = event->GetCurrentElement();
	DKString targetElementAddress = DKRml::elementToAddress(targetElement);
	if (targetElementAddress.empty()) {
		DKERROR("DKEvent::target(): targetElementAddress invalid\n");
		return true;
	}
	duk_push_string(ctx, targetElementAddress.c_str());
	*/
	return true;
}

///////////////////////////////////////////
int DKEvent::timeStamp(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::timeStamp(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO*/
	return false;
}

//////////////////////////////////////
int DKEvent::type(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::type(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString type = event->GetType();
	if(type.empty()){
		DKERROR("DKEvent::type(): event type invalid\n");
		return true; 
	}

	if(same(type, "mouseup") && event->GetParameter<int>("button", 0) == 1){
		type = "contextmenu";
	}

	duk_push_string(ctx, type.c_str());
	*/
	return true;
}

///////////////////////////////////////////
int DKEvent::isTrusted(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::isTrusted(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}


// Obsolete properties
////////////////////////////////////////
int DKEvent::scoped(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::scoped(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}


// Methods
/////////////////////////////////////////////
int DKEvent::createEvent(duk_context* ctx) 
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::createEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}

//////////////////////////////////////////////
int DKEvent::composedPath(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::composedPath(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}

///////////////////////////////////////////
int DKEvent::initEvent(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::initEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}

////////////////////////////////////////////////
int DKEvent::preventDefault(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::preventDefault(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	*/
	return false;
}

//////////////////////////////////////////////////////////
int DKEvent::stopImmediatePropagation(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if(!event){
		DKERROR("DKEvent::stopImmediatePropagation(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	event->StopImmediatePropagation();
	*/
	return true;
}

/////////////////////////////////////////////////
int DKEvent::stopPropagation(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if(!event){
		DKERROR("DKEvent::stopPropagation(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	event->StopPropagation();
	*/
	return true;
}


// Obsolete methods
///////////////////////////////////////////////////
int DKEvent::getPreventDefault(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::getPreventDefault(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}

///////////////////////////////////////////////
int DKEvent::preventBubble(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::preventBubble(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}

////////////////////////////////////////////////
int DKEvent::preventCapture(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::preventCapture(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}


// Extra
///////////////////////////////////////////////
int DKEvent::getParameters(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::getParameters(): event invalid\n");
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
	*/
	return true;
}