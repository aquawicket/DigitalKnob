#pragma once
#ifndef dk_success_h
#define dk_success_h

#include "DK.h"


//################################################################################
//# dk_success(str)
//#
#include "dk_log.h"
int dk_success(const char* str){
	return dk_log(SUCCESS, str);
};


#endif //dk_success_h