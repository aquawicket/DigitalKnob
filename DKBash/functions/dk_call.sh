#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_call(<command args>)
#
#
dk_call () {
	dk_debugFunc
	[ $# -lt 1 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"

	dk_echo "${magenta} $ $* ${clr}"
	#$("$@") && "$@" 2>&1 #|| dk_error "'$*: failed!'"
	"$@"
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_call dk_info "test message using dk_call"

}