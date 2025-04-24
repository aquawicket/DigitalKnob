#pragma once
#ifndef dk_echo_h
#define dk_echo_h

#include "DK.h"

<<<<<<< HEAD

//################################################################################
//# dk_echo(message)
//#
#include <stdio.h>
void dk_echo(const char* message){
	printf("%s\n", message);
=======
//################################################################################
//# dk_echo(message)
//#
#include <stdarg.h>
#include <stdio.h>
int v_dk_echo(const char* format, va_list args) {
	return vprintf(format, args);
}

int dk_echo(const char* format, ...) {
	va_list args;
    va_start(args, format);
	int exit_status = vprintf(format, args);
    va_end(args);
    return exit_status;
>>>>>>> Development
};


#endif //dk_echo_h