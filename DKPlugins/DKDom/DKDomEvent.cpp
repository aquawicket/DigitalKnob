// https://developer.mozilla.org/en-US/docs/Web/API/Event

#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDom/DKDomEvent.h"
#include "DKDom/DKDomElement.h"


///////////////////////
bool DKDomEvent::Init()
{
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("DKDomEvent_bubbles", DKDomEvent::bubbles);
	DKDuktape::AttachFunction("DKDomEvent_cancelBubble", DKDomEvent::cancelBubble);
	DKDuktape::AttachFunction("DKDomEvent_cancelable", DKDomEvent::cancelable);
	DKDuktape::AttachFunction("DKDomEvent_composed", DKDomEvent::composed);
	DKDuktape::AttachFunction("DKDomEvent_currentTarget", DKDomEvent::currentTarget);
	DKDuktape::AttachFunction("DKDomEvent_deepPath", DKDomEvent::deepPath);
	DKDuktape::AttachFunction("DKDomEvent_defaultPrevented", DKDomEvent::defaultPrevented);
	DKDuktape::AttachFunction("DKDomEvent_eventPhase", DKDomEvent::eventPhase);
	DKDuktape::AttachFunction("DKDomEvent_explicitOriginalTarget", DKDomEvent::explicitOriginalTarget);
	DKDuktape::AttachFunction("DKDomEvent_originalTarget", DKDomEvent::originalTarget);
	DKDuktape::AttachFunction("DKDomEvent_returnValue", DKDomEvent::returnValue);
	DKDuktape::AttachFunction("DKDomEvent_srcElement", DKDomEvent::srcElement);
	DKDuktape::AttachFunction("DKDomEvent_target", DKDomEvent::target);
	DKDuktape::AttachFunction("DKDomEvent_timeStamp", DKDomEvent::timeStamp);
	DKDuktape::AttachFunction("DKDomEvent_type", DKDomEvent::type);
	DKDuktape::AttachFunction("DKDomEvent_isTrusted", DKDomEvent::isTrusted);

	// Obsolete properties
	DKDuktape::AttachFunction("DKDomEvent_scoped", DKDomEvent::scoped);

	// Methods
	DKDuktape::AttachFunction("DKDomEvent_createEvent", DKDomEvent::createEvent);
	DKDuktape::AttachFunction("DKDomEvent_composedPath", DKDomEvent::composedPath);
	DKDuktape::AttachFunction("DKDomEvent_initEvent", DKDomEvent::initEvent);
	DKDuktape::AttachFunction("DKDomEvent_preventDefault", DKDomEvent::preventDefault);
	DKDuktape::AttachFunction("DKDomEvent_stopImmediatePropagation", DKDomEvent::stopImmediatePropagation);
	DKDuktape::AttachFunction("DKDomEvent_stopPropagation", DKDomEvent::stopPropagation);

	// Obsolete methods
	DKDuktape::AttachFunction("DKDomEvent_getPreventDefault", DKDomEvent::getPreventDefault);
	DKDuktape::AttachFunction("DKDomEvent_preventBubble", DKDomEvent::preventBubble);
	DKDuktape::AttachFunction("DKDomEvent_preventCapture", DKDomEvent::preventCapture);

	DKClass::DKCreate("DKDom/DKDomEvent.js");
	return true;
}

/////////////////////////////////////////////////////////////////////
Rml::Core::Event* DKDomEvent::addressToEvent(const DKString& address)
{
	DKDEBUGFUNC(address);

	Rml::Core::Event* event;
	if (address.compare(0, 2, "0x") != 0 || address.size() <= 2 || address.find_first_not_of("0123456789abcdefABCDEF", 2) != std::string::npos) {
		DKERROR("NOTE: DKDomEvent::addressToEvent(): the address is not a valid hex notation");
		return NULL;
	}

	//Convert a string of an address back into a pointer
	std::stringstream ss;
	ss << address.substr(2, address.size() - 2);
	int tmp(0);
	if (!(ss >> std::hex >> tmp)) {
		DKERROR("DKDomEvent::addressToEvent(" + address + "): invalid address\n");
		return NULL;
	}
	event = reinterpret_cast<Rml::Core::Event*>(tmp);
	if(!event->GetCurrentElement()){
		DKERROR("DKDomEvent::addressToEvent(" + address + "): currentElement invalid\n");
		return NULL;
	}
	return event;
}

////////////////////////////////////////////////////////////
DKString DKDomEvent::eventToAddress(Rml::Core::Event* event)
{
	if(!event){
		DKERROR("DKDomEvent::eventToAddress(): invalid event\n");
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
/////////////////////////////////////////
int DKDomEvent::bubbles(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::currentTarget(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	Rml::Core::Element* currentElement = event->GetCurrentElement();
	DKString currentElementAddress = DKElement::elementToAddress(currentElement);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::srcElement(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Core::Element* srcElement = event->GetCurrentElement();
	DKString srcElementAddress = DKElement::elementToAddress(srcElement);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::target(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Core::Element* targetElement = event->GetCurrentElement();
	DKString targetElementAddress = DKElement::elementToAddress(targetElement);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	duk_push_string(ctx, type.c_str());
	return true;
}

///////////////////////////////////////////
int DKDomEvent::isTrusted(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
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
	Rml::Core::Event* event = DKDomEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKDomEvent::preventCapture(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	return false;
}

#endif //USE_DKDuktape