#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_source(function_name)
#
#    @function_name	- the function name of the file to source and download if needed
#
dk_source(){
	[ -e ${DKBASH_FUNCTIONS_DIR}/dk_debugFunc.sh ] && dk_debugFunc 1

	# load if it's an existing full path file
	[ -e ${1} ] && . ${1} && return ${?}

	# If it's a dk_function, download if it doesn't exist then load it
	[ -e ${DKBASH_FUNCTIONS_DIR}/${1}.sh ] || echo "downloading ${1} . . ."
	[ -e ${DKBASH_FUNCTIONS_DIR}/${1}.sh ] || dk_call curl --silent -Lo ${DKBASH_FUNCTIONS_DIR}/${1}.sh ${DKHTTP_DKBASH_FUNCTIONS_DIR}/${1}.sh
	[ -e ${DKBASH_FUNCTIONS_DIR}/${1}.sh ] || echo "ERROR: failed to download ${1}" || [$(read -rp 'press enter to exit')] || exit 127;
	chmod 777 ${DKBASH_FUNCTIONS_DIR}/${1}.sh
	. ${DKBASH_FUNCTIONS_DIR}/${1}.sh
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_source dk_info 
	dk_info "test message using dk_source to download it first"
}
