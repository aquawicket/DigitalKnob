#pragma once
#ifndef dk_info_h
#define dk_info_h

#include "DK.h"


//################################################################################
//# dk_info(message)
//#
#include "dk_log.h"
void dk_info(const char* message){
	dk_log(INFO, message);
};


#endif //dk_info_h