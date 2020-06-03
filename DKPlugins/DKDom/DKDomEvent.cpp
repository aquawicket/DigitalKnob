// https://developer.mozilla.org/en-US/docs/Web/API/Event

#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKEvent.h"
#include "DKRml/DKElement.h"


////////////////////
bool DKEvent::Init()
{
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("DKEvent_bubbles", DKEvent::bubbles);
	DKDuktape::AttachFunction("DKEvent_cancelBubble", DKEvent::cancelBubble);
	DKDuktape::AttachFunction("DKEvent_cancelable", DKEvent::cancelable);
	DKDuktape::AttachFunction("DKEvent_composed", DKEvent::composed);
	DKDuktape::AttachFunction("DKEvent_currentTarget", DKEvent::currentTarget);
	DKDuktape::AttachFunction("DKEvent_deepPath", DKEvent::deepPath);
	DKDuktape::AttachFunction("DKEvent_defaultPrevented", DKEvent::defaultPrevented);
	DKDuktape::AttachFunction("DKEvent_eventPhase", DKEvent::eventPhase);
	DKDuktape::AttachFunction("DKEvent_explicitOriginalTarget", DKEvent::explicitOriginalTarget);
	DKDuktape::AttachFunction("DKEvent_originalTarget", DKEvent::originalTarget);
	DKDuktape::AttachFunction("DKEvent_returnValue", DKEvent::returnValue);
	DKDuktape::AttachFunction("DKEvent_srcElement", DKEvent::srcElement);
	DKDuktape::AttachFunction("DKEvent_target", DKEvent::target);
	DKDuktape::AttachFunction("DKEvent_timeStamp", DKEvent::timeStamp);
	DKDuktape::AttachFunction("DKEvent_type", DKEvent::type);
	DKDuktape::AttachFunction("DKEvent_isTrusted", DKEvent::isTrusted);

	// Obsolete properties
	DKDuktape::AttachFunction("DKEvent_scoped", DKEvent::scoped);

	// Methods
	DKDuktape::AttachFunction("DKEvent_createEvent", DKEvent::createEvent);
	DKDuktape::AttachFunction("DKEvent_composedPath", DKEvent::composedPath);
	DKDuktape::AttachFunction("DKEvent_initEvent", DKEvent::initEvent);
	DKDuktape::AttachFunction("DKEvent_preventDefault", DKEvent::preventDefault);
	DKDuktape::AttachFunction("DKEvent_stopImmediatePropagation", DKEvent::stopImmediatePropagation);
	DKDuktape::AttachFunction("DKEvent_stopPropagation", DKEvent::stopPropagation);

	// Obsolete methods
	DKDuktape::AttachFunction("DKEvent_getPreventDefault", DKEvent::getPreventDefault);
	DKDuktape::AttachFunction("DKEvent_preventBubble", DKEvent::preventBubble);
	DKDuktape::AttachFunction("DKEvent_preventCapture", DKEvent::preventCapture);

	DKClass::DKCreate("DKRml/DKEvent.js");
	return true;
}

//////////////////////////////////////////////////////////////////
Rml::Core::Event* DKEvent::addressToEvent(const DKString& address)
{
	DKDEBUGFUNC(address);

	Rml::Core::Event* event;
	if (address.compare(0, 2, "0x") != 0 || address.size() <= 2 || address.find_first_not_of("0123456789abcdefABCDEF", 2) != std::string::npos) {
		DKERROR("NOTE: DKEvent::addressToEvent(): the address is not a valid hex notation");
		return NULL;
	}

	//Convert a string of an address back into a pointer
	std::stringstream ss;
	ss << address.substr(2, address.size() - 2);
	int tmp(0);
	if (!(ss >> std::hex >> tmp)) {
		DKERROR("DKEvent::addressToEvent(" + address + "): invalid address\n");
		return NULL;
	}
	event = reinterpret_cast<Rml::Core::Event*>(tmp);
	if(!event->GetCurrentElement()){
		DKERROR("DKEvent::addressToEvent(" + address + "): currentElement invalid\n");
		return NULL;
	}
	return event;
}

/////////////////////////////////////////////////////////
DKString DKEvent::eventToAddress(Rml::Core::Event* event)
{
	if(!event){
		DKERROR("DKEvent::eventToAddress(): invalid event\n");
		return NULL;
	}
	std::stringstream ss;

	const void* address = static_cast<const void*>(event);
#ifdef WIN32
	ss << "0x" << address;
#else 
	ss << address;
#endif
	return ss.str();
}


// Properties
//////////////////////////////////////
int DKEvent::bubbles(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
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
	return true;
}

///////////////////////////////////////////
int DKEvent::cancelBubble(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
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
	return true;
}

/////////////////////////////////////////
int DKEvent::cancelable(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::cancelable(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

///////////////////////////////////////
int DKEvent::composed(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::composed(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

////////////////////////////////////////////
int DKEvent::currentTarget(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::currentTarget(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	Rml::Core::Element* currentElement = event->GetCurrentElement();
	DKString currentElementAddress = DKElement::elementToAddress(currentElement);
	if(currentElementAddress.empty()){ 
		DKERROR("DKEvent::currentTarget(): currentElementAddress invalid\n");
		return true; 
	}
	duk_push_string(ctx, currentElementAddress.c_str());
	return true;
}

///////////////////////////////////////
int DKEvent::deepPath(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::deepPath(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

///////////////////////////////////////////////
int DKEvent::defaultPrevented(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::defaultPrevented(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

/////////////////////////////////////////
int DKEvent::eventPhase(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::eventPhase(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int phase = (int)event->GetPhase();
	duk_push_int(ctx, phase);
	return true;
}

/////////////////////////////////////////////////////
int DKEvent::explicitOriginalTarget(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::explicitOriginalTarget(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

/////////////////////////////////////////////
int DKEvent::originalTarget(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::originalTarget(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

//////////////////////////////////////////
int DKEvent::returnValue(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::returnValue(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

/////////////////////////////////////////
int DKEvent::srcElement(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::srcElement(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Core::Element* srcElement = event->GetCurrentElement();
	DKString srcElementAddress = DKElement::elementToAddress(srcElement);
	if (srcElementAddress.empty()) {
		DKERROR("DKEvent::srcElement(): srcElementAddress invalid\n");
		return true;
	}
	duk_push_string(ctx, srcElementAddress.c_str());
	return true;
}

/////////////////////////////////////
int DKEvent::target(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::target(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Core::Element* targetElement = event->GetCurrentElement();
	DKString targetElementAddress = DKElement::elementToAddress(targetElement);
	if (targetElementAddress.empty()) {
		DKERROR("DKEvent::target(): targetElementAddress invalid\n");
		return true;
	}
	duk_push_string(ctx, targetElementAddress.c_str());
	return true;
}

////////////////////////////////////////
int DKEvent::timeStamp(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::timeStamp(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

///////////////////////////////////
int DKEvent::type(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
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
	duk_push_string(ctx, type.c_str());
	return true;
}

////////////////////////////////////////
int DKEvent::isTrusted(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::isTrusted(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}


// Obsolete properties
/////////////////////////////////////
int DKEvent::scoped(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::scoped(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}


// Methods
//////////////////////////////////////////
int DKEvent::createEvent(duk_context* ctx) 
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::createEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

///////////////////////////////////////////
int DKEvent::composedPath(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::composedPath(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

////////////////////////////////////////
int DKEvent::initEvent(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::initEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

/////////////////////////////////////////////
int DKEvent::preventDefault(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::preventDefault(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

///////////////////////////////////////////////////////
int DKEvent::stopImmediatePropagation(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if(!event){
		DKERROR("DKEvent::stopImmediatePropagation(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	event->StopImmediatePropagation();
	return true;
}

//////////////////////////////////////////////
int DKEvent::stopPropagation(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if(!event){
		DKERROR("DKEvent::stopPropagation(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	event->StopPropagation();
	return true;
}


// Obsolete methods
////////////////////////////////////////////////
int DKEvent::getPreventDefault(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::getPreventDefault(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

////////////////////////////////////////////
int DKEvent::preventBubble(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::preventBubble(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

/////////////////////////////////////////////
int DKEvent::preventCapture(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKEvent::preventCapture(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

#endif //USE_DKDuktape