#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_return()
#
#
dk_source(){
	dk_debugFunc
	[ $# -ne 1 ] && echo "${FUNCNAME}($#): incorrect number of arguments" && return 1

	[ -e ${DKBASH_FUNCTIONS_DIR}/$1.sh ] || dk_command curl -Lo ${DKBASH_FUNCTIONS_DIR}/$1.sh https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/$1.sh
	[ -e ${DKBASH_FUNCTIONS_DIR}/$1.sh ] || [$(read -rp '$1 command not found, press enter to exit')] || exit;
	chmod 777 ${DKBASH_FUNCTIONS_DIR}/$1.sh
	. ${DKBASH_FUNCTIONS_DIR}/$1.sh
}


DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_source dk_info 
	dk_info "test message using dk_source to load first"

}