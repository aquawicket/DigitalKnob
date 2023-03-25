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

void DKEventTarget::addEventListener(const DKString& type, std::function<bool(DKEvent)> listener, void* pointer) {
	DKDEBUGFUNC(type, listener, pointer);
	Event event;
	event.type = type;
	event.listener = listener;
	event.pointer = pointer;
	events.push_back(event);
}

void DKEventTarget::removeEventListener(const DKString& type, std::function<bool(DKEvent)> listener, void* pointer) {
	DKDEBUGFUNC(type, listener, pointer);
}

void DKEventTarget::dispatchEvent(DKEvent event) {
	DKDEBUGFUNC(event);
	//DKINFO("event.type = "+event.type+"\n");
	
	for(unsigned int n=0; n<events.size(); ++n){
		/*
		DKINFO("events[n].type = "+events[n].type+"\n");
		if(event.type == events[n].type)
			DKINFO("type match \n");
		if(event.pointer == events[n].pointer)
			DKINFO("pointer match \n");
		*/
		if(event.type == events[n].type && event.pointer == events[n].pointer){
			//DKINFO("type and pointer match \n");
			events[n].listener(event);
		}
	}
}
