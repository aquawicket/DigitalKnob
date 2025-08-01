#pragma once
#ifndef dk_testReturn_h
#define dk_testReturn_h

#include "DK.h"
#include "dk_replaceAll.h"

char testReturn[256];
//################################################################################
//# dk_testReturn(input, output)
//#
char* dk_testReturn(char* input, char* output){
	//dk_debugFunc(1, 2);
	
	int retA = dk_replaceAll(input, "input", "output", testReturn);

	if(output){
		strcpy(output, testReturn);
	} else {
		dk_echo("%s\n", testReturn);
	}
	
	return testReturn;
};

#endif //dk_testReturn_h