#pragma once
#ifndef dk_error_hpp
#define dk_error_hpp

#include "DK.hpp"

//################################################################################
//# dk_warning(message)
//#
#include "dk_log.hpp"
void dk_error(const char* message){
	dk_log(ERROR, message);
};

#endif //dk_warning_hpp