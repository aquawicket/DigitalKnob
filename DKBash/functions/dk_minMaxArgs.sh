#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_minMaxArgs(min, max)
#
minMaxArgs() {
	echo "$(__FUNCTION__ 1)($(__ARGV__ 1))"
	
	[ ${#} -lt ${1} ] && dk_error "${FUNCNAME}(${#}): not enough arguments. Minimum is ${1}, got ${#}"
	[ -z ${2} ] && [ ${#} -gt ${1} ] && dk_error "${FUNCNAME}(${#}): too many arguments. Maximum is ${1}, got ${#}"
	[ -n ${2} ] && [ ${#} -gt ${2} ] && dk_error "${FUNCNAME}(${#}): too many arguments. Maximum is ${1}, got ${#}"
}


alias dk_minMaxArgs='minMaxArgs'
