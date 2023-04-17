// [W3C] https://console.spec.whatwg.org/
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console

#pragma once
#ifndef TEST_Console_H
#define TEST_Console_H

#include "DK/DK.h"
//#include "DKConsole/DKConsole.h"	// TODO


class TEST_Console : public DKObjectT<TEST_Console>
{
public:
	bool Init(){
		DKINFO("////// TEST_Console.h ////// \n");
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_Console, true);


#endif //TEST_Console_H