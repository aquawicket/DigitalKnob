#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . ../../../DKBash/functions/DK.sh


##################################################################################
# DKINSTALL()
#
#
DKINSTALL() {
#	dk_debugFunc 0

	dk_call dk_getFileParams "$(dk_call dk_dirname $0)/dkconfig.txt"
	dk_call dk_validate Host_Tuple "dk_Host_Tuple"
	######################################################################################################
	[ "${Host_Os}" = "Android" ]					&& CMAKE_IMPORT=cmake
	[ "${WSL_DISTRO_NAME-}" = "${Alpine-}" ]		&& CMAKE_IMPORT=cmake
	[ "${Host_Tuple}" = "Win_Arm32" ]				&& CMAKE_IMPORT=${CMAKE_Win_ARM32_IMPORT}
	[ "${Host_Tuple}" = "Win_Arm64" ]				&& CMAKE_IMPORT=${CMAKE_Win_ARM64_IMPORT}
	[ "${Host_Tuple}" = "Win_X86" ]					&& C1MAKE_IMPORT=${CMAKE_Win_X86_IMPORT}
	[ "${Host_Os}_${Host_Arch}" = "Win_X86_64" ]	&& CMAKE_IMPORT=${CMAKE_WIN_X86_64_IMPORT}
	[ "${Host_Os}" = "Mac" ]						&& CMAKE_IMPORT=${CMAKE_MAC_10_IMPORT}
	[ "${Host_Tuple}" = "Linux_X86_64" ]			&& CMAKE_IMPORT=${CMAKE_LINUX_X86_64_IMPORT}
	[ "${Host_Tuple}" = "Linux_Arm64" ]				&& CMAKE_IMPORT=${CMAKE_LINUX_AARCH64_IMPORT}
	[ "${Host_Tuple}" = "Raspberry_Arm64" ]			&& CMAKE_IMPORT=${CMAKE_LINUX_AARCH64_IMPORT}
	
	#[ "${Target_Tuple}" = "Android_Arm32" ]		&& CMAKE_IMPORT=cmake
	[ "${Target_Tuple-}" = "Win_arm64_Clang" ]		&& CMAKE_IMPORT=mingw-w64-clang-aarch64-cmake
	[ "${Target_Tuple-}" = "Win_X86_Clang" ]		&& CMAKE_IMPORT=mingw-w64-clang-i686-cmake
	[ "${Target_Tuple-}" = "Win_x86_MinGW" ]		&& CMAKE_IMPORT=mingw-w64-i686-cmake
	[ "${Target_Tuple-}" = "Win_X86_64_Clang" ]		&& CMAKE_IMPORT=mingw-w64-clang-x86_64-cmake
	[ "${Target_Tuple-}" = "Win_x86_64_MinGW" ]		&& CMAKE_IMPORT=mingw-w64-x86_64-cmake
	[ "${Target_Tuple-}" = "Win_x86_64_Ucrt" ]		&& CMAKE_IMPORT=mingw-w64-ucrt-x86_64-cmake
	dk_call dk_printVar CMAKE_IMPORT
	
	[ -z "${CMAKE_IMPORT}" ] && dk_call dk_error "CMAKE_IMPORT is invalid"
	
	if dk_call dk_isUrl "${CMAKE_IMPORT}"; then
		dk_call dk_info "Installing CMake from direct download"
		
		dk_call dk_basename "${CMAKE_IMPORT}" CMAKE_IMPORT_FILE
		dk_call dk_removeExtension "${CMAKE_IMPORT_FILE}" CMAKE_FOLDER
		#dk_call dk_convertToCIdentifier "${CMAKE_FOLDER}" CMAKE_FOLDER
		dk_call dk_toLower "${CMAKE_FOLDER}" CMAKE_FOLDER
		
		dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
		[ "${Host_Os}" = "win" ]       && CMAKE_EXE=${DKTOOLS_DIR}/${CMAKE_FOLDER}/bin/cmake.exe
		[ "${Host_Os}" = "mac" ]       && CMAKE_EXE=${DKTOOLS_DIR}/${CMAKE_FOLDER}/CMake.app/Contents/bin/cmake
		[ "${Host_Os}" = "linux" ]     && CMAKE_EXE=${DKTOOLS_DIR}/${CMAKE_FOLDER}/bin/cmake
		[ "${Host_Os}" = "raspberry" ] && CMAKE_EXE=${DKTOOLS_DIR}/${CMAKE_FOLDER}/bin/cmake
		[ -z ${CMAKE_EXE} ]            && dk_call dk_error "no cmake for this OS"
		dk_call dk_printVar CMAKE_EXE
		
		dk_call dk_pathExists "${CMAKE_EXE}" && return $(true)

		dk_call dk_echo
		dk_call dk_info "Installing cmake . . ."
		dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
		dk_call dk_download "${CMAKE_IMPORT}" "${DKDOWNLOAD_DIR}"/"${CMAKE_IMPORT_FILE}"
		#dk_call dk_extract "${DKDOWNLOAD_DIR}"/"${CMAKE_IMPORT_FILE}" "${DKTOOLS_DIR}"
		#dk_call dk_removeExtension ${CMAKE_IMPORT_NAME} CMAKE_IMPORT_NAME
		#dk_call dk_rename "${DKTOOLS_DIR}/${CMAKE_IMPORT_NAME}" "${CMAKE_FOLDER}"
		#echo ${CMAKE_FOLDER}>"${DKTOOLS_DIR}\${CMAKE_FOLDER}\installed"
		dk_call dk_smartExtract "${DKDOWNLOAD_DIR}"/"${CMAKE_IMPORT_FILE}" "${DKTOOLS_DIR}"
		dk_call dk_pathExists "${CMAKE_EXE}" || dk_call dk_error "cannot find cmake.exe"; return -1

	else	# linux package
		dk_call dk_info "Installing CMake from package managers"
		
		$(command -v cmake) && CMAKE_EXE=$(command -v cmake)
		dk_call dk_realpath ${CMAKE_EXE} CMAKE_EXE
		dk_call dk_printVar CMAKE_EXE
		if ! dk_call dk_commandExists cmake; then
			dk_call dk_installPackage ${CMAKE_IMPORT}
		fi	
		CMAKE_EXE=$(command -v cmake)
		dk_call dk_realpath ${CMAKE_EXE} CMAKE_EXE
		dk_call dk_printVar CMAKE_EXE
	fi
}
















###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
#	dk_debugFunc 0
	
	DKINSTALL
}