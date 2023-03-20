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

void DKEventTarget::addEventListener(const DKString& type/*, listener */) {
	DKDEBUGFUNC(type);
}

void DKEventTarget::removeEventListener(const DKString& type/*, listener */) {
	DKDEBUGFUNC(type);
}

void DKEventTarget::dispatchEvent(/* event */) {
	DKDEBUGFUNC();
}
