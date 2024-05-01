#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
dk_includeGuard

##################################################################################
# dk_call(<command args>)
#
#
dk_call () {
	dk_debugFunc
	[ "$#" -lt "1" ] && dk_error "Incorrect number of parameters"

	dk_echo "${magenta} $ $* ${clr}"
	#$("$@") && "$@" 2>&1 #|| dk_error "'$*: failed!'"
	"$@"
}




################################ DKTEST #########################################
DKTEST () {
	dk_call dk_info "test message using dk_call"
}
[ -n "$DKTEST" ] && DKTEST