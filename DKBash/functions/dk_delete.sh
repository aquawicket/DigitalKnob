#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

#####################################################################
# dk_delete(<path>)
#
#
dk_delete() {
	dk_debugFunc 1

	_path_=${1}
	if ! dk_call dk_pathExists "${_path_}"; then
		dk_call dk_warning "dk_delete(): ${_path_} does not exist"
	fi
	
	rm -r -f "${_path_}"
	dk_call dk_sleep 1 # give the path a second to delete
	
	if dk_call dk_pathExists "${_path_}"; then
		dk_call dk_error "dk_delete(): failed to remove ${_path_}"
		return ${false}
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_fileWrite "removeMe.file" "created file to test dk_delete"
	dk_call dk_delete "removeMe.file"
}
