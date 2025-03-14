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
#  8 ERROR      dk_error
#  9 FATAL      dk_fatal

# DEFAULT
[ -z ${DEFAULT_ENABLE-} ] 	&& DEFAULT_ENABLE=1
[ -z ${DEFAULT_COLOR-} ]  	&& DEFAULT_COLOR=${white-}
[ -z ${DEFAULT_TAG-} ]    	&& DEFAULT_TAG=""
[ -z ${DEFAULT_TRACE-} ]  	&& DEFAULT_TRACE=0
[ -z ${DEFAULT_LINE-} ]   	&& DEFAULT_LINE=0
[ -z ${DEFAULT_PAUSE-} ]  	&& DEFAULT_PAUSE=0
[ -z ${DEFAULT_TIMEOUT-} ]	&& DEFAULT_TIMEOUT=0
[ -z ${DEFAULT_HALT-} ]   	&& DEFAULT_HALT=0

# VERBOSE
[ -z ${dk_log_VERBOSE_ENABLE-} ] 	&& dk_log_VERBOSE_ENABLE=1
[ -z ${dk_log_VERBOSE_COLOR-} ]  	&& dk_log_VERBOSE_COLOR=${magenta-}
[ -z ${dk_log_VERBOSE_TAG-} ]    	&& dk_log_VERBOSE_TAG="VERBOSE: "
[ -z ${dk_log_VERBOSE_TRACE-} ]  	&& dk_log_VERBOSE_TRACE=0
[ -z ${dk_log_VERBOSE_LINE-} ]   	&& dk_log_VERBOSE_LINE=0
[ -z ${dk_log_VERBOSE_PAUSE-} ]  	&& dk_log_VERBOSE_PAUSE=0
[ -z ${dk_log_VERBOSE_TIMEOUT-} ] 	&& dk_log_VERBOSE_TIMEOUT=0
[ -z ${dk_log_VERBOSE_HALT-} ]   	&& dk_log_VERBOSE_HALT=0

# DEBUG
[ -z ${DEBUG_ENABLE-} ]   	&& DEBUG_ENABLE=1
[ -z ${DEBUG_COLOR-} ]    	&& DEBUG_COLOR=${blue-}
[ -z ${DEBUG_TAG-} ]      	&& DEBUG_TAG="DEBUG: "
[ -z ${DEBUG_TRACE-} ]    	&& DEBUG_TRACE=0
[ -z ${DEBUG_LINE-} ]     	&& DEBUG_LINE=0
[ -z ${DEBUG_PAUSE-} ]    	&& DEBUG_PAUSE=0
[ -z ${DEBUG_TIMEOUT-} ]   	&& DEBUG_TIMEOUT=0
[ -z ${DEBUG_HALT-} ]     	&& DEBUG_HALT=0

# INFO
[ -z ${INFO_ENABLE-} ]    	&& INFO_ENABLE=1
[ -z ${INFO_COLOR-} ]     	&& INFO_COLOR=${white-}
[ -z ${INFO_TAG-} ]       	&& INFO_TAG="INFO: "
[ -z ${INFO_TRACE-} ]     	&& INFO_TRACE=0
[ -z ${INFO_LINE-} ]      	&& INFO_LINE=0
[ -z ${INFO_PAUSE-} ]     	&& INFO_PAUSE=0
[ -z ${INFO_TIMEOUT-} ]    	&& INFO_TIMEOUT=0
[ -z ${INFO_HALT-} ]      	&& INFO_HALT=0

# SUCCESS
[ -z ${SUCCESS_ENABLE-} ]  	&& SUCCESS_ENABLE=1
[ -z ${SUCCESS_COLOR-} ]   	&& SUCCESS_COLOR=${green-}
[ -z ${SUCCESS_TAG-} ]     	&& SUCCESS_TAG="SUCCESS: "
[ -z ${SUCCESS_TRACE-} ]   	&& SUCCESS_TRACE=0
[ -z ${SUCCESS_LINE-} ]    	&& SUCCESS_LINE=0
[ -z ${SUCCESS_PAUSE-} ]   	&& SUCCESS_PAUSE=0
[ -z ${SUCCESS_TIMEOUT-} ] 	&& SUCCESS_TIMEOUT=0
[ -z ${SUCCESS_HALT-} ]    	&& SUCCESS_HALT=0

# TODO
[ -z ${TODO_ENABLE-} ]    	&& TODO_ENABLE=1
[ -z ${TODO_COLOR-} ]     	&& TODO_COLOR=${lblue-}
[ -z ${TODO_TAG-} ]       	&& TODO_TAG="TODO: "
[ -z ${TODO_TRACE-} ]     	&& TODO_TRACE=0
[ -z ${TODO_LINE-} ]      	&& TODO_LINE=0
[ -z ${TODO_PAUSE-} ]     	&& TODO_PAUSE=0
[ -z ${TODO_TIMEOUT-} ]    	&& TODO_TIMEOUT=1
[ -z ${TODO_HALT-} ]      	&& TODO_HALT=0

# NOTICE
[ -z ${NOTICE_ENABLE-} ]  	&& NOTICE_ENABLE=1
[ -z ${NOTICE_COLOR-} ]   	&& NOTICE_COLOR=${lyellow-}
[ -z ${NOTICE_TAG-} ]     	&& NOTICE_TAG="NOTICE: "
[ -z ${NOTICE_TRACE-} ]   	&& NOTICE_TRACE=0
[ -z ${NOTICE_LINE-} ]    	&& NOTICE_LINE=0
[ -z ${NOTICE_PAUSE-} ]   	&& NOTICE_PAUSE=0
[ -z ${NOTICE_TIMEOUT-} ]  	&& NOTICE_TIMEOUT=0
[ -z ${NOTICE_HALT-} ]    	&& NOTICE_HALT=0

# FIXME
[ -z ${FIXME_ENABLE-} ]   	&& FIXME_ENABLE=1
[ -z ${FIXME_COLOR-} ]    	&& FIXME_COLOR=${lyellow-}
[ -z ${FIXME_TAG-} ]      	&& FIXME_TAG="FIXME: "
[ -z ${FIXME_TRACE-} ]    	&& FIXME_TRACE=0
[ -z ${FIXME_LINE-} ]     	&& FIXME_LINE=0
[ -z ${FIXME_PAUSE-} ]    	&& FIXME_PAUSE=0
[ -z ${FIXME_TIMEOUT-} ]   	&& FIXME_TIMEOUT=30
[ -z ${FIXME_HALT-} ]     	&& FIXME_HALT=0

# WARNING
[ -z ${WARNING_ENABLE-} ] 	&& WARNING_ENABLE=1
[ -z ${WARNING_COLOR-} ]  	&& WARNING_COLOR=${yellow-}
[ -z ${WARNING_TAG-} ]    	&& WARNING_TAG="WARNING: "
[ -z ${WARNING_TRACE-} ]  	&& WARNING_TRACE=0
[ -z ${WARNING_LINE-} ]   	&& WARNING_LINE=0
[ -z ${WARNING_PAUSE-} ]  	&& WARNING_PAUSE=0
[ -z ${WARNING_TIMEOUT-} ] 	&& WARNING_TIMEOUT=0
[ -z ${WARNING_HALT-} ]   	&& WARNING_HALT=0

# ERROR
[ -z ${ERROR_ENABLE-} ]   	&& ERROR_ENABLE=1
[ -z ${ERROR_COLOR-} ]    	&& ERROR_COLOR=${lred-}
[ -z ${ERROR_TAG-} ]      	&& ERROR_TAG="ERROR: "
[ -z ${ERROR_TRACE-} ]    	&& ERROR_TRACE=1
[ -z ${ERROR_LINE-} ]     	&& ERROR_LINE=0
[ -z ${ERROR_PAUSE-} ]    	&& ERROR_PAUSE=0
[ -z ${ERROR_TIMEOUT-} ]   	&& ERROR_TIMEOUT=3
[ -z ${ERROR_HALT-} ]     	&& ERROR_HALT=0

# FATAL
[ -z ${FATAL_ENABLE-} ]   	&& FATAL_ENABLE=1
[ -z ${FATAL_COLOR-} ]    	&& FATAL_COLOR=${red-}
[ -z ${FATAL_TAG-} ]      	&& FATAL_TAG="FATAL: "
[ -z ${FATAL_TRACE-} ]    	&& FATAL_TRACE=1
[ -z ${FATAL_LINE-} ]     	&& FATAL_LINE=0
[ -z ${FATAL_PAUSE-} ]    	&& FATAL_PAUSE=0
[ -z ${FATAL_TIMEOUT-} ]   	&& FATAL_TIMEOUT=9
[ -z ${FATAL_HALT-} ]     	&& FATAL_HALT=0

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
	level_ENABLE=${_level_}_ENABLE
	level_COLOR=${_level_}_COLOR
	level_TAG=${_level_}_TAG
	level_TRACE=${_level_}_TRACE
	level_LINE=${_level_}_LINE
	level_PAUSE=${_level_}_PAUSE
	level_TIMEOUT=${_level_}_TIMEOUT
	level_HALT=${_level_}_HALT
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
}
