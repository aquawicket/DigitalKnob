#pragma once
#ifndef dk_fatal_h
#define dk_fatal_h

#include "DK.h"


//################################################################################
//# dk_fatal( const char * format, ... );
//#
#include "dk_log.h"
int dk_fatal(const char* format, ...) {
	va_list args;
    va_start(args, format);
	int exit_status = v_dk_log(FATAL, format, args);
    va_end(args);
    return exit_status;
};


#endif //dk_fatal_h