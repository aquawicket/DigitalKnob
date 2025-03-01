#pragma once
#ifndef dk_info_h
#define dk_info_h

#include "DK.h"


//################################################################################
//# dk_info( const char * format, ... );
//#
#include "dk_log.h"
int dk_info(const char* format, ...) {
	va_list args;
    va_start(args, format);
	int exit_status = v_dk_log(INFO, format, args);
    va_end(args);
    return exit_status;
};


#endif //dk_info_h