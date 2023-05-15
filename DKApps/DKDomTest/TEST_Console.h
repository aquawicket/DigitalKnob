// [IDL] https://console.spec.whatwg.org/#console-namespace
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console
#pragma once
#ifndef TEST_Console_H
#define TEST_Console_H

#include "DKConsole/DKConsole.h"


class TEST_Console : public DKObjectT<TEST_Console>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_Console.h //////\n");
		
		//undefined assert(optional boolean condition = false, any... data);
		//DKString assert_string = "assert test \n";
		DKConsole::_assert("assert test \n");


		return true;
	}
	
};
REGISTER_OBJECT(TEST_Console, true);


#endif //TEST_Console_H