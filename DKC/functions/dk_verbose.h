#pragma once
#ifndef dk_verbose_h
#define dk_verbose_h

#include "DK.h"

//################################################################################
//# dk_verbose( const char * format, ... );
//#
#include "dk_log.h"
int dk_verbose(const char* format, ...) {
	va_list args;
    va_start(args, format);
	int exit_status = v_dk_log(VERBOSE, format, args);
    va_end(args);
    return exit_status;
};

#endif //dk_verbose_h
