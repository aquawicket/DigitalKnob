// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window
#pragma once
#ifndef TEST_Window_H
#define TEST_Window_H

//#include "DK/DK.h"
#include "DKWindow/DKWindow.h"


class TEST_Window : public DKObjectT<TEST_Window>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_Window.h //////\n");
		
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_Window, true);


#endif //TEST_Window_H