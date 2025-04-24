#pragma once
#ifndef dk_fixme_hpp
#define dk_fixme_hpp

#include "DK.hpp"

//################################################################################
//# dk_verbose(message)
//#
#include "dk_log.hpp"
<<<<<<< HEAD
void dk_fixme(const char* message){
	dk_log(FIXME, message);
=======
int dk_fixme(const char* message){
	return dk_log(FIXME, message);
>>>>>>> Development
};

#endif //dk_fixme_hpp