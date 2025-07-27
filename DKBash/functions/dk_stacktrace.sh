#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)						&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')						&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_stacktrace()
#
#
dk_stacktrace() {
    dk_debugFunc 0
	#ENABLE_dk_debugFunc=0

	### VERSION 1 ###
	stack_size=${#FUNCNAME[@]}
	dk_echo "STACKTRACE[${stack_size}]" 
	local i=0
	while [ "${i}" -lt "${stack_size}" ]; do
		i=$(( i + 1 ))
		frame=$(( i - 2 ))
		if [ ${i} -eq 2 ]; then
			fileline=$(sed -n ${BASH_LINENO[${i}-1]-}p ${BASH_SOURCE[${i}]:-})
			dk_echo "  [${frame}] ${BASH_SOURCE[${i}]:-}:${bg_white-}${black-}${BASH_LINENO[${i}-1]-}: > ${fileline}${clr-}"
			continue
		fi
		[ ${i} -gt 2 ] && dk_echo "  [${frame}] ${BASH_SOURCE[${i}]:-}:${BASH_LINENO[${i}-1]-} ${FUNCNAME[${i}-1]-}()" # && continue
	done 


#	### VERSION 2 ###
#	[ "${FUNCNAME-}" = "" ] && return 0
#	[ "${BASH_SOURCE-}" = "" ] && return 0
#	[ "${BASH_LINENO-}" = "" ] && return 0
#	local status_code="${1-}" 
#	local -a stack=("Stack trace of error code '${status_code}':")
#	local stack_size=${#FUNCNAME[@]}
#	local -i i
#	local indent="    "
#	# to avoid noise we start with 1 to skip the stack function
#	for (( i = 1; i < stack_size; i++ )); do
#	    local func="${FUNCNAME[${i}]:-(top level)}"
#	    local -i line="${BASH_LINENO[$(( i - 1 ))]}"
#	    local src="${BASH_SOURCE[${i}]:-(no file)}"
#	    stack+=("${indent} └ ${src}:${line} (${func})")
#	    indent="${indent}    "
#	done
	(IFS=$'\n'; echo "${stack[*]-}")


#	### VERSION 3 ###
#	local i=1 line file func
#	while read -r line func file < <(caller ${i}); do
#		echo >&2 [${i}] ${file}:${line} ${func}(): $(sed -n ${line}p ${file})
#		((i++))
#	done
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_stacktrace
}