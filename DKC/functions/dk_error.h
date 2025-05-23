#pragma once
#ifndef dk_error_h
#define dk_error_h

#include "DK.h"
#include "dk_log.h"

//################################################################################
//# dk_error( const char * format, ... );
//#
int dk_error(const char* format, ...) {
	va_list args;
    va_start(args, format);
	int exit_status = v_dk_log(ERROR, format, args);
    va_end(args);
    return exit_status;
};


#endif //dk_error_h