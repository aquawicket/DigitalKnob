#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_copy(<from> <to>)
#
#	copy a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
#
dk_copy() {
	dk_debugFunc 2 3

	local _from_="${1}"
	local _to_="${2}"
	if [ "${3}" = "OVERWRITE" ]; then
		OVERWRITE=1
	else 
		OVERWRITE=0 
	fi
	
	dk_call dk_info "Copying ${_from_} to ${_to_}"
	
	if [ ! -e "${_from_}" ]; then
		dk_call dk_error "dk_copy: ${_from_} not found"
	fi
	
	if [ -e "${_to_}" ]; then
		if [ "${OVERWRITE}" -ne "1" ]; then
			dk_call dk_error "dk_copy Cannot copy file. Destiantion exists and OVERWRITE is not set"
		fi
		dk_call dk_delete ${_to_}
	fi
	
	# the base directory of the ${_to_} path must exist.    
	dk_call dk_dirname "${_to_}" _parent_dir_
	dk_call dk_makeDirectory "${_parent_dir_}"
	
	cp -r "${_from_}" "${_to_}"

	#TODO
	#[ ? = "success" ]
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_getDKPaths"
	
	dk_call dk_echo "dk_copy test" > ${DKDOWNLOAD_DIR}/copyMe.file
	dk_call dk_copy ${DKDOWNLOAD_DIR}/copyMe.file ${DIGITALKNOB_DIR}/iWasCopied.txt OVERWRITE
	
	dk_call dk_echo "dk_copy test" > copyMe.file
	dk_call dk_copy copyMe.file iWasCopied.txt OVERWRITE
	
	dk_call dk_makeDirectory ${DKDOWNLOAD_DIR}/copyMe
	dk_call dk_copy ${DKDOWNLOAD_DIR}/copyMe ${DIGITALKNOB_DIR}/iWasCopied OVERWRITE
	
	dk_call dk_makeDirectory copyMe
	dk_call dk_copy copyMe iWasCopied OVERWRITE
}
