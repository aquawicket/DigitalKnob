// [IDL] https://html.spec.whatwg.org/multipage/system-state.html#the-navigator-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Navigator
#pragma once
#ifndef TEST_Navigator_H
#define TEST_Navigator_H

#include "DKNavigator/DKNavigator.h"


class TEST_Navigator : public DKObjectT<TEST_Navigator>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_Navigator.h //////\n");
	
		DKNavigator navigator;
		printNavigatorProperties(navigator);
		return true;
	}

	static void printNavigatorProperties(DKNavigator& navigator){
		DKDEBUGFUNC(navigator);
		DKTODO();
	}
};
REGISTER_OBJECT(TEST_Navigator, true);


#endif //TEST_Navigator_H