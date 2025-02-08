#pragma once
#ifndef dk_verbose_h
#define dk_verbose_h

#include "DK.h"


//################################################################################
//# dk_verbose(str)
//#
#include "dk_log.h"
int dk_verbose(const char* str){
	return dk_log(VERBOSE, str);
};


#endif //dk_verbose_h