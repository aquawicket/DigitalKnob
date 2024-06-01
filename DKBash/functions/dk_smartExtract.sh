#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_smartExtract(<src> <dest>)
#
#
dk_smartExtract () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"

	src="$1"
	dest="$2"
	
	dk_realpath "${src}" src_fullpath 
	dk_printVar src_fullpath
	
	src_directory="$(dirname "${src_fullpath}")"
	dk_printVar src_directory
	
	src_filename="$(basename "${src_fullpath}")"
	dk_printVar src_filename
	
	src_folder="${src_filename%.*}"
	dk_printVar src_folder
	
	dk_realpath "${dest}" dest_fullpath
	dk_printVar dest_fullpath
	
	dest_folder="$(basename "${dest_fullpath}")"
	dk_printVar dest_folder
	
	if ! dk_pathExists "${dest_fullpath}"; then
		dk_makeDirectory "${dest_fullpath}"
	fi
	
	dk_info "Extracting $src_filename . . ."
	dk_remove "$src_directory/UNZIPPED"
	dk_extract "$src_fullpath" "$src_directory/UNZIPPED"
	
	dk_getDirectories "$src_directory/UNZIPPED" directories
	dk_printVar directories
	dk_arrayLength directories dir_count
	dk_printVar dir_count
	
	dk_getFiles "$src_directory/UNZIPPED" files
	dk_arrayLength files file_count
	dk_printVar file_count
	
	if $dir_count equ 1; then 
		if $file_count equ 0; then
			#rename/move UNZIPPED/root folder to dest path"
			dk_move "$directories[0]" "$dest_fullpath" OVERWRITE
		fi
	fi
	
	# rename/move UNZIPPED folder to dest path
	dk_move "$src_directory/UNZIPPED" "$dest_fullpath" OVERWRITE	
	
	# https://stackoverflow.com/a/5694338
#	top_level_directories=($(tar -tf "${src_fullpath}" | sed -e 's@/.*@@' | uniq))
#	if [ ${#top_level_directories[@]} -eq 1 ]; then
#		# https://superuser.com/a/899688/600216
#		tar -xvf "${src_fullpath}" --strip-components=1 -C "${dest_fullpath}"   # this will 
#	else
#		tar -xvf "${src_fullpath}" -C "${dest_fullpath}"
#	fi
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_smartExtract
}