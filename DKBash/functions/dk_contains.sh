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
# dk_contains(string, substring)
#
#
dk_contains() {
	dk_debugFunc 2

	
	# https://stackoverflow.com/a/8811800/688352
	# [[ ${1} == *"${2}"* ]]    							# NON-POSIX    # [[ ${string} == *"${substring}"* ]]
	# case "${1}" in *${2}*) return 0;; esac; return 1      # POSIX        # case "${string}" in *${substring}*) return 0;; esac; return 1
	[ "${1#*"${2}"}" != "${1}" ]						    # POSIX        # [ "${string#*"$substring"}" != "$string" ]
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	if dk_contains "1one1" "one"; then
		dk_echo "1one1 contains one"
	else
		dk_echo "1one1 does not contains one"
	fi

	dk_contains "1one1" "one" && dk_echo "1one1 contains one" || dk_echo "1one1 does not contain one"
	dk_contains "2two2" "owt" && dk_echo "2two2 contains owt" || dk_echo "2two2 does not contain owt"
}
