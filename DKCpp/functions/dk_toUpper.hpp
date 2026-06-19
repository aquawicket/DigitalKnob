#pragma once
#ifndef dk_toUpper_hpp
#define dk_toUpper_hpp

#include "DK.hpp"
#include "dk_echo.hpp"
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


#endif //dk_toUpper_hpp