#pragma once
#ifndef dk_debug_h
#define dk_debug_h

#include "DK.h"


//################################################################################
//# dk_debug( const char * format, ... );
//#
#include "dk_log.h"
int dk_debug(const char* format, ...) {
	va_list args;
    va_start(args, format);
	int exit_status = v_dk_log(DEBUG, format, args);
    va_end(args);
    return exit_status;
};


#endif //dk_debug_h