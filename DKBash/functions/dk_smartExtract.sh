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
	
	#src_fullpath="$(realpath "${src}")"
	dk_realpath "${src}" src_fullpath 
	dk_printVar src_fullpath
	src_directory="$(dirname "${src_fullpath}")"
	dk_printVar src_directory
	src_filename="$(basename "${src_fullpath}")"
	dk_printVar src_filename
	src_folder="${src_filename%.*}"
	dk_printVar src_folder
	
	#dest_fullpath="$(realpath "${dest}")"
	dk_realpath "${dest}" dest_fullpath
	dk_printVar dest_fullpath
	dest_folder="$(basename "${dest_fullpath}")"
	dk_printVar dest_folder
	
	if ! dk_fileExists "${dest_fullpath}"; then
		dk_makeDirectory "${dest_fullpath}"
	fi
	
	dk_info "Extracting $src_filename . . ."
	# https://stackoverflow.com/a/5694338
	top_level_directories=($(tar -tf "${src_fullpath}" | sed -e 's@/.*@@' | uniq))
	#dk_printVar top_level_directories

	if [ ${#top_level_directories[@]} -eq 1 ]; then
		#dk_debug "top_level_directories size is 1"
		# https://superuser.com/a/899688/600216
		tar -xf "${src_fullpath}" --strip-components=1 -C "${dest_fullpath}"   # this will stop a root folder from being extracted
	else
		tar -xf "${src_fullpath}" -C "${dest_fullpath}"
	fi
		
	#[ "$?" ]
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_smartExtract
}