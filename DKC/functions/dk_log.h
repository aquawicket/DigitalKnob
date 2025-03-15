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
//  8 DEPRECATED dk_deprecated
//  9 ERROR      dk_error
// 10 FATAL      dk_fatal

#define VERBOSE 0
#define DEBUG 1
#define INFO 2
#define SUCCESS 3
#define TODO 4
#define NOTICE 5
#define FIXME 6
#define WARNING 7
#define DEPRECATED 8
#define ERROR 9
#define FATAL 10

// VERBOSE
#ifndef VERBOSE_ENABLED
	#define VERBOSE_ENABLED 1
#endif	
#ifndef dk_log_VERBOSE_COLOR
	#define dk_log_VERBOSE_COLOR magenta
#endif
#ifndef dk_log_VERBOSE_TAG
	#define dk_log_VERBOSE_TAG "VERBOSE: "
#endif
#ifndef dk_log_VERBOSE_TRACE	
	#define dk_log_VERBOSE_TRACE 0
#endif
#ifndef dk_log_VERBOSE_LINE
	#define dk_log_VERBOSE_LINE 0
#endif
#ifndef dk_log_VERBOSE_SOUND
	#define dk_log_VERBOSE_SOUND 0
#endif
#ifndef dk_log_VERBOSE_PAUSE
	#define dk_log_VERBOSE_PAUSE 0
#endif
#ifndef dk_log_VERBOSE_TIMEOUT
	#define dk_log_VERBOSE_TIMEOUT 0
#endif
#ifndef dk_log_VERBOSE_HALT
	#define dk_log_VERBOSE_HALT 0
#endif

// DEFAULT
#ifndef dk_log_DEFAULT_ENABLED
	#define dk_log_DEFAULT_ENABLED 1
#endif	
#ifndef dk_log_DEFAULT_COLOR
	#define dk_log_DEFAULT_COLOR white
#endif
#ifndef dk_log_DEFAULT_TAG
	#define dk_log_DEFAULT_TAG ""
#endif
#ifndef dk_log_DEFAULT_TRACE	
	#define dk_log_DEFAULT_TRACE 0
#endif
#ifndef dk_log_DEFAULT_LINE
	#define dk_log_DEFAULT_LINE 0
#endif
#ifndef dk_log_DEFAULT_SOUND
	#define dk_log_DEFAULT_SOUND 0
#endif
#ifndef dk_log_DEFAULT_PAUSE
	#define dk_log_DEFAULT_PAUSE 0
#endif
#ifndef dk_log_DEFAULT_TIMEOUT
	#define dk_log_DEFAULT_TIMEOUT 0
#endif
#ifndef dk_log_DEFAULT_HALT
	#define dk_log_DEFAULT_HALT 0
#endif

// DEBUG
#ifndef DEBUG_ENABLED
	#define DEBUG_ENABLED 1
#endif	
#ifndef dk_log_DEBUG_COLOR
	#define dk_log_DEBUG_COLOR blue
#endif
#ifndef dk_log_DEBUG_TAG
	#define dk_log_DEBUG_TAG "DEBUG: "
#endif
#ifndef dk_log_DEBUG_TRACE	
	#define dk_log_DEBUG_TRACE 0
#endif
#ifndef dk_log_DEBUG_LINE
	#define dk_log_DEBUG_LINE 0
#endif
#ifndef dk_log_DEBUG_PAUSE
	#define dk_log_DEBUG_PAUSE 0
#endif
#ifndef dk_log_DEBUG_HALT
	#define dk_log_DEBUG_HALT 0
#endif

// INFO
#ifndef INFO_ENABLED
	#define INFO_ENABLED 1
#endif	
#ifndef dk_log_INFO_COLOR
	#define dk_log_INFO_COLOR white
#endif
#ifndef dk_log_INFO_TAG
	#define dk_log_INFO_TAG "INFO: "
#endif
#ifndef dk_log_INFO_TRACE	
	#define dk_log_INFO_TRACE 0
#endif
#ifndef dk_log_INFO_LINE
	#define dk_log_INFO_LINE 0
#endif
#ifndef dk_log_INFO_PAUSE
	#define dk_log_INFO_PAUSE 0
#endif
#ifndef dk_log_INFO_HALT
	#define dk_log_INFO_HALT 0
#endif

// SUCCESS
#ifndef dk_log_SUCCESS_ENABLED
	#define dk_log_SUCCESS_ENABLED 1
#endif	
#ifndef dk_log_SUCCESS_COLOR
	#define dk_log_SUCCESS_COLOR green
#endif
#ifndef dk_log_SUCCESS_TAG
	#define dk_log_SUCCESS_TAG "SUCCESS: "
#endif
#ifndef dk_log_SUCCESS_TRACE	
	#define dk_log_SUCCESS_TRACE 0
#endif
#ifndef dk_log_SUCCESS_LINE
	#define dk_log_SUCCESS_LINE 0
#endif
#ifndef dk_log_SUCCESS_PAUSE
	#define dk_log_SUCCESS_PAUSE 0
#endif
#ifndef dk_log_SUCCESS_HALT
	#define dk_log_SUCCESS_HALT 0
#endif

// TODO
#ifndef dk_log_TODO_ENABLED
	#define dk_log_TODO_ENABLED 1
#endif	
#ifndef dk_log_TODO_COLOR
	#define dk_log_TODO_COLOR lblue
#endif
#ifndef dk_log_TODO_TAG
	#define dk_log_TODO_TAG "TODO: "
#endif
#ifndef dk_log_TODO_TRACE	
	#define dk_log_TODO_TRACE 0
#endif
#ifndef dk_log_TODO_LINE
	#define dk_log_TODO_LINE 0
#endif
#ifndef dk_log_TODO_PAUSE
	#define dk_log_TODO_PAUSE 1
#endif
#ifndef dk_log_TODO_HALT
	#define dk_log_TODO_HALT 0
#endif

// NOTICE
#ifndef dk_log_NOTICE_ENABLED
	#define dk_log_NOTICE_ENABLED 1
#endif	
#ifndef dk_log_NOTICE_COLOR
	#define dk_log_NOTICE_COLOR lyellow
#endif
#ifndef dk_log_NOTICE_TAG
	#define dk_log_NOTICE_TAG "NOTICE: "
#endif
#ifndef dk_log_NOTICE_TRACE	
	#define dk_log_NOTICE_TRACE 0
#endif
#ifndef dk_log_NOTICE_LINE
	#define dk_log_NOTICE_LINE 0
#endif
#ifndef dk_log_NOTICE_PAUSE
	#define dk_log_NOTICE_PAUSE 0
#endif
#ifndef dk_log_NOTICE_HALT
	#define dk_log_NOTICE_HALT 0
#endif

// FIXME
#ifndef dk_log_FIXME_ENABLED
	#define dk_log_FIXME_ENABLED 1
#endif	
#ifndef dk_log_FIXME_COLOR
	#define dk_log_FIXME_COLOR lyellow
#endif
#ifndef dk_log_FIXME_TAG
	#define dk_log_FIXME_TAG "FIXME: "
#endif
#ifndef dk_log_FIXME_TRACE	
	#define dk_log_FIXME_TRACE 0
#endif
#ifndef dk_log_FIXME_LINE
	#define dk_log_FIXME_LINE 0
#endif
#ifndef dk_log_FIXME_PAUSE
	#define dk_log_FIXME_PAUSE 1
#endif
#ifndef dk_log_FIXME_HALT
	#define dk_log_FIXME_HALT 0
#endif

// WARNING
#ifndef dk_log_WARNING_ENABLED
	#define dk_log_WARNING_ENABLED 1;
#endif	
#ifndef dk_log_WARNING_COLOR
	#define dk_log_WARNING_COLOR yellow
#endif
#ifndef dk_log_WARNING_TAG
	#define dk_log_WARNING_TAG "WARNING: "
#endif
#ifndef dk_log_WARNING_TRACE	
	#define dk_log_WARNING_TRACE 1
#endif
#ifndef dk_log_WARNING_LINE
	#define dk_log_WARNING_LINE 0
#endif
#ifndef dk_log_WARNING_SOUND
	#define dk_log_WARNING_SOUND 0
#endif
#ifndef dk_log_WARNING_PAUSE
	#define dk_log_WARNING_PAUSE 1
#endif
#ifndef dk_log_WARNING_HALT
	#define dk_log_WARNING_HALT 0
#endif

// DEPRECATED
#ifndef dk_log_DEPRECATED_ENABLED
	#define dk_log_DEPRECATED_ENABLED 1;
#endif	
#ifndef dk_log_DEPRECATED_COLOR
	#define dk_log_DEPRECATED_COLOR yellow
#endif
#ifndef dk_log_DEPRECATED_TAG
	#define dk_log_DEPRECATED_TAG "DEPRECATED: "
#endif
#ifndef dk_log_DEPRECATED_TRACE	
	#define dk_log_DEPRECATED_TRACE 0
#endif
#ifndef dk_log_DEPRECATED_LINE
	#define dk_log_DEPRECATED_LINE 0
#endif
#ifndef dk_log_DEPRECATED_PAUSE
	#define dk_log_DEPRECATED_PAUSE 0
#endif
#ifndef dk_log_DEPRECATED_HALT
	#define dk_log_DEPRECATED_HALT 0
#endif

// ERROR
#ifndef dk_log_ERROR_ENABLED
	#define dk_log_ERROR_ENABLED 1
#endif	
#ifndef dk_log_ERROR_COLOR
	#define dk_log_ERROR_COLOR lred
#endif
#ifndef dk_log_ERROR_TAG
	#define dk_log_ERROR_TAG "ERROR: "
#endif
#ifndef dk_log_ERROR_TRACE	
	#define dk_log_ERROR_TRACE 0
#endif
#ifndef dk_log_ERROR_LINE
	#define dk_log_ERROR_LINE 0
#endif
#ifndef dk_log_ERROR_PAUSE
	#define dk_log_ERROR_PAUSE 1
#endif
#ifndef dk_log_ERROR_HALT
	#define dk_log_ERROR_HALT 0
#endif

// FATAL
#ifndef dk_log_FATAL_ENABLED
	#define dk_log_FATAL_ENABLED 1
#endif	
#ifndef dk_log_FATAL_COLOR
	#define dk_log_FATAL_COLOR red
#endif
#ifndef dk_log_FATAL_TAG
	#define dk_log_FATAL_TAG "FATAL: "
#endif
#ifndef dk_log_FATAL_TRACE	
	#define dk_log_FATAL_TRACE 0
#endif
#ifndef dk_log_FATAL_LINE
	#define dk_log_FATAL_LINE 0
#endif
#ifndef dk_log_FATAL_PAUSE
	#define dk_log_FATAL_PAUSE 1
#endif
#ifndef dk_log_FATAL_HALT
	#define dk_log_FATAL_HALT 1
#endif


//################################################################################
//# dk_log(level, str)
//#
#include "dk_echo.h"
int v_dk_log(int level, const char* format, va_list args) {
		
	#if dk_log_ENABLE != 1
		return 1;
	#endif
	
	int level_enable  = dk_log_DEFAULT_ENABLED;
	char* level_color = (char *)dk_log_DEFAULT_COLOR;
	char* level_tag   = (char *)dk_log_DEFAULT_TAG;
	int level_pause	  = dk_log_DEFAULT_PAUSE;
	int level_trace   = dk_log_DEFAULT_TRACE;
	int level_line    = dk_log_DEFAULT_LINE;
	int level_halt    = dk_log_DEFAULT_HALT;
	if(level == VERBOSE){
		level_enable  = VERBOSE_ENABLED;
		level_color   = (char *)dk_log_VERBOSE_COLOR;
		level_tag     = (char *)dk_log_VERBOSE_TAG;
		level_pause	  = dk_log_VERBOSE_PAUSE;
		level_trace   = dk_log_VERBOSE_TRACE;
		level_line    = dk_log_VERBOSE_LINE;
		level_halt    = dk_log_VERBOSE_HALT;
	}
	if(level == DEBUG){
		level_enable  = DEBUG_ENABLED;
		level_color   = (char *)dk_log_DEBUG_COLOR;
		level_tag     = (char *)dk_log_DEBUG_TAG;
		level_pause	  = dk_log_DEBUG_PAUSE;
		level_trace   = dk_log_DEBUG_TRACE;
		level_line    = dk_log_DEBUG_LINE;
		level_halt    = dk_log_DEBUG_HALT;
	}
	if(level == INFO){
		level_enable  = INFO_ENABLED;
		level_color   = (char *)dk_log_INFO_COLOR;
		level_tag     = (char *)dk_log_INFO_TAG;
		level_pause	  = dk_log_INFO_PAUSE;
		level_trace   = dk_log_INFO_TRACE;
		level_line    = dk_log_INFO_LINE;
		level_halt    = dk_log_INFO_HALT;
	}
	if(level == SUCCESS){
		level_enable  = dk_log_SUCCESS_ENABLED;
		level_color   = (char *)dk_log_SUCCESS_COLOR;
		level_tag     = (char *)dk_log_SUCCESS_TAG;
		level_pause	  = dk_log_SUCCESS_PAUSE;
		level_trace   = dk_log_SUCCESS_TRACE;
		level_line    = dk_log_SUCCESS_LINE;
		level_halt    = dk_log_SUCCESS_HALT;
	}
	if(level == TODO){
		level_enable  = dk_log_TODO_ENABLED;
		level_color   = (char *)dk_log_TODO_COLOR;
		level_tag     = (char *)dk_log_TODO_TAG;
		level_pause	  = dk_log_TODO_PAUSE;
		level_trace   = dk_log_TODO_TRACE;
		level_line    = dk_log_TODO_LINE;
		level_halt    = dk_log_TODO_HALT;
	}
	if(level == NOTICE){
		level_enable  = dk_log_NOTICE_ENABLED;
		level_color   = (char *)dk_log_NOTICE_COLOR;
		level_tag     = (char *)dk_log_NOTICE_TAG;
		level_pause	  = dk_log_NOTICE_PAUSE;
		level_trace   = dk_log_NOTICE_TRACE;
		level_line    = dk_log_NOTICE_LINE;
		level_halt    = dk_log_NOTICE_HALT;
	}
	if(level == FIXME){
		level_enable  = dk_log_FIXME_ENABLED;
		level_color   = (char *)dk_log_FIXME_COLOR;
		level_tag     = (char *)dk_log_FIXME_TAG;
		level_pause	  = dk_log_FIXME_PAUSE;
		level_trace   = dk_log_FIXME_TRACE;
		level_line    = dk_log_FIXME_LINE;
		level_halt    = dk_log_FIXME_HALT;
	}
	if(level == WARNING){
		level_enable  = dk_log_WARNING_ENABLED;
		level_color   = (char *)dk_log_WARNING_COLOR;
		level_tag     = (char *)dk_log_WARNING_TAG;
		level_pause	  = dk_log_WARNING_PAUSE;
		level_trace   = dk_log_WARNING_TRACE;
		level_line    = dk_log_WARNING_LINE;
		level_halt    = dk_log_WARNING_HALT;
	}
	if(level == DEPRECATED){
		level_enable  = dk_log_DEPRECATED_ENABLED;
		level_color   = (char *)dk_log_DEPRECATED_COLOR;
		level_tag     = (char *)dk_log_DEPRECATED_TAG;
		level_pause	  = dk_log_DEPRECATED_PAUSE;
		level_trace   = dk_log_DEPRECATED_TRACE;
		level_line    = dk_log_DEPRECATED_LINE;
		level_halt    = dk_log_DEPRECATED_HALT;
	}
	if(level == ERROR){
		level_enable  = dk_log_ERROR_ENABLED;
		level_color   = (char *)dk_log_ERROR_COLOR;
		level_tag     = (char *)dk_log_ERROR_TAG;
		level_pause	  = dk_log_ERROR_PAUSE;
		level_trace   = dk_log_ERROR_TRACE;
		level_line    = dk_log_ERROR_LINE;
		level_halt    = dk_log_ERROR_HALT;
	}
	if(level == FATAL){
		level_enable  = dk_log_FATAL_ENABLED;
		level_color   = (char *)dk_log_FATAL_COLOR;
		level_tag     = (char *)dk_log_FATAL_TAG;
		level_pause	  = dk_log_FATAL_PAUSE;
		level_trace   = dk_log_FATAL_TRACE;
		level_line    = dk_log_FATAL_LINE;
		level_halt    = dk_log_FATAL_HALT;
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