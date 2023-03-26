#include "DK/stdafx.h"
#include "CPPEventsTest/DKEventTarget.h"


template <typename EventType>
std::vector<EventObject<EventType>> DKEventTarget::events;


bool DKEventTarget::Init(){
	DKDEBUGFUNC();
	DKINFO("DKEventTarget::Init() \n");
    return true;
}

bool DKEventTarget::End(){
	DKDEBUGFUNC();
	DKINFO("DKEventTarget::End() \n");
	return true;
}

