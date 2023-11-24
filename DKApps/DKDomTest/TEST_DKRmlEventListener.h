// [IDL] https://dom.spec.whatwg.org/#callbackdef-eventlistener
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventListener
#pragma once
#ifndef TEST_DKRmlEventListener_H
#define TEST_DKRmlEventListener_H

#include "DKRmlEventListener/DKRmlEventListener.h"


class TEST_DKRmlEventListener //: public DKObjectT<TEST_DKRmlEventListener>
{
public:
	static DKRmlEventListener* _dkRmlEventListener;

	TEST_DKRmlEventListener() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlEventListener.h //////");
		
		_dkRmlEventListener = new DKRmlEventListener();
		
		printDKRmlEventListenerProperties(*_dkRmlEventListener);
	}
	
	~TEST_DKRmlEventListener() {
		delete _dkRmlEventListener;
	}
	
	static void printDKRmlEventListenerProperties(DKRmlEventListener& dkRmlEventListener){
		DKDEBUGFUNC(dkRmlEventListener);
		
		console.log("dkRmlEventListener = "		+toString(dkRmlEventListener));
	}

};
//REGISTER_OBJECT(TEST_DKRmlEventListener, true);

DKRmlEventListener* TEST_DKRmlEventListener::_dkRmlEventListener = NULL;

#endif //TEST_DKRmlEventListener_H