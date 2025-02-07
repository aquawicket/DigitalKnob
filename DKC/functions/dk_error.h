#pragma once
#ifndef dk_error_h
#define dk_error_h

#include "DK.h"


//################################################################################
//# dk_error(message)
//#
#include "dk_log.h"
int dk_error(const char* message){
	return dk_log(ERROR, message);
};


#endif //dk_error_h