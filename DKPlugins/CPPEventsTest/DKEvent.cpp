#include "DK/stdafx.h"
#include "CPPEventsTest/DKEvent.h"


DKEvent::DKEvent(DKString _type, DKString _options, void* _pointer) {
	
	// TODO
	bubbles = false;
	cancelable = false;
	composed = false;
	//currentTarget = ?;
	defaultPrevented = false;
	eventPhase = 0;
	isTrusted = false;
	//target = ?;
	timeStamp = 0;
	type = _type;
	
	options = _options;
	pointer = _pointer;
}
