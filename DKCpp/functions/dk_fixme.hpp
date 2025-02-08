#pragma once
#ifndef dk_fixme_hpp
#define dk_fixme_hpp

#include "DK.hpp"

//################################################################################
//# dk_verbose(message)
//#
#include "dk_log.hpp"
int dk_fixme(const char* message){
	return dk_log(FIXME, message);
};

#endif //dk_fixme_hpp