#pragma once
#ifndef dk_echo_hpp
#define dk_echo_hpp

#include "DK.hpp"

<<<<<<< HEAD

//################################################################################
//# dk_echo(message)
//#
#include <stdio.h>
#include <iostream>
void dk_echo(const std::string message){
	std::cout << message;
=======
//################################################################################
//# dk_echo(message)
//#
#include <stdarg.h>
#include <stdio.h>
int dk_echo(const char* format, ...){
	va_list args;
    va_start(args, format);
	int exit_status = vprintf(format, args);
    va_end(args);
    return exit_status;
>>>>>>> Development
};


#endif //dk_echo_hpp