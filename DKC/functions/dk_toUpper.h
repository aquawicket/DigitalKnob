#pragma once
#ifndef dk_toUpper_h
#define dk_toUpper_h

#include "DK.h"
#include "dk_echo.h"
#include <ctype.h>
#include <stdio.h>

//################################################################################
//# dk_toUpper(str)
//#
int dk_toUpper(char* str){
	
	for (int i = 0; str[i]; i++) {
		str[i] = toupper(str[i]);
	}
	return 0;
};


#endif //dk_toUpper_h