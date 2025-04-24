#pragma once
#ifndef dk_fatal_hpp
#define dk_fatal_hpp

#include "DK.hpp"

//################################################################################
//# dk_fatal(message)
//#
#include "dk_log.hpp"
<<<<<<< HEAD
void dk_fatal(const char* message){
	dk_log(FATAL, message);
=======
int dk_fatal(const char* message){
	return dk_log(FATAL, message);
>>>>>>> Development
};

#endif //dk_fatal_hpp