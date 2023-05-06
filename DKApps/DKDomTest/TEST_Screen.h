// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Screen.idl
// [SOURCE] https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen
#pragma once
#ifndef TEST_Screen_H
#define TEST_Screen_H

#include "DK/DK.h"
#include "DKScreen/DKScreen.h"


class TEST_Screen : public DKObjectT<TEST_Screen>
{
public:
	bool Init(){
		DKINFO("////// TEST_Screen.h ////// \n");
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_Screen, true);


#endif //TEST_Screen_H