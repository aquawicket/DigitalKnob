#pragma once
#ifndef dk_log_hpp
#define dk_log_hpp

#include "DK.hpp"
#include "dk_color.hpp"

#ifndef ENABLE_dk_log
	#define ENABLE_dk_log 1
#endif

//  0 VERBOSE    dk_verbose
//  1 DEBUG      dk_debug
//  2 INFO       dk_info
//  3 SUCCESS    dk_success
//  4 TODO       dk_todo
//  5 NOTICE     dk_notice
//  6 FIXME      dk_fixme
//  7 WARNING    dk_warning
//  8 ERROR      dk_error
//  9 FATAL      dk_fatal

#define VERBOSE 0
#define DEBUG 1
#define INFO 2
#define SUCCESS 3
#define TODO 4
#define NOTICE 5
#define FIXME 6
#define WARNING 7
#define ERROR 8
#define FATAL 9

// DEFAULT
#ifndef DEFAULT_ENABLE
	#define DEFAULT_ENABLE 1
#endif	
#ifndef DEFAULT_COLOR
	#define DEFAULT_COLOR white
#endif
#ifndef DEFAULT_TAG
	#define DEFAULT_TAG ""
#endif
#ifndef DEFAULT_PAUSE
	#define DEFAULT_PAUSE 0
#endif
#ifndef DEFAULT_TRACE	
	#define DEFAULT_TRACE 0
#endif
#ifndef DEFAULT_LINE
	#define DEFAULT_LINE 0
#endif
#ifndef DEFAULT_HALT
	#define DEFAULT_HALT 0
#endif

// VERBOSE
#ifndef VERBOSE_ENABLE
	#define VERBOSE_ENABLE 1
#endif	
#ifndef VERBOSE_COLOR
	#define VERBOSE_COLOR magenta
#endif
#ifndef VERBOSE_TAG
	#define VERBOSE_TAG "VERBOSE: "
#endif
#ifndef VERBOSE_PAUSE
	#define VERBOSE_PAUSE 0
#endif
#ifndef VERBOSE_TRACE	
	#define VERBOSE_TRACE 0
#endif
#ifndef VERBOSE_LINE
	#define VERBOSE_LINE 0
#endif
#ifndef VERBOSE_HALT
	#define VERBOSE_HALT 0
#endif

//################################################################################
//# dk_log(level, message)
//#
#include "dk_echo.hpp"
void dk_log(int level, const char* message)
{
	#if ENABLE_dk_log != 1
		return;
	#endif
	
	int level_enable  = DEFAULT_ENABLE;
	char* level_color = (char *)DEFAULT_COLOR;
	char* level_tag   = (char *)DEFAULT_TAG;
	int level_pause	  = DEFAULT_PAUSE;
	int level_trace   = DEFAULT_TRACE;
	int level_line    = DEFAULT_LINE;
	int level_halt    = DEFAULT_HALT;
	
	if(level == VERBOSE){
		level_enable  = VERBOSE_ENABLE;
		level_color   = (char *)VERBOSE_COLOR;
		level_tag     = (char *)VERBOSE_TAG;
		level_pause	  = VERBOSE_PAUSE;
		level_trace   = VERBOSE_TRACE;
		level_line    = VERBOSE_LINE;
		level_halt    = VERBOSE_HALT;
	}

	printf("%s", level_color);
	dk_echo(message);
	printf("%s", clr);
};


#endif //dk_log_hpp