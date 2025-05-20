#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


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

dk_if(NOT DEFINED dk_log_ENABLE}		[[ dk_set(dk_log_ENABLE 			1) ]])
#dk_if(NOT DEFINED ENV{dk_log_NOHALT}		[[ dk_set(dk_log_NOHALT 			1) ]])

# DEFAULT
dk_if(NOT DEFINED dk_log_DEFAULT_ENABLE		[[ dk_set(dk_log_DEFAULT_ENABLE		1) ]])
dk_if(NOT DEFINED dk_log_DEFAULT_COLOR		[[ dk_set(dk_log_DEFAULT_COLOR		"${white}") ]])
dk_if(NOT DEFINED dk_log_DEFAULT_TAG		[[ dk_set(dk_log_DEFAULT_TAG		"DEFAULT: ") ]])
dk_if(NOT DEFINED dk_log_DEFAULT_PAUSE		[[ dk_set(dk_log_DEFAULT_PAUSE		0) ]])
dk_if(NOT DEFINED dk_log_DEFAULT_TIMEOUT	[[ dk_set(dk_log_DEFAULT_TIMEOUT	0) ]])
dk_if(NOT DEFINED dk_log_DEFAULT_TRACE		[[ dk_set(dk_log_DEFAULT_TRACE		0) ]]) 
dk_if(NOT DEFINED dk_log_DEFAULT_LINE		[[ dk_set(dk_log_DEFAULT_LINE		0) ]]) 
dk_if(NOT DEFINED dk_log_DEFAULT_HALT		[[ dk_set(dk_log_DEFAULT_HALT		0) ]]) 

# VERBOSE
dk_if(NOT DEFINED dk_log_VERBOSE_ENABLE		[[ dk_set(dk_log_VERBOSE_ENABLE		1) ]])
dk_if(NOT DEFINED dk_log_VERBOSE_COLOR		[[ dk_set(dk_log_VERBOSE_COLOR		"${magenta}") ]])
dk_if(NOT DEFINED dk_log_VERBOSE_TAG		[[ dk_set(dk_log_VERBOSE_TAG		"VERBOSE: ") ]])
dk_if(NOT DEFINED dk_log_VERBOSE_PAUSE		[[ dk_set(dk_log_VERBOSE_PAUSE		0) ]])
dk_if(NOT DEFINED dk_log_VERBOSE_TIMEOUT	[[ dk_set(dk_log_VERBOSE_TIMEOUT	0) ]])
dk_if(NOT DEFINED dk_log_VERBOSE_TRACE		[[ dk_set(dk_log_VERBOSE_TRACE		0) ]])
dk_if(NOT DEFINED dk_log_VERBOSE_LINE		[[ dk_set(dk_log_VERBOSE_LINE		0) ]])
dk_if(NOT DEFINED dk_log_VERBOSE_HALT		[[ dk_set(dk_log_VERBOSE_HALT		0) ]])

# DEBUG
dk_if(NOT DEFINED dk_log_DEBUG_ENABLE		[[ dk_set(dk_log_DEBUG_ENABLE		1) ]])
dk_if(NOT DEFINED dk_log_DEBUG_COLOR		[[ dk_set(dk_log_DEBUG_COLOR		"${lblue}") ]])
dk_if(NOT DEFINED dk_log_DEBUG_TAG			[[ dk_set(dk_log_DEBUG_TAG			"DEBUG: ") ]])
dk_if(NOT DEFINED dk_log_DEBUG_PAUSE		[[ dk_set(dk_log_DEBUG_PAUSE		0) ]])
dk_if(NOT DEFINED dk_log_DEBUG_TIMEOUT		[[ dk_set(dk_log_DEBUG_TIMEOUT		0) ]])
dk_if(NOT DEFINED dk_log_DEBUG_TRACE		[[ dk_set(dk_log_DEBUG_TRACE		0) ]])
dk_if(NOT DEFINED dk_log_DEBUG_LINE			[[ dk_set(dk_log_DEBUG_LINE			0) ]])
dk_if(NOT DEFINED dk_log_DEBUG_HALT			[[ dk_set(dk_log_DEBUG_HALT			0) ]])

# INFO
dk_if(NOT DEFINED dk_log_INFO_ENABLE		[[ dk_set(dk_log_INFO_ENABLE		1) ]])
dk_if(NOT DEFINED dk_log_INFO_COLOR			[[ dk_set(dk_log_INFO_COLOR			"${white}") ]])
dk_if(NOT DEFINED dk_log_INFO_TAG			[[ dk_set(dk_log_INFO_TAG			"INFO: ") ]])
dk_if(NOT DEFINED dk_log_INFO_PAUSE			[[ dk_set(dk_log_INFO_PAUSE			0) ]])
dk_if(NOT DEFINED dk_log_INFO_SOUND			[[ dk_set(dk_log_INFO_SOUND			0) ]])
dk_if(NOT DEFINED dk_log_INFO_TIMEOUT		[[ dk_set(dk_log_INFO_TIMEOUT		0) ]])
dk_if(NOT DEFINED dk_log_INFO_TRACE			[[ dk_set(dk_log_INFO_TRACE			0) ]])
dk_if(NOT DEFINED dk_log_INFO_LINE			[[ dk_set(dk_log_INFO_LINE			0) ]])
dk_if(NOT DEFINED dk_log_INFO_HALT			[[ dk_set(dk_log_INFO_HALT			0) ]])

# SUCCESS
dk_if(NOT DEFINED dk_log_SUCCESS_ENABLE		[[ dk_set(dk_log_SUCCESS_ENABLE		1) ]])
dk_if(NOT DEFINED dk_log_SUCCESS_COLOR		[[ dk_set(dk_log_SUCCESS_COLOR		"${green}") ]])
dk_if(NOT DEFINED dk_log_SUCCESS_TAG		[[ dk_set(dk_log_SUCCESS_TAG		"SUCCESS: ") ]])
dk_if(NOT DEFINED dk_log_SUCCESS_PAUSE		[[ dk_set(dk_log_SUCCESS_PAUSE		0) ]])
dk_if(NOT DEFINED dk_log_SUCCESS_TIMEOUT	[[ dk_set(dk_log_SUCCESS_TIMEOUT	0) ]])
dk_if(NOT DEFINED dk_log_SUCCESS_TRACE		[[ dk_set(dk_log_SUCCESS_TRACE		0) ]])
dk_if(NOT DEFINED dk_log_SUCCESS_LINE		[[ dk_set(dk_log_SUCCESS_LINE		0) ]])
dk_if(NOT DEFINED dk_log_SUCCESS_HALT		[[ dk_set(dk_log_SUCCESS_HALT		0) ]])

# TODO
dk_if(NOT DEFINED dk_log_TODO_ENABLE		[[ dk_set(dk_log_TODO_ENABLE		1) ]])
dk_if(NOT DEFINED dk_log_TODO_COLOR			[[ dk_set(dk_log_TODO_COLOR			"${blue}") ]])
dk_if(NOT DEFINED dk_log_TODO_TAG			[[ dk_set(dk_log_TODO_TAG			"TODO: ") ]])
dk_if(NOT DEFINED dk_log_TODO_PAUSE			[[ dk_set(dk_log_TODO_PAUSE			0) ]])
dk_if(NOT DEFINED dk_log_TODO_TIMEOUT		[[ dk_set(dk_log_TODO_TIMEOUT		15) ]])
dk_if(NOT DEFINED dk_log_TODO_TRACE			[[ dk_set(dk_log_TODO_TRACE			0) ]])
dk_if(NOT DEFINED dk_log_TODO_LINE			[[ dk_set(dk_log_TODO_LINE			0) ]])
dk_if(NOT DEFINED dk_log_TODO_HALT			[[ dk_set(dk_log_TODO_HALT			0) ]])

# NOTICE
dk_if(NOT DEFINED dk_log_NOTICE_ENABLE		[[ dk_set(dk_log_NOTICE_ENABLE		1) ]])
dk_if(NOT DEFINED dk_log_NOTICE_COLOR		[[ dk_set(dk_log_NOTICE_COLOR		"${lyellow}") ]])
dk_if(NOT DEFINED dk_log_NOTICE_TAG			[[ dk_set(dk_log_NOTICE_TAG			"NOTICE: ") ]])
dk_if(NOT DEFINED dk_log_NOTICE_PAUSE		[[ dk_set(dk_log_NOTICE_PAUSE		0) ]])
dk_if(NOT DEFINED dk_log_NOTICE_TIMEOUT		[[ dk_set(dk_log_NOTICE_TIMEOUT		0) ]])
dk_if(NOT DEFINED dk_log_NOTICE_TRACE		[[ dk_set(dk_log_NOTICE_TRACE		0) ]])
dk_if(NOT DEFINED dk_log_NOTICE_LINE		[[ dk_set(dk_log_NOTICE_LINE		0) ]])
dk_if(NOT DEFINED dk_log_NOTICE_HALT		[[ dk_set(dk_log_NOTICE_HALT		0) ]])

# FIXME
dk_if(NOT DEFINED dk_log_FIXME_ENABLE		[[ dk_set(dk_log_FIXME_ENABLE		1) ]])
dk_if(NOT DEFINED dk_log_FIXME_COLOR		[[ dk_set(dk_log_FIXME_COLOR		"${lyellow}") ]])
dk_if(NOT DEFINED dk_log_FIXME_TAG			[[ dk_set(dk_log_FIXME_TAG			"FIXME: ") ]])
dk_if(NOT DEFINED dk_log_FIXME_PAUSE		[[ dk_set(dk_log_FIXME_PAUSE		0) ]])
dk_if(NOT DEFINED dk_log_FIXME_TIMEOUT		[[ dk_set(dk_log_FIXME_TIMEOUT		20) ]])
dk_if(NOT DEFINED dk_log_FIXME_TRACE		[[ dk_set(dk_log_FIXME_TRACE		0) ]])
dk_if(NOT DEFINED dk_log_FIXME_LINE			[[ dk_set(dk_log_FIXME_LINE			0) ]])
dk_if(NOT DEFINED dk_log_FIXME_HALT			[[ dk_set(dk_log_FIXME_HALT			0) ]])

# WARNING
dk_if(NOT DEFINED dk_log_WARNING_ENABLE		[[ dk_set(dk_log_WARNING_ENABLE		1) ]])
dk_if(NOT DEFINED dk_log_WARNING_COLOR		[[ dk_set(dk_log_WARNING_COLOR		"${yellow}") ]])
dk_if(NOT DEFINED dk_log_WARNING_TAG		[[ dk_set(dk_log_WARNING_TAG		"WARNING: ") ]])
dk_if(NOT DEFINED dk_log_WARNING_PAUSE		[[ dk_set(dk_log_WARNING_PAUSE		0) ]])
dk_if(NOT DEFINED dk_log_WARNING_TIMEOUT	[[ dk_set(dk_log_WARNING_TIMEOUT	0) ]])
dk_if(NOT DEFINED dk_log_WARNING_TRACE		[[ dk_set(dk_log_WARNING_TRACE		1) ]])
dk_if(NOT DEFINED dk_log_WARNING_LINE		[[ dk_set(dk_log_WARNING_LINE		0) ]])
dk_if(NOT DEFINED dk_log_WARNING_HALT		[[ dk_set(dk_log_WARNING_HALT		0) ]])

# ERROR
dk_if(NOT DEFINED dk_log_ERROR_ENABLE		[[ dk_set(dk_log_ERROR_ENABLE		1) ]])
dk_if(NOT DEFINED dk_log_ERROR_COLOR		[[ dk_set(dk_log_ERROR_COLOR		"${lred}") ]])
dk_if(NOT DEFINED dk_log_ERROR_TAG			[[ dk_set(dk_log_ERROR_TAG			"ERROR: ") ]])
#dk_set(error_song	"200,1000\;200,1000\;200,1000\;200,1000\;200,1000")
#if(NOT DEFINED dk_log_ERROR_SOUND)
#	dk_set(dk_log_ERROR_SOUND					${error_song}					)
#endif()
#dk_if(NOT DEFINED dk_log_ERROR_PAUSE		[[ dk_set(dk_log_ERROR_PAUSE		0) ]])
dk_if(NOT DEFINED dk_log_ERROR_TIMEOUT		[[ dk_set(dk_log_ERROR_TIMEOUT		1) ]])
dk_if(NOT DEFINED dk_log_ERROR_TRACE		[[ dk_set(dk_log_ERROR_TRACE		1) ]])
#dk_if(NOT DEFINED dk_log_ERROR_LINE			[[ dk_set(dk_log_ERROR_LINE		0) ]])
#dk_if(NOT DEFINED dk_log_ERROR_HALT			[[ dk_set(dk_log_ERROR_HALT		0) ]])

# FATAL
dk_if(NOT DEFINED dk_log_FATAL_ENABLE		[[ dk_set(dk_log_FATAL_ENABLE		1) ]])
dk_if(NOT DEFINED dk_log_FATAL_COLOR		[[ dk_set(dk_log_FATAL_COLOR		"${red}") ]])
dk_if(NOT DEFINED dk_log_FATAL_TAG			[[ dk_set(dk_log_FATAL_TAG			"FATAL: ") ]])
#dk_set(imperial_march "440,500\;440,500\;440,500\;349,350\;523,150\;440,500\;349,350\;523,150\;440,1000\;659,500\;659,500\;659,500\;698,350\;523,150\;415,500\;349,350\;523,150\;440,1000")
#if(NOT DEFINED dk_log_FATAL_SOUND)
#	dk_set(dk_log_FATAL_SOUND					${imperial_march}				)
#endif()
#dk_if(NOT DEFINED dk_log_FATAL_PAUSE		[[ dk_set(dk_log_FATAL_PAUSE		0) ]])
#dk_if(NOT DEFINED dk_log_FATAL_TIMEOUT		[[ dk_set(dk_log_FATAL_TIMEOUT		0) ]])
dk_if(NOT DEFINED dk_log_FATAL_TRACE		[[ dk_set(dk_log_FATAL_TRACE		1) ]])
#dk_if(NOT DEFINED dk_log_FATAL_LINE			[[ dk_set(dk_log_FATAL_LINE			0) ]])
dk_if(NOT DEFINED dk_log_FATAL_HALT			[[ dk_set(dk_log_FATAL_HALT			1) ]])


################################################################################
# dk_debug(message)
#
#	Print a debug message to the console
#
#	@message	- The message to print
#
function(dk_log)
	#dk_debugFunc()
	
	dk_getParameter(TRACE REMOVE)
	dk_getParameter(NO_TRACE REMOVE)
	dk_getParameter(LINE REMOVE)
	dk_getParameter(NO_LINE REMOVE)
	dk_getParameter(SOUND REMOVE)
	dk_getParameter(NO_SOUND REMOVE)
	dk_getParameter(PAUSE REMOVE)
	dk_getParameter(NO_PAUSE REMOVE)
	dk_getParameter(TIMEOUT REMOVE)
	dk_getParameter(NO_TIMEOUT REMOVE)
	dk_getParameter(HALT REMOVE)
	dk_getParameter(NO_HALT REMOVE)
	
	if(NOT "${dk_log_ENABLE}" EQUAL "1")
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
	if((dk_log_${_level_}_TRACE) AND (NOT NO_TRACE) OR (TRACE))
		dk_echo("\n${dk_log_${_level_}_COLOR}###### TRACE_ON_${_level_} ######")
		dk_stacktrace()
		message("${clr}")
	endif()

	### LINE ###
	if((dk_log_${_level_}_LINE) AND (NOT NO_LINE) OR (LINE))
		dk_echo("\n${dk_log_${_level_}_COLOR}###### LINE_ON_${_level_} ######")
		#d_k_showFileLine("${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}")
		message("${clr}")
	endif()

	### SOUND ###
	if((dk_log_${_level_}_SOUND) AND (NOT NO_SOUND) OR (SOUND))
		dk_echo("\n${dk_log_${_level_}_COLOR}###### SOUND_ON_${_level_} ######${clr}")
		dk_pause()
		dk_beeps(dk_log_${_level_}_SOUND)
	endif()

	### PAUSE ###
	if((dk_log_${_level_}_PAUSE) AND (NOT NO_PAUSE) OR (PAUSE))
		dk_echo("\n${dk_log_${_level_}_COLOR}###### PAUSE_ON_${_level_} ######${clr}")
		dk_pause()
	endif()

	### TIMEOUT ###
	if((dk_log_${_level_}_TIMEOUT) AND (NOT NO_TIMEOUT) OR (TIMEOUT))
		dk_echo("\n${dk_log_${_level_}_COLOR}###### TIMEOUT_ON_${_level_} ######${clr}")
		dk_timeout(dk_log_${_level_}_TIMEOUT)
	endif()

	### HALT ###
	if((dk_log_${_level_}_HALT) AND (NOT NO_HALT) OR (HALT))
		dk_echo("\n${dk_log_${_level_}_COLOR}###### HALT_ON_${_level_} ######${clr}")
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
	dk_log(FATAL	"test dk_log FATAL message w/NO_HALT" NO_HALT)
	dk_log(FATAL	"test dk_log FATAL message")
endfunction()
