<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

[ -z ${ENABLE_dk_log-} ]  && ENABLE_dk_log=1

#  0 VERBOSE    dk_verbose
#  1 DEBUG      dk_debug
#  2 INFO       dk_info
#  3 SUCCESS    dk_success
#  4 TODO       dk_todo
#  5 NOTICE     dk_notice
#  6 FIXME      dk_fixme
#  7 WARNING    dk_warning
#  8 ERROR      dk_error
#  9 FATAL      dk_fatal

# DEFAULT
[ -z ${DEFAULT_ENABLE-} ] && DEFAULT_ENABLE=1
[ -z ${DEFAULT_COLOR-} ]  && DEFAULT_COLOR=${white-}
[ -z ${DEFAULT_TAG-} ]    && DEFAULT_TAG=""
[ -z ${DEFAULT_PAUSE-} ]  && DEFAULT_PAUSE=0
[ -z ${DEFAULT_TRACE-} ]  && DEFAULT_TRACE=0
[ -z ${DEFAULT_LINE-} ]   && DEFAULT_LINE=0
[ -z ${DEFAULT_HALT-} ]   && DEFAULT_HALT=0

# VERBOSE
[ -z ${VERBOSE_ENABLE-} ] && VERBOSE_ENABLE=1
[ -z ${VERBOSE_COLOR-} ]  && VERBOSE_COLOR=${magenta-}
[ -z ${VERBOSE_TAG-} ]    && VERBOSE_TAG="VERBOSE: "
[ -z ${VERBOSE_PAUSE-} ]  && VERBOSE_PAUSE=0
[ -z ${VERBOSE_TRACE-} ]  && VERBOSE_TRACE=0
[ -z ${VERBOSE_LINE-} ]   && VERBOSE_LINE=0
[ -z ${VERBOSE_HALT-} ]   && VERBOSE_HALT=0

# DEBUG
[ -z ${DEBUG_ENABLE-} ]   && DEBUG_ENABLE=1
[ -z ${DEBUG_COLOR-} ]    && DEBUG_COLOR=${blue-}
[ -z ${DEBUG_TAG-} ]      && DEBUG_TAG="DEBUG: "
[ -z ${DEBUG_PAUSE-} ]    && DEBUG_PAUSE=0
[ -z ${DEBUG_TRACE-} ]    && DEBUG_TRACE=0
[ -z ${DEBUG_LINE-} ]     && DEBUG_LINE=0
[ -z ${DEBUG_HALT-} ]     && DEBUG_HALT=0

# INFO
[ -z ${INFO_ENABLE-} ]    && INFO_ENABLE=1
[ -z ${INFO_COLOR-} ]     && INFO_COLOR=${white-}
[ -z ${INFO_TAG-} ]       && INFO_TAG="INFO: "
[ -z ${INFO_PAUSE-} ]     && INFO_PAUSE=0
[ -z ${INFO_TRACE-} ]     && INFO_TRACE=0
[ -z ${INFO_LINE-} ]      && INFO_LINE=0
[ -z ${INFO_HALT-} ]      && INFO_HALT=0

# SUCCESS
[ -z ${SUCCESS_ENABLE-} ]  && SUCCESS_ENABLE=1
[ -z ${SUCCESS_COLOR-} ]   && SUCCESS_COLOR=${green-}
[ -z ${SUCCESS_TAG-} ]     && SUCCESS_TAG="SUCCESS: " 
[ -z ${SUCCESS_PAUSE-} ]   && SUCCESS_PAUSE=0
[ -z ${SUCCESS_TRACE-} ]   && SUCCESS_TRACE=0
[ -z ${SUCCESS_LINE-} ]    && SUCCESS_LINE=0
[ -z ${SUCCESS_HALT-} ]    && SUCCESS_HALT=0

# TODO
[ -z ${TODO_ENABLE-} ]    && TODO_ENABLE=1
[ -z ${TODO_COLOR-} ]     && TODO_COLOR=${lblue-}
[ -z ${TODO_TAG-} ]       && TODO_TAG="TODO: "
[ -z ${TODO_PAUSE-} ]     && TODO_PAUSE=1
[ -z ${TODO_TRACE-} ]     && TODO_TRACE=0
[ -z ${TODO_LINE-} ]      && TODO_LINE=0
[ -z ${TODO_HALT-} ]      && TODO_HALT=0

# NOTICE
[ -z ${NOTICE_ENABLE-} ]  && NOTICE_ENABLE=1
[ -z ${NOTICE_COLOR-} ]   && NOTICE_COLOR=${lyellow-}
[ -z ${NOTICE_TAG-} ]     && NOTICE_TAG="NOTICE: " 
[ -z ${NOTICE_PAUSE-} ]   && NOTICE_PAUSE=0
[ -z ${NOTICE_TRACE-} ]   && NOTICE_TRACE=0
[ -z ${NOTICE_LINE-} ]    && NOTICE_LINE=0
[ -z ${NOTICE_HALT-} ]    && NOTICE_HALT=0

# FIXME
[ -z ${FIXME_ENABLE-} ]   && FIXME_ENABLE=1
[ -z ${FIXME_COLOR-} ]    && FIXME_COLOR=${lyellow-}
[ -z ${FIXME_TAG-} ]      && FIXME_TAG="FIXME: "
[ -z ${FIXME_PAUSE-} ]    && FIXME_PAUSE=1
[ -z ${FIXME_TRACE-} ]    && FIXME_TRACE=0
[ -z ${FIXME_LINE-} ]     && FIXME_LINE=0
[ -z ${FIXME_HALT-} ]     && FIXME_HALT=0

# WARNING
[ -z ${WARNING_ENABLE-} ] && WARNING_ENABLE=1
[ -z ${WARNING_COLOR-} ]  && WARNING_COLOR=${yellow-}
[ -z ${WARNING_TAG-} ]    && WARNING_TAG="WARNING: " 
[ -z ${WARNING_PAUSE-} ]  && WARNING_PAUSE=0
[ -z ${WARNING_TRACE-} ]  && WARNING_TRACE=0
[ -z ${WARNING_LINE-} ]   && WARNING_LINE=0
[ -z ${WARNING_HALT-} ]   && WARNING_HALT=0

# ERROR
[ -z ${ERROR_ENABLE-} ]   && ERROR_ENABLE=1
[ -z ${ERROR_COLOR-} ]    && ERROR_COLOR=${lred-}
[ -z ${ERROR_TAG-} ]      && ERROR_TAG="ERROR: "
[ -z ${ERROR_PAUSE-} ]    && ERROR_PAUSE=1
[ -z ${ERROR_TRACE-} ]    && ERROR_TRACE=0
[ -z ${ERROR_LINE-} ]     && ERROR_LINE=0
[ -z ${ERROR_HALT-} ]     && ERROR_HALT=0

# FATAL
[ -z ${FATAL_ENABLE-} ]   && FATAL_ENABLE=1
[ -z ${FATAL_COLOR-} ]    && FATAL_COLOR=${red-}
[ -z ${FATAL_TAG-} ]      && FATAL_TAG="FATAL: "
[ -z ${FATAL_PAUSE-} ]    && FATAL_PAUSE=1
[ -z ${FATAL_TRACE-} ]    && FATAL_TRACE=0
[ -z ${FATAL_LINE-} ]     && FATAL_LINE=0
[ -z ${FATAL_HALT-} ]     && FATAL_HALT=1
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

[ -z ${dk_log_ENABLE-} ]  && dk_log_ENABLE=1

###### level order ######
#	0 VERBOSE    dk_verbose
#	1 DEBUG      dk_debug
#	  DEFAULT	 dk_default
#	2 INFO       dk_info
#	3 SUCCESS    dk_success
#	4 TODO       dk_todo
#	5 NOTICE     dk_notice
#	6 FIXME      dk_fixme
#	7 WARNING    dk_warning
#	8 DEPRECATED dk_deprecated
#	9 ERROR      dk_error
#  10 FATAL      dk_fatal

###### option order ######
#   ENABLE
#   COLOR
#   TAG
#   TRACE
#   LINE
#   SOUND
#   TIMEOUT
#   PAUSE
#   HALT

# VERBOSE
[ -z ${dk_log_VERBOSE_ENABLE-} ]		&& dk_log_VERBOSE_ENABLE=1
[ -z ${dk_log_VERBOSE_COLOR-} ]			&& dk_log_VERBOSE_COLOR=${magenta-}
[ -z ${dk_log_VERBOSE_TAG-} ]			&& dk_log_VERBOSE_TAG="VERBOSE: "
[ -z ${dk_log_VERBOSE_TRACE-} ]			&& dk_log_VERBOSE_TRACE=0
[ -z ${dk_log_VERBOSE_LINE-} ]			&& dk_log_VERBOSE_LINE=0
[ -z ${dk_log_VERBOSE_TIMEOUT-} ]		&& dk_log_VERBOSE_TIMEOUT=0
[ -z ${dk_log_VERBOSE_PAUSE-} ]			&& dk_log_VERBOSE_PAUSE=0
[ -z ${dk_log_VERBOSE_HALT-} ]			&& dk_log_VERBOSE_HALT=0

# DEBUG
[ -z ${dk_log_DEBUG_ENABLE-} ]			&& dk_log_DEBUG_ENABLE=1
[ -z ${dk_log_DEBUG_COLOR-} ]			&& dk_log_DEBUG_COLOR=${blue-}
[ -z ${dk_log_DEBUG_TAG-} ]				&& dk_log_DEBUG_TAG="DEBUG: "
[ -z ${dk_log_DEBUG_TRACE-} ]			&& dk_log_DEBUG_TRACE=0
[ -z ${dk_log_DEBUG_LINE-} ]			&& dk_log_DEBUG_LINE=0
[ -z ${dk_log_DEBUG_TIMEOUT-} ]			&& dk_log_DEBUG_TIMEOUT=0
[ -z ${dk_log_DEBUG_PAUSE-} ]			&& dk_log_DEBUG_PAUSE=0
[ -z ${dk_log_DEBUG_HALT-} ]			&& dk_log_DEBUG_HALT=0

# DEFAULT
[ -z ${dk_log_DEFAULT_ENABLE-} ]		&& dk_log_DEFAULT_ENABLE=1
[ -z ${dk_log_DEFAULT_COLOR-} ]			&& dk_log_DEFAULT_COLOR=${white-}
[ -z ${dk_log_DEFAULT_TAG-} ]			&& dk_log_DEFAULT_TAG=""
[ -z ${dk_log_DEFAULT_TRACE-} ]			&& dk_log_DEFAULT_TRACE=0
[ -z ${dk_log_DEFAULT_LINE-} ]			&& dk_log_DEFAULT_LINE=0
[ -z ${dk_log_DEFAULT_TIMEOUT-} ]		&& dk_log_DEFAULT_TIMEOUT=0
[ -z ${dk_log_DEFAULT_PAUSE-} ]			&& dk_log_DEFAULT_PAUSE=0
[ -z ${dk_log_DEFAULT_HALT-} ]			&& dk_log_DEFAULT_HALT=0

# INFO
[ -z ${dk_log_INFO_ENABLE-} ]			&& dk_log_INFO_ENABLE=1
[ -z ${dk_log_INFO_COLOR-} ]			&& dk_log_INFO_COLOR=${white-}
[ -z ${dk_log_INFO_TAG-} ] 				&& dk_log_INFO_TAG="INFO: "
[ -z ${dk_log_INFO_TRACE-} ]			&& dk_log_INFO_TRACE=0
[ -z ${dk_log_INFO_LINE-} ]				&& dk_log_INFO_LINE=0
[ -z ${dk_log_INFO_TIMEOUT-} ]			&& dk_log_INFO_TIMEOUT=0
[ -z ${dk_log_INFO_PAUSE-} ]			&& dk_log_INFO_PAUSE=0
[ -z ${dk_log_INFO_HALT-} ]				&& dk_log_INFO_HALT=0

# SUCCESS
[ -z ${dk_log_SUCCESS_ENABLE-} ]		&& dk_log_SUCCESS_ENABLE=1
[ -z ${dk_log_SUCCESS_COLOR-} ]			&& dk_log_SUCCESS_COLOR=${green-}
[ -z ${dk_log_SUCCESS_TAG-} ]			&& dk_log_SUCCESS_TAG="SUCCESS: "
[ -z ${dk_log_SUCCESS_TRACE-} ]			&& dk_log_SUCCESS_TRACE=0
[ -z ${dk_log_SUCCESS_LINE-} ]			&& dk_log_SUCCESS_LINE=0
[ -z ${dk_log_SUCCESS_TIMEOUT-} ]		&& dk_log_SUCCESS_TIMEOUT=0
[ -z ${dk_log_SUCCESS_PAUSE-} ]			&& dk_log_SUCCESS_PAUSE=0
[ -z ${dk_log_SUCCESS_HALT-} ]			&& dk_log_SUCCESS_HALT=0

# TODO
[ -z ${dk_log_TODO_ENABLE-} ]			&& dk_log_TODO_ENABLE=1
[ -z ${dk_log_TODO_COLOR-} ]			&& dk_log_TODO_COLOR=${lblue-}
[ -z ${dk_log_TODO_TAG-} ] 				&& dk_log_TODO_TAG="TODO: "
[ -z ${dk_log_TODO_TRACE-} ]			&& dk_log_TODO_TRACE=0
[ -z ${dk_log_TODO_LINE-} ]				&& dk_log_TODO_LINE=0
[ -z ${dk_log_TODO_TIMEOUT-} ]			&& dk_log_TODO_TIMEOUT=1
[ -z ${dk_log_TODO_PAUSE-} ]			&& dk_log_TODO_PAUSE=0
[ -z ${dk_log_TODO_HALT-} ]				&& dk_log_TODO_HALT=0

# NOTICE
[ -z ${dk_log_NOTICE_ENABLE-} ]			&& dk_log_NOTICE_ENABLE=1
[ -z ${dk_log_NOTICE_COLOR-} ]			&& dk_log_NOTICE_COLOR=${lyellow-}
[ -z ${dk_log_NOTICE_TAG-} ]			&& dk_log_NOTICE_TAG="NOTICE: "
[ -z ${dk_log_NOTICE_TRACE-} ]			&& dk_log_NOTICE_TRACE=0
[ -z ${dk_log_NOTICE_LINE-} ]			&& dk_log_NOTICE_LINE=0
[ -z ${dk_log_NOTICE_TIMEOUT-} ]		&& dk_log_NOTICE_TIMEOUT=0
[ -z ${dk_log_NOTICE_PAUSE-} ]			&& dk_log_NOTICE_PAUSE=0
[ -z ${dk_log_NOTICE_HALT-} ]			&& dk_log_NOTICE_HALT=0

# FIXME
[ -z ${dk_log_FIXME_ENABLE-} ]			&& dk_log_FIXME_ENABLE=1
[ -z ${dk_log_FIXME_COLOR-} ]			&& dk_log_FIXME_COLOR=${lyellow-}
[ -z ${dk_log_FIXME_TAG-} ]				&& dk_log_FIXME_TAG="FIXME: "
[ -z ${dk_log_FIXME_TRACE-} ]			&& dk_log_FIXME_TRACE=0
[ -z ${dk_log_FIXME_LINE-} ]			&& dk_log_FIXME_LINE=0
[ -z ${dk_log_FIXME_TIMEOUT-} ]			&& dk_log_FIXME_TIMEOUT=3
[ -z ${dk_log_FIXME_PAUSE-} ]			&& dk_log_FIXME_PAUSE=0
[ -z ${dk_log_FIXME_HALT-} ]			&& dk_log_FIXME_HALT=0

# WARNING
[ -z ${dk_log_WARNING_ENABLE-} ]		&& dk_log_WARNING_ENABLE=1
[ -z ${dk_log_WARNING_COLOR-} ]			&& dk_log_WARNING_COLOR=${yellow-}
[ -z ${dk_log_WARNING_TAG-} ]			&& dk_log_WARNING_TAG="WARNING: "
[ -z ${dk_log_WARNING_TRACE-} ]			&& dk_log_WARNING_TRACE=0
[ -z ${dk_log_WARNING_LINE-} ]			&& dk_log_WARNING_LINE=0
[ -z ${dk_log_WARNING_TIMEOUT-} ]		&& dk_log_WARNING_TIMEOUT=0
[ -z ${dk_log_WARNING_PAUSE-} ]			&& dk_log_WARNING_PAUSE=0
[ -z ${dk_log_WARNING_HALT-} ]			&& dk_log_WARNING_HALT=0

# DEPRECATED
[ -z ${dk_log_DEPRECATED_ENABLE-} ]		&& dk_log_DEPRECATED_ENABLE=1
[ -z ${dk_log_DEPRECATED_COLOR-} ]		&& dk_log_DEPRECATED_COLOR=${yellow-}
[ -z ${dk_log_DEPRECATED_TAG-} ]		&& dk_log_DEPRECATED_TAG="DEPRECATED: "
[ -z ${dk_log_DEPRECATED_TRACE-} ]		&& dk_log_DEPRECATED_TRACE=0
[ -z ${dk_log_DEPRECATED_LINE-} ]		&& dk_log_DEPRECATED_LINE=0
[ -z ${dk_log_DEPRECATED_TIMEOUT-} ]	&& dk_log_DEPRECATED_TIMEOUT=0
[ -z ${dk_log_DEPRECATED_PAUSE-} ]		&& dk_log_DEPRECATED_PAUSE=0
[ -z ${dk_log_DEPRECATED_HALT-} ]		&& dk_log_DEPRECATED_HALT=0

# ERROR
[ -z ${dk_log_ERROR_ENABLE-} ]			&& dk_log_ERROR_ENABLE=1
[ -z ${dk_log_ERROR_COLOR-} ]			&& dk_log_ERROR_COLOR=${lred-}
[ -z ${dk_log_ERROR_TAG-} ]				&& dk_log_ERROR_TAG="ERROR: "
[ -z ${dk_log_ERROR_TRACE-} ]			&& dk_log_ERROR_TRACE=1
[ -z ${dk_log_ERROR_LINE-} ]			&& dk_log_ERROR_LINE=0
[ -z ${dk_log_ERROR_TIMEOUT-} ]			&& dk_log_ERROR_TIMEOUT=3
[ -z ${dk_log_ERROR_PAUSE-} ]			&& dk_log_ERROR_PAUSE=0
[ -z ${dk_log_ERROR_HALT-} ]			&& dk_log_ERROR_HALT=0

# FATAL
[ -z ${dk_log_FATAL_ENABLE-} ]			&& dk_log_FATAL_ENABLE=1
[ -z ${dk_log_FATAL_COLOR-} ]			&& dk_log_FATAL_COLOR=${red-}
[ -z ${dk_log_FATAL_TAG-} ]				&& dk_log_FATAL_TAG="FATAL: "
[ -z ${dk_log_FATAL_TRACE-} ]			&& dk_log_FATAL_TRACE=1
[ -z ${dk_log_FATAL_LINE-} ]			&& dk_log_FATAL_LINE=0
[ -z ${dk_log_FATAL_TIMEOUT-} ]			&& dk_log_FATAL_TIMEOUT=9
[ -z ${dk_log_FATAL_PAUSE-} ]			&& dk_log_FATAL_PAUSE=0
[ -z ${dk_log_FATAL_HALT-} ]			&& dk_log_FATAL_HALT=0
>>>>>>> Development

##################################################################################
# dk_log(message)
# dk_log(level, message)
#
#	Print a log message to the console
#
#	@level		- The log level 
#	@message	- The message to print
#
dk_log() {
	dk_debugFunc 1 2

<<<<<<< HEAD
	[ ${ENABLE_dk_log-1} -ne 1 ] && return
	
	[ $(__ARGC__ 1) -eq 1 ] && _level_="DEFAULT" && _message_="$1"
	[ $(__ARGC__ 1) -eq 2 ] && _level_=$1 && _message_="$2"
	level_ENABLE=${_level_}_ENABLE
	level_COLOR=${_level_}_COLOR
	level_PAUSE=${_level_}_PAUSE
	level_TAG=${_level_}_TAG
	level_TRACE=${_level_}_TRACE
	level_LINE=${_level_}_LINE
	level_HALT=${_level_}_HALT
	[ -n "${!level_ENABLE+1}" ] && [ "${!level_ENABLE-}" -ne "1" ] && return
	
	dk_echo "${!level_COLOR}${!level_TAG-}${_message_}${clr}"
	#[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
	
	[ ${!level_TRACE} -eq 1 ] && dk_echo "${!level_COLOR}*** TRACE_ON_${_level_} ***${clr}" && dk_call dk_stacktrace; true #OR TRACE AND NOT NO_TRACE)
	[ ${!level_LINE} -eq 1 ]  && dk_echo "${!level_COLOR}*** LINE_ON_${_level_} ***${clr}"  && dk_call dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}"; true #OR HALT AND NOT NO_HALT)
	[ ${!level_PAUSE} -eq 1 ] && dk_echo "${!level_COLOR}*** PAUSE_ON_${_level_} ***${clr}" && dk_call dk_pause; true #OR PAUSE AND NOT NO_PAUSE)
	[ ${!level_HALT} -eq 1 ]  && dk_echo "${!level_COLOR}*** HALT_ON_${_level_} ***${clr}"  && dk_call dk_exit 0; true #OR HALT AND NOT NO_HALT)
=======
	[ ${dk_log_ENABLE-1} -ne 1 ] && return
	
	[ $(__ARGC__ 1) -eq 1 ] && _level_="DEFAULT" && _message_="$1"
	[ $(__ARGC__ 1) -eq 2 ] && _level_=$1 && _message_="$2"
	level_ENABLE=dk_log_${_level_}_ENABLE
	level_COLOR=dk_log_${_level_}_COLOR
	level_TAG=dk_log_${_level_}_TAG
	level_TRACE=dk_log_${_level_}_TRACE
	level_LINE=dk_log_${_level_}_LINE
	level_SOUND=dk_log_${_level_}_SOUND
	level_TIMEOUT=dk_log_${_level_}_TIMEOUT
	level_PAUSE=dk_log_${_level_}_PAUSE
	level_HALT=dk_log_${_level_}_HALT
	[ -n "${!level_ENABLE+1}" ] && [ "${!level_ENABLE-}" -ne "1" ] && return
	
	###### ECHO MESSAGE ######
	dk_echo "${!level_COLOR}${!level_TAG-}${_message_}${clr}"
	#[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
	
	###### TRACE ######
	[ ${!level_TRACE} -eq 1 ] && dk_echo "${!level_COLOR}*** TRACE_ON_${_level_} ***${clr}" && dk_call dk_stacktrace; true
	
	###### LINE ######
	[ ${!level_LINE} -eq 1 ]  && dk_echo "${!level_COLOR}*** LINE_ON_${_level_} ***${clr}"  && dk_call dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}"; true
	
	###### SOUND ######
	[ ${!level_SOUND} -ne 0 ] && dk_echo "${!level_COLOR}*** SOUND_ON_${_level_} ***${clr}" && true #dk_call dk_stacktrace; true
	
	###### TIMEOUT ######
	[ ${!level_TIMEOUT} -gt 0 ] && dk_echo "${!level_COLOR}*** TIMEOUT_ON_${_level_} ***${clr}" && dk_call dk_timeout ${!level_TIMEOUT}; true
	
	###### PAUSE ######
	[ ${!level_PAUSE} -eq 1 ] && dk_echo "${!level_COLOR}*** PAUSE_ON_${_level_} ***${clr}" && dk_call dk_pause; true
	
	###### HALT ######
	[ ${!level_HALT} -eq 1 ]  && dk_echo "${!level_COLOR}*** HALT_ON_${_level_} ***${clr}"  && dk_call dk_exit 0; true
>>>>>>> Development
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
<<<<<<< HEAD
	
	dk_log "test dk_log message"
	
	dk_log VERBOSE "test dk_log VERBOSE message"
    dk_log DEBUG   "test dk_log DEBUG message"
    dk_log INFO    "test dk_log INFO message"
    dk_log SUCCESS "test dk_log SUCCESS message"
    dk_log TODO    "test dk_log TODO message"
    dk_log NOTICE  "test dk_log NOTICE message"
    dk_log FIXME   "test dk_log FIXME message"
    dk_log WARNING "test dk_log WARNING message"
    dk_log ERROR   "test dk_log ERROR message"
    dk_log FATAL   "test dk_log FATAL message"
=======

	dk_log VERBOSE		"test dk_log VERBOSE message"
	dk_log DEBUG		"test dk_log DEBUG message"
	dk_log				"test dk_log message"
	dk_log INFO			"test dk_log INFO message"
	dk_log SUCCESS		"test dk_log SUCCESS message"
	dk_log TODO			"test dk_log TODO message"
	dk_log NOTICE		"test dk_log NOTICE message"
	dk_log FIXME		"test dk_log FIXME message"
	dk_log WARNING		"test dk_log WARNING message"
	dk_log DEPRECATED	"test dk_log DEPRECATED message"
	dk_log ERROR		"test dk_log ERROR message"
	dk_log FATAL		"test dk_log FATAL message"
>>>>>>> Development
}
