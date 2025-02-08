#pragma once
#ifndef dk_warning
#define dk_warning

#include "DK.h"


//################################################################################
//# dk_warning(str)
//#
#include "dk_log.h"
int dk_warning(const char* str){
	return dk_log(WARNING, str);
};


#endif //dk_warning