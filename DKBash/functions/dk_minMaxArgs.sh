#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


################################################################################
# dk_minMaxArgs(min, max)
#
minMaxArgs() {
	
	_FUNCNAME_=${1-}
	_ARGC_=${2-}
	_ARGS_="${3-}"
	_MIN_=${4-}
	_MAX_=${5-}
	[ -z ${_MIN_} ] && _MIN_=0
	[ -z ${_MAX_} ] && _MAX_=0
	echo "####### ${_FUNCNAME_} ${_ARGC_} ${_ARGS_} ${_MIN_} ${_MAX_} #########################"
	
	[ ${_ARGC_} -lt ${_MIN_} ] && dk_error "${_FUNCNAME_}(${_ARGC_}): not enough arguments. Minimum is ${_MIN_}, got ${_ARGC_}" || $(true)
	[ -z ${_MAX_} ] && [ ${_ARGC_} -gt ${_MIN_} ] && dk_error "${_FUNCNAME_}(${_ARGC_}): too many arguments. Maximum is ${_MIN_}, got ${_ARGC_}" || $(true)
	[ -n ${_MAX_} ] && [ ${_ARGC_} -gt ${_MAX_} ] && dk_error "${_FUNCNAME_}(${_ARGC_}): too many arguments. Maximum is ${_MAX_}, got ${_ARGC_}" || $(true)
}


alias dk_minMaxArgs='minMaxArgs ${FUNCNAME} ${#} "${*}"'
