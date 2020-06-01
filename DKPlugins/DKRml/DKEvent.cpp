//https://developer.mozilla.org/en-US/docs/Web/API/Event

#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKEvent.h"


////////////////////
bool DKEvent::Init()
{
	DKDEBUGFUNC();

	//Properties
	DKDuktape::AttachFunction("DKEvent_bubbles", DKEvent::bubbles);

	//Methods
	DKDuktape::AttachFunction("DKEvent_createEvent", DKEvent::createEvent);

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


//Properties
//////////////////////////////////////
int DKEvent::bubbles(duk_context* ctx)
{
	//TODO
	return false;
}


//Methods
//////////////////////////////////////////
int DKEvent::createEvent(duk_context* ctx) 
{
	//TODO
	return false;
}

#endif //USE_DKDuktape