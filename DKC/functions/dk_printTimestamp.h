#pragma once
#ifndef dk_printTimestamp_h
#define dk_printTimestamp_h

#include "DK.h"
#include <sys/time.h>
#include <time.h>

//################################################################################
//# dk_printTimestamp()
//#
int dk_printTimestamp(){
	struct timeval timedata;
	gettimeofday(&timedata, NULL); 
	time_t curtime=timedata.tv_sec;
	char buffer[30];
	strftime(buffer, 30, "%m-%d-%Y  %T.", localtime(&curtime));
	dk_echo("\r%s%ld", buffer, timedata.tv_usec);
	fflush(stdout);
 	return 0;	
};

#endif //dk_printTimestamp_h

