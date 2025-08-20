#pragma once
#ifndef dk_testReturn_h
#define dk_testReturn_h

#include "DK.h"
#include "dk_replaceAll.h"

char _dk_testReturn[256];
//################################################################################
//# dk_testReturn(input, output)
//#
char* dk_testReturn(char* input, char* output){
	//dk_debugFunc(1, 2);
	
	exit_status = dk_replaceAll(input, "input", "output", _dk_testReturn);

	if(output){
		strcpy(output, _dk_testReturn);
	} else {
		dk_echo("%s\n", _dk_testReturn);
	}
	
	return _dk_testReturn;
};

#endif //dk_testReturn_h