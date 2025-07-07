#!/bin/bash
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
	#echo "dk_depend($*)"
	
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	if [ -e "${DKIMPORTS_DIR}/${1}/DKINSTALL.sh" ]; then
		dk_call dk_source "${DKIMPORTS_DIR}/${1}/DKINSTALL.sh"
		dk_call DKINSTALL
		return
	fi

	dk_call dk_fatal "${DKIMPORTS_DIR}/${1}/DKINSTALL.sh not found"
}











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_call dk_depend "git"
}
