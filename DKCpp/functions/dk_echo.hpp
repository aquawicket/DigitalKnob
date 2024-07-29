#pragma once
#ifndef dk_echo_hpp
#define dk_echo_hpp

#include "DK.hpp"
#include <stdio.h>

//################################################################################
//# dk_echo(message)
//#
//#
//void dk_echo(const char* message);
void dk_echo(const char* message){
	printf("%s\n", message);
}


#endif //dk_echo_hpp