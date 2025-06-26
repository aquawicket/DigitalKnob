#pragma once
#ifndef dk_sleep_h
#define dk_sleep_h

#include "DK.h"
#include <unistd.h>

//################################################################################
//# dk_sleep()
//#
//#		suspend execution for second intervals
//#
//# 	 	 0.0000000001	= 1 nanosecond
//#			 0.0000001 		= 1 microsecond
//#			 0.001			= 1 millisecond
//# 	 	 1 				= 1 second
//#		    60 				= 1 minute
//# 	  3600				= 1 hour
//#      86400				= 1 day
//#
int dk_sleep(unsigned seconds){
	return sleep(seconds);
};

#endif //dk_sleep_h

