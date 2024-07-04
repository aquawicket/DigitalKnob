#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_move(<from> <to>)
#
#	Move/Rename a file or directory to another location/name
#
#	@from		- The source path to move or rename
#	@to			- The destination path to move or rename to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
#
dk_move (){
	dk_debugFunc
	[ $# -lt 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	[ $# -gt 3 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	local _from_=$1
	local _to_=$2

	[ "$3" = "OVERWRITE" ] && OVERWRITE=1
	
	dk_info "Moving $_from_ to $_to_"
	
	if ! dk_pathExists "$_from_"; then
		dk_error "dk_move: $_from_ not found"
	fi
	
	if dk_pathExists "$_to_"; then
		if [ $OVERWRITE -ne 1 ]; then
			dk_error "dk_rename Cannot move file. Destiantion exists and OVERWRITE is not set"
		fi
		dk_remove $_to_
	fi
	
	# the base directory of the %to% path must exist.    
	dk_getDirname "$_to_" _parent_dir_
	dk_printVar _parent_dir_
	dk_makeDirectory "$_parent_dir_"
	
	mv "$_from_" "$_to_"
}



DKTEST(){ ###############################################################################
	
	dk_validate DIGITALKNOB_DIR "dk_getDKPaths"
	
	echo "dk_move test" > $DKDOWNLOAD_DIR/moveMe.file
	dk_move $DKDOWNLOAD_DIR/moveMe.file $DIGITALKNOB_DIR/iWasMoved.txt OVERWRITE
	
	echo "dk_move test" > moveMe.file
	dk_move moveMe.file iWasMoved.txt OVERWRITE
	
	dk_makeDirectory $DKDOWNLOAD_DIR/moveMe
	dk_move $DKDOWNLOAD_DIR/moveMe $DIGITALKNOB_DIR/iWasMoved OVERWRITE
	
	dk_makeDirectory moveMe
	dk_move moveMe iWasMoved OVERWRITE
}