#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

dk_if(NOT DEFINED dk_log_ENABLE [[ dk_set(dk_log_ENABLE 1) ]])
dk_if(NOT DEFINED dk_log_NOHALT	[[ dk_set(dk_log_NOHALT 1) ]])
# 0 VERBOSE		dk_verbose
# 1 DEBUG		dk_debug
# 2 INFO		dk_info
# 3 SUCCESS		dk_success
# 4 TODO		dk_todo
# 5 NOTICE		dk_notice
# 6 FIXME		dk_fixme
# 7 WARNING		dk_warning
# 8 ERROR		dk_error
# 9 FATAL		dk_fatal

#dk_color()
# DEFAULT
dk_if(NOT DEFINED dk_log_DEFAULT_ENABLE		[[ set(dk_log_DEFAULT_ENABLE	1				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_DEFAULT_COLOR		[[ set(dk_log_DEFAULT_COLOR		"${white}"		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_DEFAULT_TAG		[[ set(dk_log_DEFAULT_TAG		"DEFAULT: "		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_DEFAULT_PAUSE		[[ set(dk_log_DEFAULT_PAUSE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_DEFAULT_TIMEOUT	[[ set(dk_log_DEFAULT_TIMEOUT	0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_DEFAULT_TRACE		[[ set(dk_log_DEFAULT_TRACE		0				CACHE INTERNAL '') ]]) 
dk_if(NOT DEFINED dk_log_DEFAULT_LINE		[[ set(dk_log_DEFAULT_LINE		0				CACHE INTERNAL '') ]]) 
dk_if(NOT DEFINED dk_log_DEFAULT_HALT		[[ set(dk_log_DEFAULT_HALT		0				CACHE INTERNAL '') ]]) 

# VERBOSE
dk_if(NOT DEFINED dk_log_VERBOSE_ENABLE		[[ set(dk_log_VERBOSE_ENABLE	1				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_VERBOSE_COLOR		[[ set(dk_log_VERBOSE_COLOR		"${magenta}"	CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_VERBOSE_TAG		[[ set(dk_log_VERBOSE_TAG		"VERBOSE: "		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_VERBOSE_PAUSE		[[ set(dk_log_VERBOSE_PAUSE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_VERBOSE_TIMEOUT	[[ set(dk_log_VERBOSE_TIMEOUT	0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_VERBOSE_TRACE		[[ set(dk_log_VERBOSE_TRACE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_VERBOSE_LINE		[[ set(dk_log_VERBOSE_LINE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_VERBOSE_HALT		[[ set(dk_log_VERBOSE_HALT		0				CACHE INTERNAL '') ]])

# DEBUG
dk_if(NOT DEFINED dk_log_DEBUG_ENABLE		[[ set(dk_log_DEBUG_ENABLE		1				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_DEBUG_COLOR		[[ set(dk_log_DEBUG_COLOR		"${lblue}"		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_DEBUG_TAG			[[ set(dk_log_DEBUG_TAG			"DEBUG: "		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_DEBUG_PAUSE		[[ set(dk_log_DEBUG_PAUSE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_DEBUG_TIMEOUT		[[ set(dk_log_DEBUG_TIMEOUT		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_DEBUG_TRACE		[[ set(dk_log_DEBUG_TRACE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_DEBUG_LINE			[[ set(dk_log_DEBUG_LINE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_DEBUG_HALT			[[ set(dk_log_DEBUG_HALT		0				CACHE INTERNAL '') ]])

# INFO
dk_if(NOT DEFINED dk_log_INFO_ENABLE		[[ set(dk_log_INFO_ENABLE		1 				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_INFO_COLOR			[[ set(dk_log_INFO_COLOR		"${white}" 		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_INFO_TAG			[[ set(dk_log_INFO_TAG			"INFO: " 		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_INFO_PAUSE			[[ set(dk_log_INFO_PAUSE		0 				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_INFO_TIMEOUT		[[ set(dk_log_INFO_TIMEOUT		0 				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_INFO_TRACE			[[ set(dk_log_INFO_TRACE		0 				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_INFO_LINE			[[ set(dk_log_INFO_LINE			0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_INFO_HALT			[[ set(dk_log_INFO_HALT			0 				CACHE INTERNAL '') ]])

# SUCCESS
dk_if(NOT DEFINED dk_log_SUCCESS_ENABLE		[[ set(dk_log_SUCCESS_ENABLE	1				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_SUCCESS_COLOR		[[ set(dk_log_SUCCESS_COLOR		"${green}"		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_SUCCESS_TAG		[[ set(dk_log_SUCCESS_TAG		"SUCCESS: "		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_SUCCESS_PAUSE		[[ set(dk_log_SUCCESS_PAUSE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_SUCCESS_TIMEOUT	[[ set(dk_log_SUCCESS_TIMEOUT	0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_SUCCESS_TRACE		[[ set(dk_log_SUCCESS_TRACE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_SUCCESS_LINE		[[ set(dk_log_SUCCESS_LINE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_SUCCESS_HALT		[[ set(dk_log_SUCCESS_HALT		0				CACHE INTERNAL '') ]])

# TODO
dk_if(NOT DEFINED dk_log_TODO_ENABLE		[[ set(dk_log_TODO_ENABLE		1				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_TODO_COLOR			[[ set(dk_log_TODO_COLOR		"${blue}"		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_TODO_TAG			[[ set(dk_log_TODO_TAG			"TODO: "		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_TODO_PAUSE			[[ set(dk_log_TODO_PAUSE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_TODO_TIMEOUT		[[ set(dk_log_TODO_TIMEOUT		15				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_TODO_TRACE			[[ set(dk_log_TODO_TRACE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_TODO_LINE			[[ set(dk_log_TODO_LINE			0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_TODO_HALT			[[ set(dk_log_TODO_HALT			0				CACHE INTERNAL '') ]])

# NOTICE
dk_if(NOT DEFINED dk_log_NOTICE_ENABLE		[[ set(dk_log_NOTICE_ENABLE	1					CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_NOTICE_COLOR		[[ set(dk_log_NOTICE_COLOR		"${lyellow}"	CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_NOTICE_TAG			[[ set(dk_log_NOTICE_TAG		"NOTICE: "		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_NOTICE_PAUSE		[[ set(dk_log_NOTICE_PAUSE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_NOTICE_TIMEOUT		[[ set(dk_log_NOTICE_TIMEOUT	0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_NOTICE_TRACE		[[ set(dk_log_NOTICE_TRACE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_NOTICE_LINE		[[ set(dk_log_NOTICE_LINE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_NOTICE_HALT		[[ set(dk_log_NOTICE_HALT		0				CACHE INTERNAL '') ]])

# FIXME
dk_if(NOT DEFINED dk_log_FIXME_ENABLE		[[ set(dk_log_FIXME_ENABLE		1				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_FIXME_COLOR		[[ set(dk_log_FIXME_COLOR		"${lyellow}"	CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_FIXME_TAG			[[ set(dk_log_FIXME_TAG			"FIXME: "		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_FIXME_PAUSE		[[ set(dk_log_FIXME_PAUSE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_FIXME_TIMEOUT		[[ set(dk_log_FIXME_TIMEOUT		20				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_FIXME_TRACE		[[ set(dk_log_FIXME_TRACE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_FIXME_LINE			[[ set(dk_log_FIXME_LINE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_FIXME_HALT			[[ set(dk_log_FIXME_HALT		0				CACHE INTERNAL '') ]])

# WARNING
dk_if(NOT DEFINED dk_log_WARNING_ENABLE		[[ set(dk_log_WARNING_ENABLE	1				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_WARNING_COLOR		[[ set(dk_log_WARNING_COLOR		"${yellow}"		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_WARNING_TAG		[[ set(dk_log_WARNING_TAG		"WARNING: "		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_WARNING_PAUSE		[[ set(dk_log_WARNING_PAUSE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_WARNING_TIMEOUT	[[ set(dk_log_WARNING_TIMEOUT	0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_WARNING_TRACE		[[ set(dk_log_WARNING_TRACE		1				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_WARNING_LINE		[[ set(dk_log_WARNING_LINE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_WARNING_HALT		[[ set(dk_log_WARNING_HALT		0				CACHE INTERNAL '') ]])

# ERROR
dk_if(NOT DEFINED dk_log_ERROR_ENABLE		[[ set(dk_log_ERROR_ENABLE		1				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_ERROR_COLOR		[[ set(dk_log_ERROR_COLOR		"${lred}"		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_ERROR_TAG			[[ set(dk_log_ERROR_TAG			"ERROR: "		CACHE INTERNAL '') ]])
set(error_song	"200,1000\;200,1000\;200,1000\;200,1000\;200,1000")
if(NOT DEFINED dk_log_ERROR_SOUND)
	set(dk_log_ERROR_SOUND					${error_song}									CACHE INTERNAL '')
endif()
dk_if(NOT DEFINED dk_log_ERROR_PAUSE		[[ set(dk_log_ERROR_PAUSE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_ERROR_TIMEOUT		[[ set(dk_log_ERROR_TIMEOUT		1				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_ERROR_TRACE		[[ set(dk_log_ERROR_TRACE		1				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_ERROR_LINE			[[ set(dk_log_ERROR_LINE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_ERROR_HALT			[[ set(dk_log_ERROR_HALT		0				CACHE INTERNAL '') ]])

# FATAL
dk_if(NOT DEFINED dk_log_FATAL_ENABLE		[[ set(dk_log_FATAL_ENABLE		1				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_FATAL_COLOR		[[ set(dk_log_FATAL_COLOR		"${red}"		CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_FATAL_TAG			[[ set(dk_log_FATAL_TAG			"FATAL: "		CACHE INTERNAL '') ]])
set(imperial_march "440,500\;440,500\;440,500\;349,350\;523,150\;440,500\;349,350\;523,150\;440,1000\;659,500\;659,500\;659,500\;698,350\;523,150\;415,500\;349,350\;523,150\;440,1000")
if(NOT DEFINED dk_log_FATAL_SOUND)
	set(dk_log_FATAL_SOUND					${imperial_march}								CACHE INTERNAL '')
endif()
dk_if(NOT DEFINED dk_log_FATAL_PAUSE		[[ set(dk_log_FATAL_PAUSE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_FATAL_TIMEOUT		[[ set(dk_log_FATAL_TIMEOUT		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_FATAL_TRACE		[[ set(dk_log_FATAL_TRACE		1				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_FATAL_LINE			[[ set(dk_log_FATAL_LINE		0				CACHE INTERNAL '') ]])
dk_if(NOT DEFINED dk_log_FATAL_HALT			[[ set(dk_log_FATAL_HALT		1				CACHE INTERNAL '') ]])


################################################################################
# dk_debug(message)
#
#	Print a debug message to the console
#
#	@message	- The message to print
#
function(dk_log)
	#dk_debugFunc()
	
	dk_getOption(NO_HALT REMOVE)
	
	if(NOT ${dk_log_ENABLE} EQUAL 1)
		dk_return()
	endif()

	
	if(${ARGC} EQUAL 1)
		set(_level_ "DEFAULT")
		set(_message_ "${ARGV0}")
	endif()
	if(${ARGC} EQUAL 2)
		set(_level_ "${ARGV0}")
		set(_message_ "${ARGV1}")
	endif()

	if(NOT dk_log_${_level_}_ENABLE)
		dk_return()
	endif()

	dk_echo("${dk_log_${_level_}_COLOR}${dk_log_${_level_}_TAG}${_message_}${clr}")

	### TRACE ###
	if((dk_log_${_level_}_TRACE) AND (NOT NO_TRACE))
		dk_echo("${dk_log_${_level_}_COLOR}*** TRACE_ON_${_level_} ***")
		dk_stacktrace()
		message("${clr}")
	endif()

	### LINE ###
	if((dk_log_${_level_}_LINE) AND (NOT NO_LINE))
		dk_echo("${dk_log_${_level_}_COLOR}*** LINE_ON_${_level_} ***")
		#d_k_showFileLine("${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}")
		message("${clr}")
	endif()

	### SOUND ###
	if((dk_log_${_level_}_SOUND) AND (NOT NO_SOUND))
		dk_echo("${dk_log_${_level_}_COLOR}*** SOUND_ON_${_level_} ***${clr}")
		dk_beeps(dk_log_${_level_}_SOUND)
	endif()

	### PAUSE ###
	if((dk_log_${_level_}_PAUSE) AND (NOT NO_PAUSE))
		dk_echo("${dk_log_${_level_}_COLOR}*** PAUSE_ON_${_level_} ***${clr}")
		dk_pause()
	endif()

	### TIMEOUT ###
	if((dk_log_${_level_}_TIMEOUT) AND (NOT NO_TIMEOUT))
		dk_echo("${dk_log_${_level_}_COLOR}*** TIMEOUT_ON_${_level_} ***${clr}")
		dk_timeout(dk_log_${_level_}_TIMEOUT)
	endif()

	### HALT ###
	if((dk_log_${_level_}_HALT) AND (NOT NO_HALT))
		dk_echo("${dk_log_${_level_}_COLOR}*** HALT_ON_${_level_} ***${clr}")
		dk_exit(13)
	endif()

endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_log("test dk_log message")
	dk_log(VERBOSE	"test dk_log VERBOSE message")
	dk_log(DEBUG	"test dk_log DEBUG message")
	dk_log(INFO		"test dk_log INFO message")
	dk_log(SUCCESS	"test dk_log SUCCESS message")
	dk_log(TODO		"test dk_log TODO message")
	dk_log(NOTICE	"test dk_log NOTICE message")
	dk_log(FIXME	"test dk_log FIXME message")
	dk_log(WARNING	"test dk_log WARNING message")
	dk_log(ERROR	"test dk_log ERROR message")
	dk_log(FATAL	"test dk_log FATAL message" NO_HALT)
	dk_log(FATAL	"test dk_log FATAL message")
endfunction()
