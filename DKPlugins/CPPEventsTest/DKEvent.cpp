#include "DK/stdafx.h"
#include "CPPEventsTest/DKEvent.h"


DKEvent::DKEvent(DKString _type, DKString _options, void* _pointer){
	type = _type;
	options = _options;
	pointer = _pointer;
}
