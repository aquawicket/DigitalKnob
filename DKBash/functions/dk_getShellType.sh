#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
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
