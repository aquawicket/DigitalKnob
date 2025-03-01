#pragma once
#ifndef dk_echoB_h
#define dk_echoB_h

#include "DK.h"

//################################################################################
//# dk_echoB(message)
//#
#include <stdarg.h>
#include <stdio.h>
#include "dk_echo.h"
int v_dk_echoB(const char* format, va_list args) {
	return v_dk_echo(format, args);
}

int dk_echoB(const char* format, ...) {
	va_list args;
    va_start(args, format);
    int exit_status = v_dk_echoB(format, args);
    va_end(args);
    return exit_status;
};


#endif //dk_echo_h