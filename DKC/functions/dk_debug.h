#pragma once
#ifndef dk_debug_h
#define dk_debug_h

#include "DK.h"
#include "dk_log.h"

//################################################################################
//# dk_debug(message)
//#
#include <stdarg.h>
#include <stdio.h>
int v_dk_debug(const char* format, va_list args) {
	return v_dk_log(DEBUG, format, args);
}

int dk_debug(const char* format, ...) {
	va_list args;
    va_start(args, format);
	int exit_status = v_dk_log(DEBUG, format, args);
    va_end(args);
    return exit_status;
};


#endif //dk_debug_h