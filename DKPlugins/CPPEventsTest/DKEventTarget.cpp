#include "DK/stdafx.h"
#include "CPPEventsTest/DKEventTarget.h"


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

void DKEventTarget::addEventListener(/* type, listener */) {
	DKDEBUGFUNC();
}

void DKEventTarget::removeEventListener(/* type, listener */) {
	DKDEBUGFUNC();
}

void DKEventTarget::dispatchEvent(/* event */) {
	DKDEBUGFUNC();
}
