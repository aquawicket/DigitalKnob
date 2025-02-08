#pragma once
#ifndef dk_error_h
#define dk_error_h

#include "DK.h"


//################################################################################
//# dk_error(str)
//#
#include "dk_log.h"
int dk_error(const char* str){
	return dk_log(ERROR, str);
};


#endif //dk_error_h