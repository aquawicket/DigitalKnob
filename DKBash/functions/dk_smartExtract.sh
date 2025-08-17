#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')									&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)										&& echo "BASH_EXE = ${BASH_EXE}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_smartExtract(<src> <dest>)
#
#
dk_smartExtract() {
	dk_debugFunc 2

	src="${1}"
	dk_call dk_assertPath "${src}"  # TODO: change to dk_assertFile
	dest="${2}"
	
	src_realpath="$(dk_call dk_realpath "${src}")"
	src_dirname="$(dk_call dk_dirname "${src_realpath}")"
	src_basename="$(dk_call dk_basename "${src_realpath}")"
	src_folder="$(dk_call dk_basename "${src_basename}")" #src_folder="${src_basename%.*}"
	src_extractPath="${src_dirname}/${src_basename}_EXTRACTED"
	
	#dk_realpath "${dest}" dest_fullpath
	dest_fullpath="${dest}"
	dest_folder="$(dk_call dk_basename "${dest_fullpath}")"
	if ! dk_call dk_pathExists "${dest_fullpath}"; then
		dk_call dk_mkdir "${dest_fullpath}"
	fi

	dk_call dk_info "Extracting $src_basename . . ."
	[ -e "${src_extractPath}" ] && dk_call dk_delete "${src_extractPath}"
	
	dk_call dk_extract "$src_realpath" "${src_extractPath}"
	
	dk_call dk_getDirectories "${src_extractPath}" directories
	dk_call dk_printVar directories
	
	dk_call dk_arrayLength directories dir_count
	dk_call dk_printVar dir_count
	
	dk_call dk_getFiles "${src_extractPath}" files
	dk_call dk_printVar files
	
	dk_call dk_arrayLength files file_count
	dk_call dk_printVar file_count
	
	if [ ${dir_count} -lt 2 ]; then 
		if [ ${file_count} -lt 2 ]; then
			dk_call dk_move "${directories[0]}" "$dest_fullpath" OVERWRITE
			[ -e "${src_extractPath}" ] && dk_delete "${src_extractPath}"
			return $(true)
		fi
	fi
	
	# rename/move EXTRACTED folder to dest path
	dk_call dk_move "${src_extractPath}" "$dest_fullpath" OVERWRITE
	[ -e "${src_extractPath}" ] && dk_delete "${src_extractPath}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
	dk_call dk_download "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-x86_64.tar.gz" "${DKDOWNLOAD_DIR}/cmake-3.29.5-linux-x86_64.tar.gz"
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
	dk_call dk_smartExtract "${DKDOWNLOAD_DIR}/cmake-3.29.5-linux-x86_64.tar.gz" "${DKTOOLS_DIR}/cmake-3.29.5-linux-x86_64"
	
	#dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
	#dk_call dk_download "https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.26.1.zip" "${DKDOWNLOAD_DIR}/sdl-release-2.26.1.zip"
	#dk_call dk_smartExtract "${DKDOWNLOAD_DIR}/sdl-release-2.26.1.zip" "${DKDOWNLOAD_DIR}/sdl-release-2.26.1"
	
	#dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
	#dk_call dk_download "https://newcontinuum.dl.sourceforge.net/project/lzmautils/xz-5.4.6.tar.gz" "${DKDOWNLOAD_DIR}/xz-5.4.6.tar.gz"
	#dk_call dk_smartExtract "${DKDOWNLOAD_DIR}/xz-5.4.6.tar.gz" "${DKDOWNLOAD_DIR}/xz-5.4.6"
}