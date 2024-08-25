include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

#dk_color()
# DEFAULT
dk_if(NOT DEFINED ENABLE_dk_log   "set(ENABLE_dk_log  1            CACHE INTERNAL '')")
dk_if(NOT DEFINED DEFAULT_COLOR   "set(DEFAULT_COLOR  '${white}'   CACHE INTERNAL '')")
dk_if(NOT DEFINED DEFAULT_TAG     "set(DEFAULT_TAG    ''           CACHE INTERNAL '')")
dk_if(NOT DEFINED DEFAULT_PAUSE   "set(DEFAULT_PAUSE  0            CACHE INTERNAL '')")
dk_if(NOT DEFINED DEFAULT_TRACE   "set(DEFAULT_TRACE  0            CACHE INTERNAL '')") 
dk_if(NOT DEFINED DEFAULT_LINE    "set(DEFAULT_LINE   0            CACHE INTERNAL '')") 
dk_if(NOT DEFINED DEFAULT_HALT    "set(DEFAULT_HALT   0            CACHE INTERNAL '')") 

# VERBOSE
dk_if(NOT DEFINED VERBOSE_ENABLE  "set(VERBOSE_ENABLE 1            CACHE INTERNAL '')")
dk_if(NOT DEFINED VERBOSE_COLOR   "set(VERBOSE_COLOR  '${magenta}' CACHE INTERNAL '')")
dk_if(NOT DEFINED VERBOSE_TAG     "set(VERBOSE_TAG    'VERBOSE: '  CACHE INTERNAL '')")
dk_if(NOT DEFINED VERBOSE_PAUSE   "set(VERBOSE_PAUSE  0            CACHE INTERNAL '')")
dk_if(NOT DEFINED VERBOSE_TRACE   "set(VERBOSE_TRACE  0            CACHE INTERNAL '')")
dk_if(NOT DEFINED VERBOSE_LINE    "set(VERBOSE_LINE   0            CACHE INTERNAL '')")
dk_if(NOT DEFINED VERBOSE_HALT    "set(VERBOSE_HALT   0            CACHE INTERNAL '')")

# DEBUG
dk_if(NOT DEFINED DEBUG_ENABLE    "set(DEBUG_ENABLE   1 CACHE INTERNAL '')")
dk_if(NOT DEFINED DEBUG_COLOR     "set(DEBUG_COLOR '${blue}' CACHE INTERNAL '')")
dk_if(NOT DEFINED DEBUG_TAG       "set(DEBUG_TAG 'DEBUG: ' CACHE INTERNAL '')")
dk_if(NOT DEFINED DEBUG_PAUSE     "set(DEBUG_PAUSE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED DEBUG_TRACE     "set(DEBUG_TRACE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED DEBUG_LINE      "set(DEBUG_LINE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED DEBUG_HALT      "set(DEBUG_HALT 0 CACHE INTERNAL '')")

# INFO
dk_if(NOT DEFINED INFO_ENABLE     "set(INFO_ENABLE 1 CACHE INTERNAL '')")
dk_if(NOT DEFINED INFO_COLOR      "set(INFO_COLOR '${white}' CACHE INTERNAL '')")
dk_if(NOT DEFINED INFO_TAG        "set(INFO_TAG 'INFO: ' CACHE INTERNAL '')")
dk_if(NOT DEFINED INFO_PAUSE      "set(INFO_PAUSE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED INFO_TRACE      "set(INFO_TRACE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED INFO_LINE       "set(INFO_LINE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED INFO_HALT       "set(INFO_HALT 0 CACHE INTERNAL '')")

# NOTICE
dk_if(NOT DEFINED NOTICE_ENABLE   "set(NOTICE_ENABLE 1 CACHE INTERNAL '')")
dk_if(NOT DEFINED NOTICE_COLOR    "set(NOTICE_COLOR '${lyellow}' CACHE INTERNAL '')")
dk_if(NOT DEFINED NOTICE_TAG      "set(NOTICE_TAG 'NOTICE: ' CACHE INTERNAL '')")
dk_if(NOT DEFINED NOTICE_PAUSE    "set(NOTICE_PAUSE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED NOTICE_TRACE    "set(NOTICE_TRACE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED NOTICE_LINE     "set(NOTICE_LINE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED NOTICE_HALT     "set(NOTICE_HALT 0 CACHE INTERNAL '')")

# WARNING
dk_if(NOT DEFINED WARNING_ENABLE  "set(WARNING_ENABLE 1 CACHE INTERNAL '')")
dk_if(NOT DEFINED WARNING_COLOR   "set(WARNING_COLOR '${yellow}' CACHE INTERNAL '')")
dk_if(NOT DEFINED WARNING_TAG     "set(WARNING_TAG 'WARNING: ' CACHE INTERNAL '')")
dk_if(NOT DEFINED WARNING_PAUSE   "set(WARNING_PAUSE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED WARNING_TRACE   "set(WARNING_TRACE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED WARNING_LINE    "set(WARNING_LINE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED WARNING_HALT    "set(WARNING_HALT 0 CACHE INTERNAL '')")

# ERROR
dk_if(NOT DEFINED ERROR_ENABLE    "set(ERROR_ENABLE 1 CACHE INTERNAL '')")
dk_if(NOT DEFINED ERROR_COLOR     "set(ERROR_COLOR '${red}' CACHE INTERNAL '')")
dk_if(NOT DEFINED ERROR_TAG       "set(ERROR_TAG 'ERROR: ' CACHE INTERNAL '')")
dk_if(NOT DEFINED ERROR_PAUSE     "set(ERROR_PAUSE 1 CACHE INTERNAL '')")
dk_if(NOT DEFINED ERROR_TRACE     "set(ERROR_TRACE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED ERROR_LINE      "set(ERROR_LINE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED ERROR_HALT      "set(ERROR_HALT 0 CACHE INTERNAL '')")

# TODO
dk_if(NOT DEFINED TODO_ENABLE     "set(TODO_ENABLE 1 CACHE INTERNAL '')")
dk_if(NOT DEFINED TODO_COLOR      "set(TODO_COLOR '${yellow}' CACHE INTERNAL '')")
dk_if(NOT DEFINED TODO_TAG        "set(TODO_TAG 'TODO: ' CACHE INTERNAL '')")
dk_if(NOT DEFINED TODO_PAUSE      "set( TODO_PAUSE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED TODO_TRACE      "set(TODO_TRACE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED TODO_LINE       "set(TODO_LINE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED TODO_HALT       "set(TODO_HALT 0 CACHE INTERNAL '')")

# FIXME
dk_if(NOT DEFINED FIXME_ENABLE    "set(FIXME_ENABLE 1 CACHE INTERNAL '')")
dk_if(NOT DEFINED FIXME_COLOR     "set(FIXME_COLOR '${red}' CACHE INTERNAL '')")
dk_if(NOT DEFINED FIXME_TAG       "set(FIXME_TAG 'FIXME: ' CACHE INTERNAL '')")
dk_if(NOT DEFINED FIXME_PAUSE     "set(FIXME_PAUSE 1 CACHE INTERNAL '')")
dk_if(NOT DEFINED FIXME_TRACE     "set(FIXME_TRACE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED FIXME_LINE      "set(FIXME_LINE 0 CACHE INTERNAL '')")
dk_if(NOT DEFINED FIXME_HALT      "set(FIXME_HALT 0 CACHE INTERNAL '')")


################################################################################
# dk_debug(message)
#
#    Print a debug message to the console
#
#    @message	- The message to print
#
function(dk_log)
	dk_debugFunc(${ARGV})
	
	if(NOT ${ENABLE_dk_log} EQUAL 1)
		return()
	endif()
	
	if(${ARGC} EQUAL 1) 
		set(_level_ "DEFAULT")
		set(_message_ "${ARGV0}")
	endif()
	if(${ARGC} EQUAL 2) 
		set(_level_ "${ARGV0}")
		set(_message_ "${ARGV1}")
	endif()

	if(NOT ${${_level_}_ENABLE} EQUAL 1)
		return()
	endif()
	
	
	dk_echo("${${_level_}_COLOR}${${_level_}_TAG}${_message_}${clr}")
	if(${${_level_}_PAUSE} EQUAL 1)
		dk_echo("${${_level_}_COLOR}*** PAUSE_ON_${_level_} ***${clr}")
		dk_pause()
	endif()
	if(${${_level_}_TRACE} EQUAL 1)
		dk_echo("${${_level_}_COLOR}*** TRACE_ON_${_level_} ***${clr}")
		dk_stacktrace() #OR TRACE AND NOT NO_TRACE)
	endif()
	if(${${_level_}_LINE} EQUAL 1)
		dk_echo("${${_level_}_COLOR}*** LINE_ON_${_level_} ***${clr}")
		#d_k_showFileLine("${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}") #OR HALT AND NOT NO_HALT)
	endif()
	if(${${_level_}_HALT} EQUAL 1)
		dk_echo("${${_level_}_COLOR}*** HALT_ON_${_level_} ***${clr}")
		dk_exit(0) #OR HALT AND NOT NO_HALT)
	endif()
	
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_log("test dk_log message")
	
	dk_log(VERBOSE "test dk_log VERBOSE message")
	dk_log(DEBUG   "test dk_log DEBUG message")
	dk_log(INFO    "test dk_log INFO message")
	dk_log(NOTICE  "test dk_log NOTICE message")
	dk_log(WARNING "test dk_log WARNING message")
	dk_log(TODO    "test dk_log TODO message")
	dk_log(FIXME   "test dk_log FIXME message")
	dk_log(ERROR   "test dk_log ERROR message")
endfunction()