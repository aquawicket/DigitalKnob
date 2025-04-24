#pragma once
#ifndef dk_success_h
#define dk_success_h

#include "DK.h"

//################################################################################
//# dk_success( const char * format, ... );
//#
#include "dk_log.h"
int dk_success(const char* format, ...) {
	va_list args;
    va_start(args, format);
	int exit_status = v_dk_log(SUCCESS, format, args);
    va_end(args);
    return exit_status;
};

#endif //dk_success_h