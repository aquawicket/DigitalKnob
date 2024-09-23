#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_smartExtract(<src> <dest>)
#
#
dk_smartExtract() {
	dk_debugFunc 2


	src="${1}"
	dest="${2}"
	
	dk_realpath "${src}" src_fullpath 
	src_directory="$(dk_dirname "${src_fullpath}")"
	src_filename="$(dk_basename "${src_fullpath}")"
	src_folder="${src_filename%.*}"
	src_extractPath="${src_directory}/${src_filename}_EXTRACTED"
	
	#dk_realpath "${dest}" dest_fullpath
	dest_fullpath="${dest}"
	dest_folder="$(dk_basename "${dest_fullpath}")"
	if ! dk_pathExists "${dest_fullpath}"; then
		dk_makeDirectory "${dest_fullpath}"
	fi
	
	dk_info "Extracting $src_filename . . ."
	
	[ -e "${src_extractPath}" ] && dk_delete "${src_extractPath}"
	
	dk_extract "$src_fullpath" "${src_extractPath}"
	
	dk_getDirectories "${src_extractPath}" directories
	dk_printVar directories
	
	dk_arrayLength directories dir_count
	dk_printVar dir_count
	
	dk_getFiles "${src_extractPath}" files
	dk_printVar files
	
	dk_arrayLength files file_count
	dk_printVar file_count
	
	if [ ${dir_count} -lt 2 ]; then 
		if [ ${file_count} -lt 1 ]; then
			#rename/move EXTRACTED/root folder to dest path"
			dk_move "${directories[0]}" "$dest_fullpath" OVERWRITE
			#[ -e "${src_extractPath}" ] && dk_delete "${src_extractPath}"
		fi
	fi
	
	# rename/move EXTRACTED folder to dest path
	dk_move "${src_extractPath}" "$dest_fullpath" OVERWRITE
	#[ -e "${src_extractPath}" ] && dk_delete "${src_extractPath}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_validate DKDOWNLOAD_DIR "dk_call dk_getDKPaths"
	dk_download "https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.26.1.zip" "${DKDOWNLOAD_DIR}/sdl-release-2.26.1.zip"
	dk_smartExtract "${DKDOWNLOAD_DIR}/sdl-release-2.26.1.zip" "${DKDOWNLOAD_DIR}/sdl-release-2.26.1"
	
	dk_validate DKDOWNLOAD_DIR "dk_call dk_getDKPaths"
	dk_download "https://newcontinuum.dl.sourceforge.net/project/lzmautils/xz-5.4.6.tar.gz" "${DKDOWNLOAD_DIR}/xz-5.4.6.tar.gz"
	dk_smartExtract "${DKDOWNLOAD_DIR}/xz-5.4.6.tar.gz" "${DKDOWNLOAD_DIR}/xz-5.4.6"
}