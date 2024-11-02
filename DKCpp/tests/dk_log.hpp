#pragma once
#ifndef dk_log_hpp
#define dk_log_hpp

#include "DK.hpp"


//################################################################################
//# dk_log(message)
//#
#include "dk_echo.hpp"
void dk_log(const char* message){
	dk_echo(message);
};


#endif //dk_log_hpp