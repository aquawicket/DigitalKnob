#pragma once
#ifndef dk_fatal_hpp
#define dk_fatal_hpp

#include "DK.hpp"

//################################################################################
//# dk_fatal(message)
//#
#include "dk_log.hpp"
int dk_fatal(const char* message){
	return dk_log(FATAL, message);
};

#endif //dk_fatal_hpp