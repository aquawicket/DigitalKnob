#pragma once
#ifndef dk_error_hpp
#define dk_error_hpp

#include "DK.hpp"

//################################################################################
//# dk_warning(message)
//#
<<<<<<< HEAD
#include "dk_error_hpp.hpp"
void dk_error_hpp(const char* message){
	dk_log(ERROR, message);
=======
#include "dk_log.hpp"
int dk_error(const char* message){
	return dk_log(ERROR, message);
>>>>>>> Development
};

#endif //dk_warning_hpp