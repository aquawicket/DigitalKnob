#pragma once
#ifndef dk_success_hpp
#define dk_success_hpp

#include "DK.hpp"

//################################################################################
//# dk_notice(message)
//#
#include "dk_log.hpp"
int dk_success(const char* message){
	return dk_log(SUCCESS, message);
};

#endif //dk_success_hpp