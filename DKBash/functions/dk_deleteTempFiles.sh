#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_deleteTempFiles()
#
#
dk_deleteTempFiles() {
	dk_debugFunc 0

	dk_call dk_info "Deleting .TMP files . . ."
	
	#dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	#rm -rf $(find "${DKBRANCH_DIR}" -type d -name *.tmp)
	#rm -rf $(find "${DKBRANCH_DIR}" -type d -name *.TMP)
	#find "${DKBRANCH_DIR}" -name "*.tmp" -delete
	#find "${DKBRANCH_DIR}" -name "*.TMP" -delete
	
	[ ! -e "${CMAKE_BINARY_DIR}" ] && return
	rm -rf $(find "${CMAKE_BINARY_DIR}" -type d -name *.tmp)
	rm -rf $(find "${CMAKE_BINARY_DIR}" -type d -name *.TMP)
	find "${CMAKE_BINARY_DIR}" -name "*.tmp" -delete
	find "${CMAKE_BINARY_DIR}" -name "*.TMP" -delete
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_deleteTempFiles
}
