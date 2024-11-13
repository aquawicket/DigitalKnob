#pragma once
#ifndef dk_verbose_hpp
#define dk_verbose_hpp

#include "DK.hpp"

//################################################################################
//# dk_verbose(message)
//#
#include "dk_log.hpp"
void dk_verbose(const char* message){
	dk_log(FATAL, message);
};

#endif //dk_verbose_hpp