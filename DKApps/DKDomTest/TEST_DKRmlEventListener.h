// [IDL] https://dom.spec.whatwg.org/#callbackdef-eventlistener
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventListener
#pragma once
#ifndef TEST_DKRmlEventListener_H
#define TEST_DKRmlEventListener_H

#include "DKRmlEventTarget/DKRmlEventTarget.h"


class TEST_DKRmlEventListener //: public DKObjectT<TEST_DKRmlEventListener>
{
public:
	DKRmlEventListener* _dkRmlEventListener;

	TEST_DKRmlEventListener() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlEventListener.h //////");
		
		_dkRmlEventTarget = new DKRmlEventTarget(TEST_DKRmlEventListener::_eventListner, NULL);
		
		printDKRmlEventListenerProperties(*_dkRmlEventListener);
	}
	
	~TEST_DKRmlEventListener() {
		delete _dkRmlEventListener;
	}
	
	static void printDKRmlEventListenerProperties(DKRmlEventListener& dkRmlEventListener){
		DKDEBUGFUNC(dkRmlEventListener);
		
		console.log("dkRmlEventListener = "				+toString(dkRmlEventListener));
	}

};
//REGISTER_OBJECT(TEST_DKRmlEventListener, true);


#endif //TEST_DKRmlEventListener_H