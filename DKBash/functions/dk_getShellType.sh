#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


##################################################################################
# dk_getShellType()
#
#
dk_getShellType () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	[ -e "/proc" ] || dk_warning "/proc does not exist" && return 0 
	#PID_EXE=$(readlink /proc/$$/exe);
	#DKSHELL=${PID_EXE##*/};           
	[ -d "/proc" ] && DKSHELL=$(basename $(readlink /proc/$$/exe))
	[ "$SHELL" = "/bin/zsh" ] && DKSHELL="zsh"
	[ $DKSHELL = sh ] && export DKSH=1
	[ $DKSHELL = dash ] && export DKDASH=1
	[ $DKSHELL = zsh ] && export DKZSH=1
	[ $DKSHELL = bash ] && export DKBASH=1
	echo "DKSHELL = $DKSHELL"
}



