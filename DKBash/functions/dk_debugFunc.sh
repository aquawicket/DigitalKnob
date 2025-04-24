<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

##################################################################################
# dk_debugFunc()
#
#
debugFunc() {
	###### VALIDATE ARGUMENTS ######
	_FUNCNAME_=${1-}
	_ARGC_=${2-}
	_MIN_=${3-}
	_MAX_=${4-}
	[ -z ${_MIN_-} ] && return

	#echo "############ ${_FUNCNAME_-} ${_ARGC_-} ${_MIN_-} ${_MAX_-} #########################"
	#echo "####### $(__FUNCTION__ 2) $(__ARGC__ 2) ${_MIN_} ${_MAX_} #########################"
	[ -n "${_MIN_-}" ] && [ "${_ARGC_-}" -lt "${_MIN_-}" ] && dk_call dk_error "${_FUNCNAME_-}(${_ARGC_-}): not enough arguments. Minimum is ${_MIN_-}, got ${_ARGC_-}" || $(true)
	[ -z "${_MAX_-}" ] && [ "${_ARGC_-}" -gt "${_MIN_-}" ] && dk_call dk_error "${_FUNCNAME_-}(${_ARGC_-}): too many arguments. Maximum is ${_MIN_-}, got ${_ARGC_-}" || $(true)
	[ -n "${_MAX_-}" ] && [ "${_ARGC_-}" -gt "${_MAX_-}" ] && dk_call dk_error "${_FUNCNAME_-}(${_ARGC_-}): too many arguments. Maximum is ${_MAX_-}, got ${_ARGC_-}" || $(true)
	
	#####################################################################################################################
	if [ ${ENABLE_dk_debugFunc-0} -eq 1 ]; then
		
		local stack_size=${#FUNCNAME[@]}
		local -i i
		local indent=""
		for (( i = 4; i < stack_size; i++ )); do
			indent="${indent}   "
		done
		local indent="${indent} L "
		
		dk_call dk_echo "${cyan}[$(__TIME__)]${indent}$(__FILE__ 2):$(__LINE__ 2)  ${blue}$(__FUNCTION__ 2)($(__ARGV__ 2))${clr-}"
	fi
	######################################################################################################################
}
alias dk_debugFunc='debugFunc ${FUNCNAME} ${#}'



#func1() {
#	dk_debugFunc
#}
	
####### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#DKTEST() {
#	ENABLE_dk_debugFunc=1
#	dk_debugFunc
#	
#	func1 1 "2" '3'
#}
