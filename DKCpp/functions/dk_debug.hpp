#pragma once
#ifndef dk_debug_hpp
#define dk_debug_hpp

#include "DK.hpp"

<<<<<<< HEAD
//################################################################################
//# dk_debug(message)
//#
#include "dk_log.hpp"
void dk_debug(const char* message){
	dk_log(DEBUG, message);
};

#endif //dk_debug_hpp
=======

//################################################################################
//# dk_debug( const char * format, ... );
//#
#include "dk_log.hpp"
int dk_debug(const char* format, ...){
	va_list args;
    va_start(args, format);
	int exit_status = v_dk_log(DEBUG, format, args);
    va_end(args);
    return exit_status;
};


#endif //dk_debug_h
>>>>>>> Development
