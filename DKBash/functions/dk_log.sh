#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

# DEFAULT
[ -z ${ENABLE_dk_log-}   ] && ENABLE_dk_log=1
[ -z ${DEFAULT_COLOR-}   ] && DEFAULT_COLOR=${white}
#[ -z ${DEFAULT_TAG-}    ] && DEFAULT_TAG=bat>: "
[ -z ${DEFAULT_PAUSE-}   ] && DEFAULT_PAUSE=0
[ -z ${DEFAULT_TRACE-}   ] && DEFAULT_TRACE=0
[ -z ${DEFAULT_LINE-}    ] && DEFAULT_LINE=0
[ -z ${DEFAULT_HALT-}    ] && DEFAULT_HALT=0

# VERBOSE
[ -z ${VERBOSE_ENABLE-}  ] && VERBOSE_ENABLE=1
[ -z ${VERBOSE_COLOR-}   ] && VERBOSE_COLOR=${magenta}
[ -z ${VERBOSE_TAG-}     ] && VERBOSE_TAG="VERBOSE: "
[ -z ${VERBOSE_PAUSE-}   ] && VERBOSE_PAUSE=1
[ -z ${VERBOSE_TRACE-}   ] && VERBOSE_TRACE=0
[ -z ${VERBOSE_LINE-}    ] && VERBOSE_LINE=0
[ -z ${VERBOSE_HALT-}    ] && VERBOSE_HALT=0

# DEBUG
[ -z ${DEBUG_ENABLE-}    ] && DEBUG_ENABLE=1
[ -z ${DEBUG_COLOR-}     ] && DEBUG_COLOR=${blue}
[ -z ${DEBUG_TAG-}       ] && DEBUG_TAG="DEBUG: "
[ -z ${DEBUG_PAUSE-}     ] && DEBUG_PAUSE=0
[ -z ${DEBUG_TRACE-}     ] && DEBUG_TRACE=0
[ -z ${DEBUG_LINE-}      ] && DEBUG_LINE=0
[ -z ${DEBUG_HALT-}      ] && DEBUG_HALT=0

# INFO
[ -z ${INFO_ENABLE-}     ] && INFO_ENABLE=1
[ -z ${INFO_COLOR-}      ] && INFO_COLOR=${white}
[ -z ${INFO_TAG-}        ] && INFO_TAG="INFO: "
[ -z ${INFO_PAUSE-}      ] && INFO_PAUSE=0
[ -z ${INFO_TRACE-}      ] && INFO_TRACE=0
[ -z ${INFO_LINE-}       ] && INFO_LINE=0
[ -z ${INFO_HALT-}       ] && INFO_HALT=0

# WARNING
[ -z ${WARNING_ENABLE-}  ] && WARNING_ENABLE=1
[ -z ${WARNING_COLOR-}   ] && WARNING_COLOR=${yellow}
[ -z ${WARNING_TAG-}     ] && WARNING_TAG="WARNING: " 
[ -z ${WARNING_PAUSE-}   ] && WARNING_PAUSE=0
[ -z ${WARNING_TRACE-}   ] && WARNING_TRACE=0
[ -z ${WARNING_LINE-}    ] && WARNING_LINE=0
[ -z ${WARNING_HALT-}    ] && WARNING_HALT=0

# ERROR
[ -z ${ERROR_ENABLE-}    ] && ERROR_ENABLE=1
[ -z ${ERROR_COLOR-}     ] && ERROR_COLOR=${red}
[ -z ${ERROR_TAG-}       ] && ERROR_TAG="ERROR: "
[ -z ${ERROR_PAUSE-}     ] && ERROR_PAUSE=1
[ -z ${ERROR_TRACE-}     ] && ERROR_TRACE=0
[ -z ${ERROR_LINE-}      ] && ERROR_LINE=0
[ -z ${ERROR_HALT-}      ] && ERROR_HALT=1

# TODO
[ -z ${TODO_ENABLE-}    ] && TODO_ENABLE=1
[ -z ${TODO_COLOR-}     ] && TODO_COLOR=${yellow}
[ -z ${TODO_TAG-}       ] && TODO_TAG="TODO: "
[ -z ${TODO_PAUSE-}     ] && TODO_PAUSE=1
[ -z ${TODO_TRACE-}     ] && TODO_TRACE=0
[ -z ${TODO_LINE-}      ] && TODO_LINE=0
[ -z ${TODO_HALT-}      ] && TODO_HALT=0

# FIXME
[ -z ${FIXME_ENABLE-}   ] && FIXME_ENABLE=1
[ -z ${FIXME_COLOR-}    ] && FIXME_COLOR=${red}
[ -z ${FIXME_TAG-}      ] && FIXME_TAG="FIXME: "
[ -z ${FIXME_PAUSE-}    ] && FIXME_PAUSE=1
[ -z ${FIXME_TRACE-}    ] && FIXME_TRACE=0
[ -z ${FIXME_LINE-}     ] && FIXME_LINE=0
[ -z ${FIXME_HALT-}     ] && FIXME_HALT=0

##################################################################################
# dk_log(message)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
dk_log() {
	dk_debugFunc 1 2

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
	
	[ ${!level_PAUSE} -eq 1 ] && dk_echo "${!level_COLOR}*** PAUSE_ON_DEBUG ***${clr}" && dk_pause; true #OR PAUSE AND NOT NO_PAUSE)
	[ ${!level_TRACE} -eq 1 ] && dk_echo "${!level_COLOR}*** TRACE_ON_DEBUG ***${clr}" && dk_stacktrace; true #OR TRACE AND NOT NO_TRACE)
	[ ${!level_LINE} -eq 1 ]  && dk_echo "${!level_COLOR}*** LINE_ON_DEBUG ***${clr}"  && dk_showFileLine "${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}"; true #OR HALT AND NOT NO_HALT)
	[ ${!level_HALT} -eq 1 ]  && dk_echo "${!level_COLOR}*** HALT_ON_DEBUG ***${clr}"  && dk_exit 0; true #OR HALT AND NOT NO_HALT)
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_log "test dk_log message"
	
	dk_log VERBOSE "test dk_log VERBOSE message"
	dk_log DEBUG   "test dk_log DEBUG message"
	dk_log INFO    "test dk_log INFO message"
	dk_log WARNING "test dk_log WARNING message"
	dk_log ERROR   "test dk_log ERROR message"
}