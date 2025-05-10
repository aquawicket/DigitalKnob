#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . ../../../DKBash/functions/DK.sh


##################################################################################
# DKINSTALL()
#
#
DKINSTALL() {
#	dk_debugFunc 0

	dk_call dk_getFileParams "$(dk_call dk_dirname $0)/dkconfig.txt"
	dk_call dk_validate HOST_OS "dk_host_tuple"
	######################################################################################################
	[ "${HOST_OS}" = "android" ]					&& CMAKE_IMPORT=cmake
	[ "${WSL_DISTRO_NAME-}" = "${Alpine-}" ]		&& CMAKE_IMPORT=cmake
	[ "${host_tuple}" = "win_arm32" ]				&& CMAKE_IMPORT=${CMAKE_WIN_ARM32_IMPORT}
	[ "${host_tuple}" = "win_arm64" ]				&& CMAKE_IMPORT=${CMAKE_WIN_ARM64_IMPORT}
	[ "${host_tuple}" = "win_x86" ]					&& C1MAKE_IMPORT=${CMAKE_WIN_X86_IMPORT}
	[ "${HOST_OS}_${HOST_ARCH}" = "win_x86_64" ]	&& CMAKE_IMPORT=${CMAKE_WIN_X86_64_IMPORT}
	[ "${HOST_OS}" = "mac" ]						&& CMAKE_IMPORT=${CMAKE_MAC_10_IMPORT}
	[ "${host_tuple}" = "linux_x86_64" ]			&& CMAKE_IMPORT=${CMAKE_LINUX_X86_64_IMPORT}
	[ "${host_tuple}" = "linux_arm64" ]				&& CMAKE_IMPORT=${CMAKE_LINUX_AARCH64_IMPORT}
	[ "${host_tuple}" = "raspberry_arm64" ]			&& CMAKE_IMPORT=${CMAKE_LINUX_AARCH64_IMPORT}
	
	#[ "${target_tuple}" = "android_arm32" ]		&& CMAKE_IMPORT=cmake
	[ "${target_tuple-}" = "win_arm64_clang" ]		&& CMAKE_IMPORT=mingw-w64-clang-aarch64-cmake
	[ "${target_tuple-}" = "win_x86_clang" ]		&& CMAKE_IMPORT=mingw-w64-clang-i686-cmake
	[ "${target_tuple-}" = "win_x86_mingw" ]		&& CMAKE_IMPORT=mingw-w64-i686-cmake
	[ "${target_tuple-}" = "win_x86_64_clang" ]		&& CMAKE_IMPORT=mingw-w64-clang-x86_64-cmake
	[ "${target_tuple-}" = "win_x86_64_mingw" ]		&& CMAKE_IMPORT=mingw-w64-x86_64-cmake
	[ "${target_tuple-}" = "win_x86_64_ucrt" ]		&& CMAKE_IMPORT=mingw-w64-ucrt-x86_64-cmake
	dk_call dk_printVar CMAKE_IMPORT
	
	[ -z "${CMAKE_IMPORT}" ] && dk_call dk_error "CMAKE_IMPORT is invalid"
	
	if dk_call dk_isUrl "${CMAKE_IMPORT}"; then
		dk_call dk_info "Installing CMake from direct download"
		
		dk_call dk_basename "${CMAKE_IMPORT}" CMAKE_IMPORT_FILE
		dk_call dk_removeExtension "${CMAKE_IMPORT_FILE}" CMAKE_FOLDER
		#dk_call dk_convertToCIdentifier "${CMAKE_FOLDER}" CMAKE_FOLDER
		dk_call dk_toLower "${CMAKE_FOLDER}" CMAKE_FOLDER
		
		dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
		[ "${HOST_OS}" = "win" ]       && CMAKE_EXE=${DKTOOLS_DIR}/${CMAKE_FOLDER}/bin/cmake.exe
		[ "${HOST_OS}" = "mac" ]       && CMAKE_EXE=${DKTOOLS_DIR}/${CMAKE_FOLDER}/CMake.app/Contents/bin/cmake
		[ "${HOST_OS}" = "linux" ]     && CMAKE_EXE=${DKTOOLS_DIR}/${CMAKE_FOLDER}/bin/cmake
		[ "${HOST_OS}" = "raspberry" ] && CMAKE_EXE=${DKTOOLS_DIR}/${CMAKE_FOLDER}/bin/cmake
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