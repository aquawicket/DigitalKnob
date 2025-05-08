#pragma once
#ifndef dk_toLower_hpp
#define dk_toLower_hpp

#include "DK.hpp"
#include "dk_echo.hpp"
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


#endif //dk_toLower_hpp