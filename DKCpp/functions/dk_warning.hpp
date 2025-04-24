#pragma once
#ifndef dk_warning_hpp
#define dk_warning_hpp

#include "DK.hpp"

//################################################################################
//# dk_warning(message)
//#
#include "dk_log.hpp"
<<<<<<< HEAD
void dk_warning(const char* message){
	dk_log(WARNING, message);
=======
int dk_warning(const char* message){
	return dk_log(WARNING, message);
>>>>>>> Development
};

#endif //dk_warning_hpp