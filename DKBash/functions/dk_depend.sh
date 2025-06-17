#!/usr/bin/env bash
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


############################################################################
# dk_depend(plugin)
#
#   this will search for a "plugin" to run in the following search path
#  '3rdParty/_IMPORTS/'plugin'/DKINSTALL.cmd'
#
dk_depend() {
	
	_plugin_="$1"
	
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	if [ -e "${DKIMPORTS_DIR}/${_plugin_}/DKINSTALL.sh" ];then
		. "${DKIMPORTS_DIR}/${_plugin_}/DKINSTALL.sh"
		
		dk_call dk_success "found ${_plugin_}"
		return
	fi

	dk_call dk_fatal "${DKIMPORTS_DIR}/${_plugin_}/DKINSTALL.sh not found"
}











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_call dk_depend "git"
}
