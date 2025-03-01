#pragma once
#ifndef dk_notice_h
#define dk_notice_h

#include "DK.h"

//################################################################################
//# dk_notice( const char * format, ... );
//#
#include "dk_log.h"
int dk_notice(const char* format, ...) {
	va_list args;
    va_start(args, format);
	int exit_status = v_dk_log(NOTICE, format, args);
    va_end(args);
    return exit_status;
};

#endif //dk_notice_h