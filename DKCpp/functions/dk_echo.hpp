#pragma once
#ifndef dk_echo_hpp
#define dk_echo_hpp

#include "DK.hpp"


//################################################################################
//# dk_echo(message)
//#
#include <stdio.h>
#include <iostream>
void dk_echo(const std::string message){
	std::cout << message;
};


#endif //dk_echo_hpp