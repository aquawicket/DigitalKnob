#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_copy(<from> <to>)
#
#	copy a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
#
dk_copy (){
	dk_debugFunc
	[ $# -lt 2 ] && dk_error "${FUNCNAME}($#): not enough arguments"
	[ $# -gt 3 ] && dk_error "${FUNCNAME}($#): too many arguments"
	
	_from_="$1"
	_to_="$2"
	if [ "$3" = "OVERWRITE" ]; then
		OVERWRITE=1
	else 
		OVERWRITE=0 
	fi
	
	dk_info "Copying ${_from_} to ${_to_}"
	
	if [ ! -e "${_from_}" ]; then
		dk_error "dk_copy: ${_from_} not found"
	fi
	
	if [ -e "${_to_}" ]; then
		if [ "${OVERWRITE}" -ne "1" ]; then
			dk_error "dk_copy Cannot copy file. Destiantion exists and OVERWRITE is not set"
		fi
		dk_remove ${_to_}
	fi
	
	# the base directory of the %to% path must exist.    
	dk_getDirname "${_to_}" _parent_dir_
	dk_makeDirectory "${_parent_dir_}"
	
	cp -r "${_from_}" "${_to_}"

	#TODO
	#[ ? = "success" ]
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_validate DIGITALKNOB_DIR "dk_getDKPaths"
	
	echo "dk_copy test" > ${DKDOWNLOAD_DIR}/copyMe.file
	dk_copy ${DKDOWNLOAD_DIR}/copyMe.file ${DIGITALKNOB_DIR}/iWasCopied.txt OVERWRITE
	
	echo "dk_copy test" > copyMe.file
	dk_copy copyMe.file iWasCopied.txt OVERWRITE
	
	dk_makeDirectory ${DKDOWNLOAD_DIR}/copyMe
	dk_copy ${DKDOWNLOAD_DIR}/copyMe ${DIGITALKNOB_DIR}/iWasCopied OVERWRITE
	
	dk_makeDirectory copyMe
	dk_copy copyMe iWasCopied OVERWRITE
}