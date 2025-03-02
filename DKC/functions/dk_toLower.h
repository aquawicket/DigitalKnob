#pragma once
#ifndef dk_toLower_h
#define dk_toLower_h

#include "DK.h"
#include "dk_echo.h"
#include <ctype.h>
#include <stdio.h>

//################################################################################
//# dk_toLower(str)
//#
int dk_toLower(char* str){
	
	for (int i = 0; str[i]; i++) {
		str[i] = tolower(str[i]);
	}
	return 0;
};


#endif //dk_toLower_h