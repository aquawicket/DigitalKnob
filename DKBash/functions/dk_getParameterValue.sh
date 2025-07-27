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


#################################################################################
# dk_getParameterValue(_NAME_)
#
dk_getParameterValue() {

	_NAME_="$1"
	_value_=""
	
	for (( a=2; a<$(($# + 1)); a++ )); do
		b=$(( a + 1 ))
		if [ "$_NAME_" = "${!a-}" ]; then
			[ "${!b-}" = "" ] && _value_="1" || _value_="${!b-}"
		fi
	done

	eval "${1}='${_value_}'"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
TEST_getParameter() {

#	dk_call dk_debugFunc 0 99

	dk_call dk_getParameterValue ARG1 "$@"
	dk_call dk_getParameterValue ARG2 "$@"
	dk_call dk_getParameterValue ARG3 "$@"
	dk_call dk_getParameterValue ARG4 "$@"
	dk_call dk_getParameterValue ARG5 "$@"
	dk_call dk_getParameterValue ARG6 "$@"
	dk_call dk_echo "ARG1 = ${ARG1}"
	dk_call dk_echo "ARG2 = ${ARG2}"
	dk_call dk_echo "ARG3 = ${ARG3}"
	dk_call dk_echo "ARG4 = ${ARG4}"
	dk_call dk_echo "ARG5 = ${ARG5}"
	dk_call dk_echo "ARG6 = ${ARG6}"
}


DKTEST() {

#	dk_call dk_debugFunc 0

	TEST_getParameter ARG1 "arg1 data" ARG3 ARG4 "arg4 data" ARG5 "arg5 data" ARG6
}


