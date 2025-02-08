#pragma once
#ifndef dk_echo_hpp
#define dk_echo_hpp

#include "DK.hpp"


//################################################################################
//# dk_echo(message)
//#
#include <stdio.h>
#include <iostream>
int dk_echo(const std::string message){
	std::cout << message;
	return 0;
};


#endif //dk_echo_hpp