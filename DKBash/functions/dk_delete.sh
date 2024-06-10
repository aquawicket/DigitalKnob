#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


#####################################################################
# dk_delete(<path>)
#
#
dk_delete () {
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	_path_=$1
	if ! dk_pathExists "${_path_}"; then
		dk_warning "dk_delete(): ${_path_} does not exist"
	fi
	
	rm -r -f "${_path_}"
	dk_sleep 1 # give the path a second to delete
	
	if dk_pathExists "${_path_}"; then
		dk_error "dk_delete(): failed to remove ${_path_}"
		return ${false}
	fi
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_delete
}