#pragma once
#ifndef TEST_Console_H
#define TEST_Console_H

#include "DK/DK.h"
#include "DKConsole/DKConsole.h"


class TEST_Console : public DKObjectT<TEST_Console>
{
public:
	bool Init(){
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}


};
REGISTER_OBJECT(TEST_Console, true);


#endif //TEST_Console_H