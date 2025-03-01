#pragma once
#ifndef dk_debug_hpp
#define dk_debug_hpp

#include "DK.hpp"

//################################################################################
//# dk_debug(message)
//#
#include "dk_log.hpp"
int dk_debug(const char* message){
	return dk_log(DEBUG, message);
};

#endif //dk_debug_hpp