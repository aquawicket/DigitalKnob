#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


CMAKE_DL_LINUX_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-aarch64.tar.gz
CMAKE_DL_LINUX_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-x86_64.tar.gz
CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos-universal.tar.gz
#CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos10.10-universal.tar.gz
CMAKE_DL_WIN_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-arm64.zip
CMAKE_DL_WIN_X86=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-i386.zip
CMAKE_DL_WIN_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip
##################################################################################
# dk_installCmake()
#
#
dk_installCmake() {
	dk_debugFunc 0
	
	dk_call dk_validate HOST_OS "dk_call dk_host_triple"	
	######################################################################################################
	#[ "${HOST_OS}" = "android" ]                && CMAKE_IMPORT=cmake
	[ "${HOST_OS}_${HOST_ARCH}" = "win_arm32" ]  && CMAKE_IMPORT=${CMAKE_DL_WIN_ARM32}
	[ "${HOST_OS}_${HOST_ARCH}" = "win_arm64" ]  && CMAKE_IMPORT=${CMAKE_DL_WIN_ARM64}
	[ "${HOST_OS}_${HOST_ARCH}" = "win_x86" ]    && CMAKE_IMPORT=${CMAKE_DL_WIN_X86}
	[ "${HOST_OS}_${HOST_ARCH}" = "win_x86_64" ] && CMAKE_IMPORT=${CMAKE_DL_WIN_X86_64}
	[ "${HOST_OS}" = "mac" ]                     && CMAKE_IMPORT=${CMAKE_DL_MAC}
	[ "${host_triple}" = "linux_x86_64" ]        && CMAKE_IMPORT=${CMAKE_DL_LINUX_X86_64}
	[ "${host_triple}" = "linux_arm64" ]         && CMAKE_IMPORT=${CMAKE_DL_LINUX_ARM64}
	[ "${host_triple}" = "raspberry_arm64" ]     && CMAKE_IMPORT=${CMAKE_DL_LINUX_ARM64}
	[ "${WSL_DISTRO_NAME-}" = "Alpine" ]		 && CMAKE_IMPORT=cmake
	#[ "${target_triple}" = "android_arm32" ]       	 && CMAKE_IMPORT=cmake
	#[ "${target_triple-}" = "win_arm64_clang" ]    	 && CMAKE_IMPORT=mingw-w64-clang-aarch64-cmake
	#[ "${target_triple-}" = "win_x86_clang" ]      	 && CMAKE_IMPORT=mingw-w64-clang-i686-cmake
	#[ "${target_triple-}" = "win_x86_mingw" ]      	 && CMAKE_IMPORT=mingw-w64-i686-cmake
	#[ "${target_triple-}" = "win_x86_64_clang" ]   	 && CMAKE_IMPORT=mingw-w64-clang-x86_64-cmake
	#[ "${target_triple-}" = "win_x86_64_mingw" ]   	 && CMAKE_IMPORT=mingw-w64-x86_64-cmake
	#[ "${target_triple-}" = "win_x86_64_ucrt" ]    	 && CMAKE_IMPORT=mingw-w64-ucrt-x86_64-cmake
	[ -z ${CMAKE_IMPORT-} ] 					 && CMAKE_IMPORT=cmake  #Default
	dk_call dk_assertVar CMAKE_IMPORT
	
	if dk_call dk_isUrl "${CMAKE_IMPORT}"; then
		dk_call dk_info "Installing CMake from file download"
		
		CMAKE_DL_FILE=$(dk_call dk_basename "${CMAKE_IMPORT}")
		dk_call dk_removeExtension ${CMAKE_DL_FILE} CMAKE_FOLDER
		#dk_call dk_convertToCIdentifier "${CMAKE_FOLDER}" CMAKE_FOLDER
		dk_call dk_toLower ${CMAKE_FOLDER} CMAKE_FOLDER
		dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
		CMAKE_DIR="${DKTOOLS_DIR}/${CMAKE_FOLDER}"
		
		[ "${HOST_OS}" = "win" ]       && CMAKE_EXE=${CMAKE_DIR}/bin/cmake.exe
		[ "${HOST_OS}" = "mac" ]       && CMAKE_EXE=${CMAKE_DIR}/CMake.app/Contents/bin/cmake
		[ "${HOST_OS}" = "linux" ]     && CMAKE_EXE=${CMAKE_DIR}/bin/cmake
		[ "${HOST_OS}" = "raspberry" ] && CMAKE_EXE=${CMAKE_DIR}/bin/cmake
		[ -z ${CMAKE_EXE} ]            && dk_call dk_error "no cmake found for this OS"
		dk_call dk_assertVar CMAKE_EXE
		
		dk_call dk_pathExists "${CMAKE_EXE}" && return $(true);
		
		dk_call dk_echo
		dk_call dk_info "Installing cmake . . ."
		dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
		dk_call dk_download "${CMAKE_IMPORT}" "${DKDOWNLOAD_DIR}"/"${CMAKE_DL_FILE}"
		#dk_call dk_extract "${DKDOWNLOAD_DIR}/${CMAKE_DL_FILE}" "${DKTOOLS_DIR}"
		dk_call dk_smartExtract	"${DKDOWNLOAD_DIR}/${CMAKE_DL_FILE}" "${CMAKE_DIR}"
		
		#dk_call dk_removeExtension ${CMAKE_DL_FILE} CMAKE_DL_NAME
		#dk_call dk_rename "${DKTOOLS_DIR}/${CMAKE_DL_NAME}" "${CMAKE_DIR}"
        
		dk_call dk_pathExists "${CMAKE_EXE}" || dk_call dk_error "cannot find cmake"

	else	# linux package
		dk_call dk_info "Installing CMake from package managers"
		
		export CMAKE_EXE="$(command -v cmake)" || $(true)
		#dk_call dk_pathExists ${CMAKE_EXE} && CMAKE_EXE=$(realpath ${CMAKE_EXE})
		#dk_call dk_realpath ${CMAKE_EXE} CMAKE_EXE
		#dk_call dk_printVar CMAKE_EXE
		dk_call dk_commandExists cmake || dk_call dk_installPackage ${CMAKE_IMPORT}
		export CMAKE_EXE="$(command -v cmake)"
		#CMAKE_EXE=$(dk_call dk_realpath "${CMAKE_EXE}")
		dk_call dk_assertVar CMAKE_EXE
	fi
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_installCmake
}
