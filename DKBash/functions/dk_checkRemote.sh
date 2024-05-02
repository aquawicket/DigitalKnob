#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


##################################################################################
# dk_checkRemote()
#
#
dk_checkRemote () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	ahead=0
	behind=0
	if [ -d "${DKBRANCH_DIR}/.git" ]; then
		cd "${DKBRANCH_DIR}"
		${GIT_EXE} remote update
		branch=$(${GIT_EXE} rev-parse --abbrev-ref HEAD)
		ahead=$(${GIT_EXE} rev-list --count origin/$branch..$branch)
		behind=$(${GIT_EXE} rev-list --count $branch..origin/$branch)
		dk_info "$ahead commits ahead, $behind commits behind"
	fi
}