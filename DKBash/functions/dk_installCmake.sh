#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
CMake_Linux_Arm64_Import=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-aarch64.tar.gz
CMake_Linux_X86_64_Import=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-x86_64.tar.gz
CMake_Mac_X86_64_Import=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos-universal.tar.gz
#CMake_Mac_X86_64_Import=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos10.10-universal.tar.gz
CMake_Windows_Arm64_Import=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-arm64.zip
CMake_Windows_X86_Import=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-i386.zip
CMake_Windows_X86_64_Import=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip
##################################################################################
# dk_installCmake()
#
#
dk_installCmake() {
	dk_debugFunc 0
	
	dk_call dk_validate Host_Os "dk_call dk_Host_Os"	
	######################################################################################################
	#[ "${Host_Os}" = "Android" ]                		&& CMAKE_IMPORT=cmake
	[ "${Host_Tuple}" = "Linux_Arm64" ]         		&& CMAKE_IMPORT=${CMake_Linux_Arm64_Import}
	[ "${Host_Tuple}" = "Raspberry_Arm64" ]     		&& CMAKE_IMPORT=${CMake_Linux_Arm64_Import}
	[ "${Host_Tuple}" = "Linux_X86_64" ]        		&& CMAKE_IMPORT=${CMake_Linux_X86_64_Import}
	[ "${Host_Os}" = "Mac" ]                     		&& CMAKE_IMPORT=${CMake_Mac_X86_64_Import}
	[ "${Host_Os}_${Host_Arch}" = "Windows_Arm32" ]  	&& CMAKE_IMPORT=${CMake_Windows_Arm32_Import}
	[ "${Host_Os}_${Host_Arch}" = "Windows_Arm64" ]  	&& CMAKE_IMPORT=${CMake_Windows_Arm64_Import}
	[ "${Host_Os}_${Host_Arch}" = "Windows_X86" ]    	&& CMAKE_IMPORT=${CMake_Windows_X86_Import}
	[ "${Host_Os}_${Host_Arch}" = "Windows_X86_64" ] 	&& CMAKE_IMPORT=${CMake_Windows_X86_64_Import}

	[ "${WSL_DISTRO_NAME-}" = "Alpine" ]		 		&& CMAKE_IMPORT=cmake
	#[ "${Target_Tuple-}" = "Android_Arm32" ]			&& CMAKE_IMPORT=cmake
	#[ "${Target_Tuple-}" = "Windows_Arm64_Clang" ]		&& CMAKE_IMPORT=mingw-w64-clang-aarch64-cmake
	#[ "${Target_Tuple-}" = "Windows_X86_Clang" ]		&& CMAKE_IMPORT=mingw-w64-clang-i686-cmake
	#[ "${Target_Tuple-}" = "Windows_X86_Gcc" ]			&& CMAKE_IMPORT=mingw-w64-i686-cmake
	#[ "${Target_Tuple-}" = "Windows_X86_64_Clang" ]	&& CMAKE_IMPORT=mingw-w64-clang-x86_64-cmake
	#[ "${Target_Tuple-}" = "Windows_X86_64_Gcc" ]		&& CMAKE_IMPORT=mingw-w64-x86_64-cmake
	#[ "${Target_Tuple-}" = "Windows_X86_64_Ucrt" ]		&& CMAKE_IMPORT=mingw-w64-ucrt-x86_64-cmake
	[ -z ${CMAKE_IMPORT-} ]								&& CMAKE_IMPORT=cmake  #Default
	dk_call dk_assertVar CMAKE_IMPORT
	
	if dk_call dk_isUrl "${CMAKE_IMPORT}"; then
		dk_call dk_info "Installing CMake from file download"
		
		CMAKE_IMPORT_FILE=$(dk_call dk_basename "${CMAKE_IMPORT}")
		dk_call dk_removeExtension ${CMAKE_IMPORT_FILE} CMAKE_FOLDER
		#dk_call dk_convertToCIdentifier "${CMAKE_FOLDER}" CMAKE_FOLDER
		dk_call dk_toLower ${CMAKE_FOLDER} CMAKE_FOLDER
		dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
		CMAKE_DIR="${DKTOOLS_DIR}/${CMAKE_FOLDER}"
		
		[ "${Host_Os}" = "Windows" ]   && CMAKE_EXE=${CMAKE_DIR}/bin/cmake.exe
		[ "${Host_Os}" = "Mac" ]       && CMAKE_EXE=${CMAKE_DIR}/CMake.app/Contents/bin/cmake
		[ "${Host_Os}" = "Linux" ]     && CMAKE_EXE=${CMAKE_DIR}/bin/cmake
		[ "${Host_Os}" = "Raspberry" ] && CMAKE_EXE=${CMAKE_DIR}/bin/cmake
		[ -z ${CMAKE_EXE} ]            && dk_call dk_error "no cmake found for this OS"
		dk_call dk_assertVar CMAKE_EXE
		
		dk_call dk_pathExists "${CMAKE_EXE}" && return $(true);
		
		dk_call dk_echo
		dk_call dk_info "Installing cmake . . ."
		dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
		dk_call dk_download "${CMAKE_IMPORT}" "${DKDOWNLOAD_DIR}"/"${CMAKE_IMPORT_FILE}"
		#dk_call dk_extract "${DKDOWNLOAD_DIR}/${CMAKE_IMPORT_FILE}" "${DKTOOLS_DIR}"
		dk_call dk_smartExtract	"${DKDOWNLOAD_DIR}/${CMAKE_IMPORT_FILE}" "${CMAKE_DIR}"
		
		#dk_call dk_removeExtension ${CMAKE_IMPORT_FILE} CMAKE_DL_NAME
		#dk_call dk_rename "${DKTOOLS_DIR}/${CMAKE_DL_NAME}" "${CMAKE_DIR}"
        
		dk_call dk_pathExists "${CMAKE_EXE}" || dk_call dk_error "cannot find cmake"

	else	# Linux package
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
