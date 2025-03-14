#pragma once
#ifndef dk_log_h
#define dk_log_h

#include "DK.h"
#include "dk_color.h"

#ifndef dk_log_ENABLE
	#define dk_log_ENABLE 1
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
#ifndef DEFAULT_ENABLED
	#define DEFAULT_ENABLED 1
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
#ifndef VERBOSE_ENABLED
	#define VERBOSE_ENABLED 1
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

// DEBUG
#ifndef DEBUG_ENABLED
	#define DEBUG_ENABLED 1
#endif	
#ifndef DEBUG_COLOR
	#define DEBUG_COLOR blue
#endif
#ifndef DEBUG_TAG
	#define DEBUG_TAG "DEBUG: "
#endif
#ifndef DEBUG_PAUSE
	#define DEBUG_PAUSE 0
#endif
#ifndef DEBUG_TRACE	
	#define DEBUG_TRACE 0
#endif
#ifndef DEBUG_LINE
	#define DEBUG_LINE 0
#endif
#ifndef DEBUG_HALT
	#define DEBUG_HALT 0
#endif

// INFO
#ifndef INFO_ENABLED
	#define INFO_ENABLED 1
#endif	
#ifndef INFO_COLOR
	#define INFO_COLOR white
#endif
#ifndef INFO_TAG
	#define INFO_TAG "INFO: "
#endif
#ifndef INFO_PAUSE
	#define INFO_PAUSE 0
#endif
#ifndef INFO_TRACE	
	#define INFO_TRACE 0
#endif
#ifndef INFO_LINE
	#define INFO_LINE 0
#endif
#ifndef INFO_HALT
	#define INFO_HALT 0
#endif

// SUCCESS
#ifndef SUCCESS_ENABLED
	#define SUCCESS_ENABLED 1
#endif	
#ifndef SUCCESS_COLOR
	#define SUCCESS_COLOR green
#endif
#ifndef SUCCESS_TAG
	#define SUCCESS_TAG "SUCCESS: "
#endif
#ifndef SUCCESS_PAUSE
	#define SUCCESS_PAUSE 0
#endif
#ifndef SUCCESS_TRACE	
	#define SUCCESS_TRACE 0
#endif
#ifndef SUCCESS_LINE
	#define SUCCESS_LINE 0
#endif
#ifndef SUCCESS_HALT
	#define SUCCESS_HALT 0
#endif

// TODO
#ifndef TODO_ENABLED
	#define TODO_ENABLED 1
#endif	
#ifndef TODO_COLOR
	#define TODO_COLOR lblue
#endif
#ifndef TODO_TAG
	#define TODO_TAG "TODO: "
#endif
#ifndef TODO_PAUSE
	#define TODO_PAUSE 1
#endif
#ifndef TODO_TRACE	
	#define TODO_TRACE 0
#endif
#ifndef TODO_LINE
	#define TODO_LINE 0
#endif
#ifndef TODO_HALT
	#define TODO_HALT 0
#endif

// NOTICE
#ifndef NOTICE_ENABLED
	#define NOTICE_ENABLED 1
#endif	
#ifndef NOTICE_COLOR
	#define NOTICE_COLOR lyellow
#endif
#ifndef NOTICE_TAG
	#define NOTICE_TAG "NOTICE: "
#endif
#ifndef NOTICE_PAUSE
	#define NOTICE_PAUSE 0
#endif
#ifndef NOTICE_TRACE	
	#define NOTICE_TRACE 0
#endif
#ifndef NOTICE_LINE
	#define NOTICE_LINE 0
#endif
#ifndef NOTICE_HALT
	#define NOTICE_HALT 0
#endif

// FIXME
#ifndef FIXME_ENABLED
	#define FIXME_ENABLED 1
#endif	
#ifndef FIXME_COLOR
	#define FIXME_COLOR lyellow
#endif
#ifndef FIXME_TAG
	#define FIXME_TAG "FIXME: "
#endif
#ifndef FIXME_PAUSE
	#define FIXME_PAUSE 1
#endif
#ifndef FIXME_TRACE	
	#define FIXME_TRACE 0
#endif
#ifndef FIXME_LINE
	#define FIXME_LINE 0
#endif
#ifndef FIXME_HALT
	#define FIXME_HALT 0
#endif

// WARNING
#ifndef WARNING_ENABLED
	#define WARNING_ENABLED 1;
#endif	
#ifndef WARNING_COLOR
	#define WARNING_COLOR yellow
#endif
#ifndef WARNING_TAG
	#define WARNING_TAG "WARNING: "
#endif
#ifndef WARNING_PAUSE
	#define WARNING_PAUSE 0
#endif
#ifndef WARNING_TRACE	
	#define WARNING_TRACE 0
#endif
#ifndef WARNING_LINE
	#define WARNING_LINE 0
#endif
#ifndef WARNING_HALT
	#define WARNING_HALT 0
#endif

// ERROR
#ifndef ERROR_ENABLED
	#define ERROR_ENABLED 1
#endif	
#ifndef ERROR_COLOR
	#define ERROR_COLOR lred
#endif
#ifndef ERROR_TAG
	#define ERROR_TAG "ERROR: "
#endif
#ifndef ERROR_PAUSE
	#define ERROR_PAUSE 1
#endif
#ifndef ERROR_TRACE	
	#define ERROR_TRACE 0
#endif
#ifndef ERROR_LINE
	#define ERROR_LINE 0
#endif
#ifndef ERROR_HALT
	#define ERROR_HALT 0
#endif

// FATAL
#ifndef FATAL_ENABLED
	#define FATAL_ENABLED 1
#endif	
#ifndef FATAL_COLOR
	#define FATAL_COLOR red
#endif
#ifndef FATAL_TAG
	#define FATAL_TAG "FATAL: "
#endif
#ifndef FATAL_PAUSE
	#define FATAL_PAUSE 1
#endif
#ifndef FATAL_TRACE	
	#define FATAL_TRACE 0
#endif
#ifndef FATAL_LINE
	#define FATAL_LINE 0
#endif
#ifndef FATAL_HALT
	#define FATAL_HALT 1
#endif


//################################################################################
//# dk_log(level, str)
//#
#include "dk_echo.h"
int v_dk_log(int level, const char* format, va_list args) {
		
	#if dk_log_ENABLE != 1
		return 1;
	#endif
	
	int level_enable  = DEFAULT_ENABLED;
	char* level_color = (char *)DEFAULT_COLOR;
	char* level_tag   = (char *)DEFAULT_TAG;
	int level_pause	  = DEFAULT_PAUSE;
	int level_trace   = DEFAULT_TRACE;
	int level_line    = DEFAULT_LINE;
	int level_halt    = DEFAULT_HALT;
	if(level == VERBOSE){
		level_enable  = VERBOSE_ENABLED;
		level_color   = (char *)VERBOSE_COLOR;
		level_tag     = (char *)VERBOSE_TAG;
		level_pause	  = VERBOSE_PAUSE;
		level_trace   = VERBOSE_TRACE;
		level_line    = VERBOSE_LINE;
		level_halt    = VERBOSE_HALT;
	}
	if(level == DEBUG){
		level_enable  = DEBUG_ENABLED;
		level_color   = (char *)DEBUG_COLOR;
		level_tag     = (char *)DEBUG_TAG;
		level_pause	  = DEBUG_PAUSE;
		level_trace   = DEBUG_TRACE;
		level_line    = DEBUG_LINE;
		level_halt    = DEBUG_HALT;
	}
	if(level == INFO){
		level_enable  = INFO_ENABLED;
		level_color   = (char *)INFO_COLOR;
		level_tag     = (char *)INFO_TAG;
		level_pause	  = INFO_PAUSE;
		level_trace   = INFO_TRACE;
		level_line    = INFO_LINE;
		level_halt    = INFO_HALT;
	}
	if(level == SUCCESS){
		level_enable  = SUCCESS_ENABLED;
		level_color   = (char *)SUCCESS_COLOR;
		level_tag     = (char *)SUCCESS_TAG;
		level_pause	  = SUCCESS_PAUSE;
		level_trace   = SUCCESS_TRACE;
		level_line    = SUCCESS_LINE;
		level_halt    = SUCCESS_HALT;
	}
	if(level == TODO){
		level_enable  = TODO_ENABLED;
		level_color   = (char *)TODO_COLOR;
		level_tag     = (char *)TODO_TAG;
		level_pause	  = TODO_PAUSE;
		level_trace   = TODO_TRACE;
		level_line    = TODO_LINE;
		level_halt    = TODO_HALT;
	}
	if(level == NOTICE){
		level_enable  = NOTICE_ENABLED;
		level_color   = (char *)NOTICE_COLOR;
		level_tag     = (char *)NOTICE_TAG;
		level_pause	  = NOTICE_PAUSE;
		level_trace   = NOTICE_TRACE;
		level_line    = NOTICE_LINE;
		level_halt    = NOTICE_HALT;
	}
	if(level == FIXME){
		level_enable  = FIXME_ENABLED;
		level_color   = (char *)FIXME_COLOR;
		level_tag     = (char *)FIXME_TAG;
		level_pause	  = FIXME_PAUSE;
		level_trace   = FIXME_TRACE;
		level_line    = FIXME_LINE;
		level_halt    = FIXME_HALT;
	}
	if(level == WARNING){
		level_enable  = WARNING_ENABLED;
		level_color   = (char *)WARNING_COLOR;
		level_tag     = (char *)WARNING_TAG;
		level_pause	  = WARNING_PAUSE;
		level_trace   = WARNING_TRACE;
		level_line    = WARNING_LINE;
		level_halt    = WARNING_HALT;
	}
	if(level == ERROR){
		level_enable  = ERROR_ENABLED;
		level_color   = (char *)ERROR_COLOR;
		level_tag     = (char *)ERROR_TAG;
		level_pause	  = ERROR_PAUSE;
		level_trace   = ERROR_TRACE;
		level_line    = ERROR_LINE;
		level_halt    = ERROR_HALT;
	}
	if(level == FATAL){
		level_enable  = FATAL_ENABLED;
		level_color   = (char *)FATAL_COLOR;
		level_tag     = (char *)FATAL_TAG;
		level_pause	  = FATAL_PAUSE;
		level_trace   = FATAL_TRACE;
		level_line    = FATAL_LINE;
		level_halt    = FATAL_HALT;
	}
	if(level_enable != 1)
		return 1;

	// Get the message string from variable args
//	va_list args;
//    va_start(args, format);
	char message[1028];
	vsprintf(message, format, args);
//	va_end(args);
	
	// Apply level color
	sprintf(message, "%s%s%s", level_color, message, clr);
	
	// Print message
	return printf("%s", message);
};

	
int dk_log(int level, const char* format, ...) {
	
	// Get the message string from variable args
	va_list args;
    va_start(args, format);
	int exit_status = v_dk_log(level, format, args);
	va_end(args);
	return exit_status;
}

#endif //dk_log_h