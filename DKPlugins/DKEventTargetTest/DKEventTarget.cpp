#include "DKEventTargetTest/DKEventTarget.h"

std::vector<EventObject> DKEventTarget::events;
/*
AddEventListenerMap* DKEventTarget::addEventListenerMap = NULL;
RemoveEventListenerMap* DKEventTarget::removeEventListenerMap = NULL;
DispatchEventMap* DKEventTarget::dispatchEventMap = NULL;
*/

DKEventTarget::DKEventTarget() {
	DKString address = DKDuktape::pointerToAddress(this);
	DKINFO("DKEventTarget::DKEventTarget("+address+")\n");
}
