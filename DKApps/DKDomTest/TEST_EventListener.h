// [IDL] https://dom.spec.whatwg.org/#callbackdef-eventlistener
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventListener
#pragma once
#ifndef TEST_EventListener_H
#define TEST_EventListener_H

#include "DKEventListener/DKEventListener.h"


class TEST_EventListener //: public DKObjectT<TEST_EventListener>
{
public:
	DKEventListener* _eventListener;

	TEST_EventListener() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_EventListener.h //////");
		
		_eventListener = new DKEventListener();
		
		printEventListenerProperties(*_eventListener);
	}
	
	~TEST_EventListener() {
		delete _eventListener;
	}
	
	static void printEventListenerProperties(DKEventListener& eventListener){
		DKDEBUGFUNC(eventListener);
		
		console.log("eventListener = "				+toString(eventListener));
	}

};
//REGISTER_OBJECT(TEST_EventListener, true);


#endif //TEST_EventListener_H