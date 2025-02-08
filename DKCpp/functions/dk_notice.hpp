#pragma once
#ifndef dk_notice_hpp
#define dk_notice_hpp

#include "DK.hpp"

//################################################################################
//# dk_notice(message)
//#
#include "dk_log.hpp"
int dk_notice(const char* message){
	return dk_log(NOTICE, message);
};

#endif //dk_notice_hpp