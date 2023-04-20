#pragma once
#ifndef TEST_Navigator_H
#define TEST_Navigator_H

#include "DK/DK.h"
#include "DKNavigator/DKNavigator.h"


// [IDL] https://html.spec.whatwg.org/multipage/system-state.html#the-navigator-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Navigator
class TEST_Navigator : public DKObjectT<TEST_Navigator>
{
public:
	bool Init(){
		DKINFO("////// TEST_Navigator.h ////// \n");
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_Navigator, true);


#endif //TEST_Navigator_H