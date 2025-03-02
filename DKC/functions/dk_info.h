#pragma once
#ifndef dk_info_h
#define dk_info_h

#include "DK.h"
#include "dk_log.h"

//################################################################################
//# dk_info(message)
//#
#include <stdarg.h>
#include <stdio.h>
int v_dk_info(const char* format, va_list args) {
	return v_dk_log(INFO, format, args);
}

int dk_info(const char* format, ...) {
	va_list args;
    va_start(args, format);
	int exit_status = v_dk_log(INFO, format, args);
    va_end(args);
    return exit_status;
};


#endif //dk_info_h