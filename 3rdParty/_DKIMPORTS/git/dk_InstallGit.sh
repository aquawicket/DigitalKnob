#!/bin/sh
#. ./DK.sh
dk_includeGuard

##################################################################################
# dk_validateGit()
#
#
dk_validateGit () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	if ! dk_commandExists git; then
		dk_install git
	fi
	
	GIT_EXE=$(command -v git)
	[ -e ${GIT_EXE} ] || dk_error "GIT_EXE is invalid"
	
	dk_debug GIT_EXE
}