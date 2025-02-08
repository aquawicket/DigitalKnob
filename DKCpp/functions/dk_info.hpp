#pragma once
#ifndef dk_info_hpp
#define dk_info_hpp

#include "DK.hpp"

//################################################################################
//# dk_info(message)
//#
#include "dk_log.hpp"
int dk_info(const char* message){
	return dk_log(INFO, message);
};

#endif //dk_info_hpp