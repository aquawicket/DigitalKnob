#pragma once
#ifndef dk_warning_hpp
#define dk_warning_hpp

#include "DK.hpp"

//################################################################################
//# dk_warning(message)
//#
#include "dk_log.hpp"
int dk_warning(const char* message){
	return dk_log(WARNING, message);
};

#endif //dk_warning_hpp