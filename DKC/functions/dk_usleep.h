#pragma once
#ifndef dk_usleep_h
#define dk_usleep_h

#include "DK.h"
#include <unistd.h>

//################################################################################
//# dk_usleep()
//#
//#		suspend execution for microsecond intervals
//#
//# 	 	      0.001 = 1 nanosecond
//#			      1 	= 1 microsecond
//#			   1000		= 1 millisecond
//# 	 	1000000 	= 1 second
//#		   60000000     = 1 minute
//# 	36000000000		= 1 hour
//#   8640000000000     = 1 day
//#
int dk_usleep(useconds_t useconds){
 	return usleep(useconds);
};

#endif //dk_usleep_h

