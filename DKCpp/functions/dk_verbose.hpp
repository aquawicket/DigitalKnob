#pragma once
#ifndef dk_verbose_hpp
#define dk_verbose_hpp

#include "DK.hpp"

//################################################################################
//# dk_verbose(message)
//#
#include "dk_log.hpp"
int dk_verbose(const char* message){
	return dk_log(FATAL, message);
};

#endif //dk_verbose_hpp