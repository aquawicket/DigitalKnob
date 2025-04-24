#pragma once
#ifndef dk_verbose_hpp
#define dk_verbose_hpp

#include "DK.hpp"

//################################################################################
//# dk_verbose(message)
//#
#include "dk_log.hpp"
<<<<<<< HEAD
void dk_verbose(const char* message){
	dk_log(FATAL, message);
=======
int dk_verbose(const char* message){
	return dk_log(VERBOSE, message);
>>>>>>> Development
};

#endif //dk_verbose_hpp