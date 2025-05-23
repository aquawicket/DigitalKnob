#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_deleteTempFiles()
#
#
dk_deleteTempFiles() {
	dk_debugFunc 0

	dk_call dk_info "Deleting .TMP files . . ."
	
	dk_call dk_validate DK3RDPARTY_DIR	"dk_call dk_DK3RDPARTY_DIR"
	dk_call dk_validate DKCPP_APPS_DIR		"dk_call dk_DKBRANCH_DIR"
	dk_call dk_validate DKCPP_PLUGINS_DIR	"dk_call dk_DKBRANCH_DIR"
	
	[ ! -e "${DK3RDPARTY_DIR}" ] && return
	rm -rf $(find "${DK3RDPARTY_DIR}" -type d -name *.tmp)
	rm -rf $(find "${DK3RDPARTY_DIR}" -type d -name *.TMP)
	find "${DK3RDPARTY_DIR}" -name "*.tmp" -delete
	find "${DK3RDPARTY_DIR}" -name "*.TMP" -delete
	
	[ ! -e "${DKCPP_APPS_DIR}" ] && return
	rm -rf $(find "${DKCPP_APPS_DIR}" -type d -name *.tmp)
	rm -rf $(find "${DKCPP_APPS_DIR}" -type d -name *.TMP)
	find "${DKCPP_APPS_DIR}" -name "*.tmp" -delete
	find "${DKCPP_APPS_DIR}" -name "*.TMP" -delete
	
	[ ! -e "${DKCPP_PLUGINS_DIR}" ] && return
	rm -rf $(find "${DKCPP_PLUGINS_DIR}" -type d -name *.tmp)
	rm -rf $(find "${DKCPP_PLUGINS_DIR}" -type d -name *.TMP)
	find "${DKCPP_PLUGINS_DIR}" -name "*.tmp" -delete
	find "${DKCPP_PLUGINS_DIR}" -name "*.TMP" -delete
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_deleteTempFiles
}
