#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


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
