#pragma once
#ifndef dk_nanosleep_h
#define dk_nanosleep_h

// MSYS2 - requires -lpthread
#include "DK.h"
#include <time.h>

//################################################################################
//# dk_nanosleep()
//#
//#		high-resolution sleep
//#
int dk_nanosleep(long long nanoseconds){
	
	return nanosleep((const struct timespec[]){{0, nanoseconds}}, NULL);
};

#endif //dk_nanosleep_h

