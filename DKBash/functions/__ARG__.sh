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
# __ARG__(arg_number, frame)
#
__ARG__() {
	#dk_debugFunc 1 2
	[ ${#} -eq 0 ] && echo "ERROR: __ARG__() requires at least 1 argument"
	[ ${#} -gt 2 ] && echo "ERROR: __ARG__(): too many arguments"
	[ -z ${2-} ] && local frame=0 || local frame=${2}
	local argN=${1}
	
	#ARGC=$(__ARGC__ $frame)
	ARGC=${BASH_ARGC[${frame}]-}
	[ $(($argN+1)) -gt ${ARGC} ] && echo "ERROR: ARG$argN is out of bounds. ARG(N) is 0 to $((ARGC-1))"
	
	local marker=0
	for (( i=0; i<frame; i++ )); do
		marker=$(($marker + ${BASH_ARGC[${i}]-}))
	done
	local argN=$(($marker+$ARGC-${1}-1))

	local arg=(${BASH_ARGV[${argN}]-})
	dk_return "${arg}"; return
}


test_functionA(){
	#dk_debugFunc 0
	
	echo "${FUNCNAME} FILE = $(__TIME__ 1)"
	echo "${FUNCNAME} FILE = $(__FILE__ 1)"
	echo "${FUNCNAME} LINE = $(__LINE__ 1)"
	echo "${FUNCNAME} FROM = $(__CALLER__ 1)"
	echo "${FUNCNAME} FUNC = $(__FUNCTION__ 1)"
	echo "${FUNCNAME} ARGC = $(__ARGC__ 1)"
	echo "${FUNCNAME} ARGV = $(__ARGV__ 1)"
	echo "${FUNCNAME} ARG0 = $(__ARG__ 0 1)"
	echo "${FUNCNAME} ARG1 = $(__ARG__ 1 1)"
	echo "${FUNCNAME} ARG2 = $(__ARG__ 2 1)"
	echo "${FUNCNAME} ARG3 = $(__ARG__ 3 1)"
	echo "${FUNCNAME} ARG4 = $(__ARG__ 4 1)"
	echo "${FUNCNAME} ARG5 = $(__ARG__ 5 1)"
	#echo "${FUNCNAME} ARG6 = $(__ARG__ 6 1)"	# out of bounds
	test_functionB one two three four
}

test_functionB(){
	#dk_debugFunc
	
	echo "${FUNCNAME} FILE = $(__TIME__ 1)"
	echo "${FUNCNAME} FILE = $(__FILE__ 1)"
	echo "${FUNCNAME} LINE = $(__LINE__ 1)"
	echo "${FUNCNAME} FROM = $(__CALLER__ 1)"
	echo "${FUNCNAME} FUNC = $(__FUNCTION__ 1)"
	echo "${FUNCNAME} ARGC = $(__ARGC__ 1)"
	echo "${FUNCNAME} ARGV = $(__ARGV__ 1)"
	echo "${FUNCNAME} ARG0 = $(__ARG__ 0 1)"
	echo "${FUNCNAME} ARG1 = $(__ARG__ 1 1)"
	echo "${FUNCNAME} ARG2 = $(__ARG__ 2 1)"
	echo "${FUNCNAME} ARG3 = $(__ARG__ 3 1)"
	#echo "${FUNCNAME} ARG4 = $(__ARG__ 4 1)"	# out of bounds
}

###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	#dk_debugFunc
	
	test_functionA abc 123 def 456 ghi 789
}