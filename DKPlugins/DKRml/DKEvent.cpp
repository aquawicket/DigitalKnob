// https://developer.mozilla.org/en-US/docs/Web/API/Event

#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKEvent.h"


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

	DKClass::DKCreate("DKDuktape/DKEvent.js");
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
	//TODO
	return false;
}

///////////////////////////////////////////
int DKEvent::cancelBubble(duk_context* ctx)
{
	//TODO
	return false;
}

/////////////////////////////////////////
int DKEvent::cancelable(duk_context* ctx)
{
	//TODO
	return false;
}

///////////////////////////////////////
int DKEvent::composed(duk_context* ctx)
{
	//TODO
	return false;
}

////////////////////////////////////////////
int DKEvent::currentTarget(duk_context* ctx)
{
	//TODO
	return false;
}

///////////////////////////////////////
int DKEvent::deepPath(duk_context* ctx)
{
	//TODO
	return false;
}

///////////////////////////////////////////////
int DKEvent::defaultPrevented(duk_context* ctx)
{
	//TODO
	return false;
}

/////////////////////////////////////////
int DKEvent::eventPhase(duk_context* ctx)
{
	//TODO
	return false;
}

/////////////////////////////////////////////////////
int DKEvent::explicitOriginalTarget(duk_context* ctx)
{
	//TODO
	return false;
}

/////////////////////////////////////////////
int DKEvent::originalTarget(duk_context* ctx)
{
	//TODO
	return false;
}

//////////////////////////////////////////
int DKEvent::returnValue(duk_context* ctx)
{
	//TODO
	return false;
}

/////////////////////////////////////////
int DKEvent::srcElement(duk_context* ctx)
{
	//TODO
	return false;
}

/////////////////////////////////////
int DKEvent::target(duk_context* ctx)
{
	//TODO
	return false;
}

////////////////////////////////////////
int DKEvent::timeStamp(duk_context* ctx)
{
	//TODO
	return false;
}

///////////////////////////////////
int DKEvent::type(duk_context* ctx)
{
	//TODO
	return false;
}

////////////////////////////////////////
int DKEvent::isTrusted(duk_context* ctx)
{
	//TODO
	return false;
}


// Obsolete properties
/////////////////////////////////////
int DKEvent::scoped(duk_context* ctx)
{
	//TODO
	return false;
}


// Methods
//////////////////////////////////////////
int DKEvent::createEvent(duk_context* ctx) 
{
	//TODO
	return false;
}

///////////////////////////////////////////
int DKEvent::composedPath(duk_context* ctx)
{
	//TODO
	return false;
}

////////////////////////////////////////
int DKEvent::initEvent(duk_context* ctx)
{
	//TODO
	return false;
}

/////////////////////////////////////////////
int DKEvent::preventDefault(duk_context* ctx)
{
	//TODO
	return false;
}

///////////////////////////////////////////////////////
int DKEvent::stopImmediatePropagation(duk_context* ctx)
{
	//TODO
	return false;
}

//////////////////////////////////////////////
int DKEvent::stopPropagation(duk_context* ctx)
{
	//TODO
	return false;
}


// Obsolete methods
////////////////////////////////////////////////
int DKEvent::getPreventDefault(duk_context* ctx)
{
	//TODO
	return false;
}

////////////////////////////////////////////
int DKEvent::preventBubble(duk_context* ctx)
{
	//TODO
	return false;
}

/////////////////////////////////////////////
int DKEvent::preventCapture(duk_context* ctx)
{
	//TODO
	return false;
}

#endif //USE_DKDuktape