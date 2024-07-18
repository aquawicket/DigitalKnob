#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_smartExtract(<src> <dest>)
#
#
dk_smartExtract() {
	dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"

	src="${1}"
	dest="${2}"
	
	dk_realpath "${src}" src_fullpath 
	src_directory="$(dk_dirname "${src_fullpath}")"
	src_filename="$(dk_basename "${src_fullpath}")"
	src_folder="${src_filename%.*}"
	
	#dk_realpath "${dest}" dest_fullpath
	dest_fullpath="${dest}"
	dest_folder="$(dk_basename "${dest_fullpath}")"
	if ! dk_pathExists "${dest_fullpath}"; then
		dk_makeDirectory "${dest_fullpath}"
	fi
	
	dk_info "Extracting $src_filename . . ."
	dk_remove "$src_directory/UNZIPPED"
	dk_extract "$src_fullpath" "$src_directory/UNZIPPED"
	
	dk_getDirectories "$src_directory/UNZIPPED" directories
	dk_arrayLength directories dir_count
	dk_getFiles "$src_directory/UNZIPPED" files
	dk_arrayLength files file_count
	
	if [ $dir_count -eq 1 ]; then 
		if [ $file_count -eq 0 ]; then
			#rename/move UNZIPPED/root folder to dest path"
			dk_move "$directories[0]" "$dest_fullpath" OVERWRITE
		fi
	fi
	
	# rename/move UNZIPPED folder to dest path
	dk_move "$src_directory/UNZIPPED" "$dest_fullpath" OVERWRITE	
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######

	dk_smartExtract
}