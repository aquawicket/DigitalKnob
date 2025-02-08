#pragma once
#ifndef dk_fatal_h
#define dk_fatal_h

#include "DK.h"


//################################################################################
//# dk_fatal(str)
//#
#include "dk_log.h"
int dk_fatal(const char* str){
	return dk_log(FATAL, str);
};


#endif //dk_fatal_h