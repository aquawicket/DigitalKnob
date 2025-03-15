#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

[ -z ${dk_log_ENABLE-} ]  && dk_log_ENABLE=1

#  0 VERBOSE    dk_verbose
#  1 DEBUG      dk_debug
#  2 INFO       dk_info
#  3 SUCCESS    dk_success
#  4 TODO       dk_todo
#  5 NOTICE     dk_notice
#  6 FIXME      dk_fixme
#  7 WARNING    dk_warning
#  8 DEPRECATED dk_deprecated
#  9 ERROR      dk_error
# 10 FATAL      dk_fatal

# DEFAULT
[ -z ${dk_log_DEFAULT_ENABLE-} ]		&& dk_log_DEFAULT_ENABLE=1
[ -z ${dk_log_DEFAULT_COLOR-} ]			&& dk_log_DEFAULT_COLOR=${white-}
[ -z ${dk_log_DEFAULT_TAG-} ]			&& dk_log_DEFAULT_TAG=""
[ -z ${dk_log_DEFAULT_TRACE-} ]			&& dk_log_DEFAULT_TRACE=0
[ -z ${dk_log_DEFAULT_LINE-} ]			&& dk_log_DEFAULT_LINE=0
[ -z ${dk_log_DEFAULT_PAUSE-} ]			&& dk_log_DEFAULT_PAUSE=0
[ -z ${dk_log_DEFAULT_TIMEOUT-} ]		&& dk_log_DEFAULT_TIMEOUT=0
[ -z ${dk_log_DEFAULT_HALT-} ]			&& dk_log_DEFAULT_HALT=0

# VERBOSE
[ -z ${dk_log_VERBOSE_ENABLE-} ]		&& dk_log_VERBOSE_ENABLE=1
[ -z ${dk_log_VERBOSE_COLOR-} ]			&& dk_log_VERBOSE_COLOR=${magenta-}
[ -z ${dk_log_VERBOSE_TAG-} ]			&& dk_log_VERBOSE_TAG="VERBOSE: "
[ -z ${dk_log_VERBOSE_TRACE-} ]			&& dk_log_VERBOSE_TRACE=0
[ -z ${dk_log_VERBOSE_LINE-} ]			&& dk_log_VERBOSE_LINE=0
[ -z ${dk_log_VERBOSE_PAUSE-} ]			&& dk_log_VERBOSE_PAUSE=0
[ -z ${dk_log_VERBOSE_TIMEOUT-} ]		&& dk_log_VERBOSE_TIMEOUT=0
[ -z ${dk_log_VERBOSE_HALT-} ]			&& dk_log_VERBOSE_HALT=0

# DEBUG
[ -z ${dk_log_DEBUG_ENABLE-} ]			&& dk_log_DEBUG_ENABLE=1
[ -z ${dk_log_DEBUG_COLOR-} ]			&& dk_log_DEBUG_COLOR=${blue-}
[ -z ${dk_log_DEBUG_TAG-} ]				&& dk_log_DEBUG_TAG="DEBUG: "
[ -z ${dk_log_DEBUG_TRACE-} ]			&& dk_log_DEBUG_TRACE=0
[ -z ${dk_log_DEBUG_LINE-} ]			&& dk_log_DEBUG_LINE=0
[ -z ${dk_log_DEBUG_PAUSE-} ]			&& dk_log_DEBUG_PAUSE=0
[ -z ${dk_log_DEBUG_TIMEOUT-} ]			&& dk_log_DEBUG_TIMEOUT=0
[ -z ${dk_log_DEBUG_HALT-} ]			&& dk_log_DEBUG_HALT=0

# INFO
[ -z ${dk_log_INFO_ENABLE-} ]			&& dk_log_INFO_ENABLE=1
[ -z ${dk_log_INFO_COLOR-} ]			&& dk_log_INFO_COLOR=${white-}
[ -z ${dk_log_INFO_TAG-} ] 				&& dk_log_INFO_TAG="INFO: "
[ -z ${dk_log_INFO_TRACE-} ]			&& dk_log_INFO_TRACE=0
[ -z ${dk_log_INFO_LINE-} ]				&& dk_log_INFO_LINE=0
[ -z ${dk_log_INFO_PAUSE-} ]			&& dk_log_INFO_PAUSE=0
[ -z ${dk_log_INFO_TIMEOUT-} ]			&& dk_log_INFO_TIMEOUT=0
[ -z ${dk_log_INFO_HALT-} ]				&& dk_log_INFO_HALT=0

# SUCCESS
[ -z ${dk_log_SUCCESS_ENABLE-} ]		&& dk_log_SUCCESS_ENABLE=1
[ -z ${dk_log_SUCCESS_COLOR-} ]			&& dk_log_SUCCESS_COLOR=${green-}
[ -z ${dk_log_SUCCESS_TAG-} ]			&& dk_log_SUCCESS_TAG="SUCCESS: "
[ -z ${dk_log_SUCCESS_TRACE-} ]			&& dk_log_SUCCESS_TRACE=0
[ -z ${dk_log_SUCCESS_LINE-} ]			&& dk_log_SUCCESS_LINE=0
[ -z ${dk_log_SUCCESS_PAUSE-} ]			&& dk_log_SUCCESS_PAUSE=0
[ -z ${dk_log_SUCCESS_TIMEOUT-} ]		&& dk_log_SUCCESS_TIMEOUT=0
[ -z ${dk_log_SUCCESS_HALT-} ]			&& dk_log_SUCCESS_HALT=0

# TODO
[ -z ${dk_log_TODO_ENABLE-} ]			&& dk_log_TODO_ENABLE=1
[ -z ${dk_log_TODO_COLOR-} ]			&& dk_log_TODO_COLOR=${lblue-}
[ -z ${dk_log_TODO_TAG-} ] 				&& dk_log_TODO_TAG="TODO: "
[ -z ${dk_log_TODO_TRACE-} ]			&& dk_log_TODO_TRACE=0
[ -z ${dk_log_TODO_LINE-} ]				&& dk_log_TODO_LINE=0
[ -z ${dk_log_TODO_PAUSE-} ]			&& dk_log_TODO_PAUSE=0
[ -z ${dk_log_TODO_TIMEOUT-} ]			&& dk_log_TODO_TIMEOUT=1
[ -z ${dk_log_TODO_HALT-} ]				&& dk_log_TODO_HALT=0

# NOTICE
[ -z ${dk_log_NOTICE_ENABLE-} ]			&& dk_log_NOTICE_ENABLE=1
[ -z ${dk_log_NOTICE_COLOR-} ]			&& dk_log_NOTICE_COLOR=${lyellow-}
[ -z ${dk_log_NOTICE_TAG-} ]			&& dk_log_NOTICE_TAG="NOTICE: "
[ -z ${dk_log_NOTICE_TRACE-} ]			&& dk_log_NOTICE_TRACE=0
[ -z ${dk_log_NOTICE_LINE-} ]			&& dk_log_NOTICE_LINE=0
[ -z ${dk_log_NOTICE_PAUSE-} ]			&& dk_log_NOTICE_PAUSE=0
[ -z ${dk_log_NOTICE_TIMEOUT-} ]		&& dk_log_NOTICE_TIMEOUT=0
[ -z ${dk_log_NOTICE_HALT-} ]			&& dk_log_NOTICE_HALT=0

# FIXME
[ -z ${dk_log_FIXME_ENABLE-} ]			&& dk_log_FIXME_ENABLE=1
[ -z ${dk_log_FIXME_COLOR-} ]			&& dk_log_FIXME_COLOR=${lyellow-}
[ -z ${dk_log_FIXME_TAG-} ]				&& dk_log_FIXME_TAG="FIXME: "
[ -z ${dk_log_FIXME_TRACE-} ]			&& dk_log_FIXME_TRACE=0
[ -z ${dk_log_FIXME_LINE-} ]			&& dk_log_FIXME_LINE=0
[ -z ${dk_log_FIXME_PAUSE-} ]			&& dk_log_FIXME_PAUSE=0
[ -z ${dk_log_FIXME_TIMEOUT-} ]			&& dk_log_FIXME_TIMEOUT=30
[ -z ${dk_log_FIXME_HALT-} ]			&& dk_log_FIXME_HALT=0

# WARNING
[ -z ${dk_log_WARNING_ENABLE-} ]		&& dk_log_WARNING_ENABLE=1
[ -z ${dk_log_WARNING_COLOR-} ]			&& dk_log_WARNING_COLOR=${yellow-}
[ -z ${dk_log_WARNING_TAG-} ]			&& dk_log_WARNING_TAG="WARNING: "
[ -z ${dk_log_WARNING_TRACE-} ]			&& dk_log_WARNING_TRACE=0
[ -z ${dk_log_WARNING_LINE-} ]			&& dk_log_WARNING_LINE=0
[ -z ${dk_log_WARNING_PAUSE-} ]			&& dk_log_WARNING_PAUSE=0
[ -z ${dk_log_WARNING_TIMEOUT-} ]		&& dk_log_WARNING_TIMEOUT=0
[ -z ${dk_log_WARNING_HALT-} ]			&& dk_log_WARNING_HALT=0

# DEPRECATED
[ -z ${dk_log_DEPRECATED_ENABLE-} ]		&& dk_log_DEPRECATED_ENABLE=1
[ -z ${dk_log_DEPRECATED_COLOR-} ]		&& dk_log_DEPRECATED_COLOR=${yellow-}
[ -z ${dk_log_DEPRECATED_TAG-} ]		&& dk_log_DEPRECATED_TAG="DEPRECATED: "
[ -z ${dk_log_DEPRECATED_TRACE-} ]		&& dk_log_DEPRECATED_TRACE=1
[ -z ${dk_log_DEPRECATED_LINE-} ]		&& dk_log_DEPRECATED_LINE=0
[ -z ${dk_log_DEPRECATED_PAUSE-} ]		&& dk_log_DEPRECATED_PAUSE=1
[ -z ${dk_log_DEPRECATED_TIMEOUT-} ]	&& dk_log_DEPRECATED_TIMEOUT=0
[ -z ${dk_log_DEPRECATED_HALT-} ]		&& dk_log_DEPRECATED_HALT=0

# ERROR
[ -z ${dk_log_ERROR_ENABLE-} ]			&& dk_log_ERROR_ENABLE=1
[ -z ${dk_log_ERROR_COLOR-} ]			&& dk_log_ERROR_COLOR=${lred-}
[ -z ${dk_log_ERROR_TAG-} ]				&& dk_log_ERROR_TAG="ERROR: "
[ -z ${dk_log_ERROR_TRACE-} ]			&& dk_log_ERROR_TRACE=1
[ -z ${dk_log_ERROR_LINE-} ]			&& dk_log_ERROR_LINE=0
[ -z ${dk_log_ERROR_PAUSE-} ]			&& dk_log_ERROR_PAUSE=0
[ -z ${dk_log_ERROR_TIMEOUT-} ]			&& dk_log_ERROR_TIMEOUT=3
[ -z ${dk_log_ERROR_HALT-} ]			&& dk_log_ERROR_HALT=0

# FATAL
[ -z ${dk_log_FATAL_ENABLE-} ]			&& dk_log_FATAL_ENABLE=1
[ -z ${dk_log_FATAL_COLOR-} ]			&& dk_log_FATAL_COLOR=${red-}
[ -z ${dk_log_FATAL_TAG-} ]				&& dk_log_FATAL_TAG="FATAL: "
[ -z ${dk_log_FATAL_TRACE-} ]			&& dk_log_FATAL_TRACE=1
[ -z ${dk_log_FATAL_LINE-} ]			&& dk_log_FATAL_LINE=0
[ -z ${dk_log_FATAL_PAUSE-} ]			&& dk_log_FATAL_PAUSE=0
[ -z ${dk_log_FATAL_TIMEOUT-} ]			&& dk_log_FATAL_TIMEOUT=9
[ -z ${dk_log_FATAL_HALT-} ]			&& dk_log_FATAL_HALT=0

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

	[ ${dk_log_ENABLE-1} -ne 1 ] && return
	
	[ $(__ARGC__ 1) -eq 1 ] && _level_="DEFAULT" && _message_="$1"
	[ $(__ARGC__ 1) -eq 2 ] && _level_=$1 && _message_="$2"
	level_ENABLE=dk_log_${_level_}_ENABLE
	level_COLOR=dk_log_${_level_}_COLOR
	level_TAG=dk_log_${_level_}_TAG
	level_TRACE=dk_log_${_level_}_TRACE
	level_LINE=dk_log_${_level_}_LINE
	level_PAUSE=dk_log_${_level_}_PAUSE
	level_TIMEOUT=dk_log_${_level_}_TIMEOUT
	level_HALT=dk_log_${_level_}_HALT
	[ -n "${!level_ENABLE+1}" ] && [ "${!level_ENABLE-}" -ne "1" ] && return
	
	dk_echo "${!level_COLOR}${!level_TAG-}${_message_}${clr}"
	#[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
	
	[ ${!level_TRACE} -eq 1 ] && dk_echo "${!level_COLOR}*** TRACE_ON_${_level_} ***${clr}" && dk_call dk_stacktrace; true #OR TRACE AND NOT NO_TRACE)
	[ ${!level_LINE} -eq 1 ]  && dk_echo "${!level_COLOR}*** LINE_ON_${_level_} ***${clr}"  && dk_call dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}"; true #OR HALT AND NOT NO_HALT)
	[ ${!level_PAUSE} -eq 1 ] && dk_echo "${!level_COLOR}*** PAUSE_ON_${_level_} ***${clr}" && dk_call dk_pause; true #OR PAUSE AND NOT NO_PAUSE)
	[ ${!level_TIMEOUT} -gt 0 ] && dk_echo "${!level_COLOR}*** TIMEOUT_ON_${_level_} ***${clr}" && dk_call dk_timeout ${!level_TIMEOUT}; true #OR PAUSE AND NOT NO_PAUSE)
	
	[ ${!level_HALT} -eq 1 ]  && dk_echo "${!level_COLOR}*** HALT_ON_${_level_} ***${clr}"  && dk_call dk_exit 0; true #OR HALT AND NOT NO_HALT)
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0

	dk_log "test dk_log message"

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
}
