#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_move(<from> <to>)
#
#	Move/Rename a file or directory to another location/name
#
#	@from		- The source path to move or rename
#	@to			- The destination path to move or rename to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
#
dk_move() {
	dk_debugFunc 2 3

	
	local _from_=${1}
	local _to_=${2}

	[ "${3}" = "OVERWRITE" ] && OVERWRITE=1
	
	dk_call dk_info "Moving $_from_ to $_to_"
	
	if ! dk_call dk_pathExists "$_from_"; then
		dk_call dk_error "dk_move: $_from_ not found"
	fi
	
	if dk_call dk_pathExists "$_to_"; then
		if [ $OVERWRITE -ne 1 ]; then
			dk_call dk_error "dk_rename Cannot move file. Destiantion exists and OVERWRITE is not set"
		fi
		dk_call dk_delete $_to_
	fi
	
	# the base directory of the ${_to_} path must exist.    
	_parent_dir_=$(dk_call dk_dirname "${_to_}")
	dk_call dk_printVar _parent_dir_
	dk_call dk_makeDirectory "${_parent_dir_}"
	
	mv "${_from_}" "${_to_}"
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST(){
	dk_debugFunc 0
	
	dk_validate DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR"
	
	echo "dk_move test" > ${DKDOWNLOAD_DIR}/moveMe.file
	dk_move ${DKDOWNLOAD_DIR}/moveMe.file ${DIGITALKNOB_DIR}/iWasMoved.txt OVERWRITE
	
	echo "dk_move test" > moveMe.file
	dk_move moveMe.file iWasMoved.txt OVERWRITE
	
	dk_makeDirectory ${DKDOWNLOAD_DIR}/moveMe
	dk_move ${DKDOWNLOAD_DIR}/moveMe ${DIGITALKNOB_DIR}/iWasMoved OVERWRITE
	
	dk_makeDirectory moveMe
	dk_move moveMe iWasMoved OVERWRITE
}
