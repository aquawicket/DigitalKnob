#pragma once
#ifndef dk_debug_h
#define dk_debug_h

#include "DK.h"


//################################################################################
//# dk_debug(str)
//#
#include "dk_log.h"
int dk_debug(const char* str){
	return dk_log(DEBUG, str);
};


#endif //dk_debug_h