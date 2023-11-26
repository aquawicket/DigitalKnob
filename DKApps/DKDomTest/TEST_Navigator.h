// [IDL] https://html.spec.whatwg.org/multipage/system-state.html#the-navigator-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Navigator
#pragma once
#ifndef TEST_Navigator_H
#define TEST_Navigator_H

#include "DKNavigator/DKNavigator.h"


class TEST_Navigator //: public DKObjectT<TEST_Navigator>
{
public:
	TEST_Navigator(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_Navigator.h //////");
	
		DKNavigator navigator;
		printNavigatorProperties(navigator);
	}

	static void printNavigatorProperties(DKNavigator& navigator){
		DKDEBUGFUNC(navigator);
		
		console.log("navigator = "	+toString(navigator));
	}
};
//REGISTER_OBJECT(TEST_Navigator, true);


#endif //TEST_Navigator_H