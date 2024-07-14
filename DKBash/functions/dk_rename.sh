#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_rename(<from> <to>)
#
#	Rename file or directory or move a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing files is enabled
#
dk_rename (){
	dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	_from_="${1}"
	_to_="${2}"
	#OVERWRITE=     TODO
	
	dk_info "Renameing ${_from_} to ${_to_}"
	
	if ! dk_pathExists "${_from_}"; then
		dk_error "dk_rename: ${_from_} not found"
	fi
	
	if dk_pathExists "${_to_}"; then
		#if [ $OVERWRITE -ne 1 ]; then
		#	dk_error "dk_rename(): Cannot rename file. Destiantion exists and not set to OVERWRITE"
		#fi
		dk_remove ${_to_}
	fi
	
	# the base directory of the ${_to_} path must exist.    
	parent_dir=$(dk_dirname ${_to_})
	dk_printVar parent_dir
	dk_makeDirectory "${parent_dir}"
	
	mv -i ${_from_} ${_to_}   # -i means interactive, to prevent overwrite
	#TODO
	#[ ? = "success" ]
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	echo "rename this file" > renameMe.txt
	dk_rename renameMe.txt iWasRenamed.txt
	
	dk_makeDirectory renameMe
	dk_rename renameMe iWasRenamed
}