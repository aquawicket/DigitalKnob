#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_deleteTempFiles()
#
#
dk_deleteTempFiles () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"

	dk_info "Deleting .TMP files . . ."
	
	dk_validate DIGITALKNOB_DIR dk_getDKPaths	
	rm -rf $(find "${DIGITALKNOB_DIR}" -type d -name *.tmp)
	rm -rf $(find "${DIGITALKNOB_DIR}" -type d -name *.TMP)
	find "${DIGITALKNOB_DIR}" -name "*.tmp" -delete
	find "${DIGITALKNOB_DIR}" -name "*.TMP" -delete
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_deleteTempFiles
}