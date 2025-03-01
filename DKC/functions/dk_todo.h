#pragma once
#ifndef dk_todo_h
#define dk_todo_h

#include "DK.h"

//################################################################################
//# dk_todo( const char * format, ... );
//#
#include "dk_log.h"
int dk_todo(const char* format, ...) {
	va_list args;
    va_start(args, format);
	int exit_status = v_dk_log(TODO, format, args);
    va_end(args);
    return exit_status;
};

#endif //dk_todo_h