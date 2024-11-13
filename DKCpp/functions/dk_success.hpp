#pragma once
#ifndef dk_success_hpp
#define dk_success_hpp

#include "DK.hpp"

//################################################################################
//# dk_notice(message)
//#
#include "dk_log.hpp"
void dk_success(const char* message){
	dk_log(SUCCESS, message);
};

#endif //dk_success_hpp