#include "DKTemplateEventTest/DKEventTarget.h"

AddEventListenerMap* DKEventTarget::addEventListenerMap = NULL;
RemoveEventListenerMap* DKEventTarget::removeEventListenerMap = NULL;
DispatchEventMap* DKEventTarget::dispatchEventMap = NULL;