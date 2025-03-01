#pragma once
#ifndef dk_warning_h
#define dk_warning_h

#include "DK.h"

//################################################################################
//# dk_warning( const char * format, ... );
//#
#include "dk_log.h"
int dk_warning(const char* format, ...) {
	va_list args;
    va_start(args, format);
	int exit_status = v_dk_log(WARNING, format, args);
    va_end(args);
    return exit_status;
};

#endif //dk_warning_h