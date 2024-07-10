#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_getShellType(<output>)
#
#
dk_getShellType (){
	dk_debugFunc
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	#PID_EXE=$(readlink /proc/$$/exe);
	#DKSHELL=${PID_EXE##*/};           
	[ -d "/proc" ] && DKSHELL=$(basename $(readlink /proc/$$/exe))
	[ "${SHELL}" = "/bin/zsh" ] && DKSHELL="zsh"
	[ $DKSHELL = sh ] && export DKSH=1
	[ $DKSHELL = dash ] && export DKDASH=1
	[ $DKSHELL = zsh ] && export DKZSH=1
	[ $DKSHELL = bash ] && export DKBASH=1
	#echo "DKSHELL = $DKSHELL"
	
	eval "${1}=${DKSHELL}"
	dk_printVar "${1}"
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getShellType shellType
	echo "shellType = ${shellType}"
}

