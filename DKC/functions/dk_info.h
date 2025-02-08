#pragma once
#ifndef dk_info_h
#define dk_info_h

#include "DK.h"


//################################################################################
//# dk_info(str)
//#
#include "dk_log.h"
int dk_info(const char* str){
	return dk_log(INFO, str);
};


#endif //dk_info_h