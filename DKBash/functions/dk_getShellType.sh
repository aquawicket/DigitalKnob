#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_getShellType(<output>)
#
#
dk_getShellType() {
	dk_debugFunc 1

	#PID_EXE=$(readlink /proc/$$/exe);
	#PID_EXE=$(dk_call dk_readlink /proc/$$/exe);
	#DKSHELL=${PID_EXE##*/};           
	#[ -d "/proc" ] && DKSHELL=$(dk_call dk_basename $(readlink /proc/$$/exe))
	[ -d "/proc" ] && DKSHELL=$(dk_call dk_basename $(dk_call dk_readlink /proc/$$/exe))
	[ "${SHELL}" = "/bin/zsh" ] && DKSHELL="zsh"
	[ $DKSHELL = sh ] && export DKSH=1
	[ $DKSHELL = dash ] && export DKDASH=1
	[ $DKSHELL = zsh ] && export DKZSH=1
	[ $DKSHELL = bash ] && export DKBASH=1
	#dk_call dk_echo "DKSHELL = $DKSHELL"
	
	eval "${1}=${DKSHELL}"
	dk_call dk_printVar "${1}"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_getShellType shellType
	dk_call dk_echo "shellType = ${shellType}"
}
