#include "DK/stdafx.h"
#include "CPPEventsTest/DKEventTarget.h"


std::vector<Event> DKEventTarget::events;


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

