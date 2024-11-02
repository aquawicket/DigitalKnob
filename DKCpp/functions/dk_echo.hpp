#pragma once
#ifndef dk_echo_hpp
#define dk_echo_hpp

#include "DK.hpp"


//################################################################################
//# dk_echo(message)
//#
#include <stdio.h>
void dk_echo(const char* message){
	printf("%s\n", message);
};


#endif //dk_echo_hpp