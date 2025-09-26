#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
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
	#[ "${Host_Os}" = "Android" ]                		&& cmake_Import=cmake
	[ "${Host_Tuple}" = "Linux_Arm64" ]         		&& cmake_Import=${CMake_Linux_Arm64_Import}
	[ "${Host_Tuple}" = "Raspberry_Arm64" ]     		&& cmake_Import=${CMake_Linux_Arm64_Import}
	[ "${Host_Tuple}" = "Linux_X86_64" ]        		&& cmake_Import=${CMake_Linux_X86_64_Import}
	[ "${Host_Os}" = "Mac" ]                     		&& cmake_Import=${CMake_Mac_X86_64_Import}
	[ "${Host_Os}_${Host_Arch}" = "Windows_Arm32" ]  	&& cmake_Import=${CMake_Windows_Arm32_Import}
	[ "${Host_Os}_${Host_Arch}" = "Windows_Arm64" ]  	&& cmake_Import=${CMake_Windows_Arm64_Import}
	[ "${Host_Os}_${Host_Arch}" = "Windows_X86" ]    	&& cmake_Import=${CMake_Windows_X86_Import}
	[ "${Host_Os}_${Host_Arch}" = "Windows_X86_64" ] 	&& cmake_Import=${CMake_Windows_X86_64_Import}

	[ "${WSL_DISTRO_NAME-}" = "Alpine" ]		 		&& cmake_Import=cmake
	#[ "${Target_Tuple-}" = "Android_Arm32" ]			&& cmake_Import=cmake
	#[ "${Target_Tuple-}" = "Windows_Arm64_Clang" ]		&& cmake_Import=mingw-w64-clang-aarch64-cmake
	#[ "${Target_Tuple-}" = "Windows_X86_Clang" ]		&& cmake_Import=mingw-w64-clang-i686-cmake
	#[ "${Target_Tuple-}" = "Windows_X86_Gcc" ]			&& cmake_Import=mingw-w64-i686-cmake
	#[ "${Target_Tuple-}" = "Windows_X86_64_Clang" ]	&& cmake_Import=mingw-w64-clang-x86_64-cmake
	#[ "${Target_Tuple-}" = "Windows_X86_64_Gcc" ]		&& cmake_Import=mingw-w64-x86_64-cmake
	#[ "${Target_Tuple-}" = "Windows_X86_64_Ucrt" ]		&& cmake_Import=mingw-w64-ucrt-x86_64-cmake
	[ -z ${cmake_Import-} ]								&& cmake_Import=cmake  #Default
	dk_call dk_assertVar cmake_Import
	
	if dk_call dk_isUrl "${cmake_Import}"; then
		dk_call dk_info "Installing CMake from file download"
		
		cmake_Import_File=$(dk_call dk_basename "${cmake_import}")
		dk_call dk_removeExtension ${cmake_Import_File} cmake_Folder
		#dk_call dk_convertToCIdentifier "${cmake_Folder}" cmake_Folder
		dk_call dk_toLower ${cmake_Folder} cmake_Folder
		dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
		cmake="${DKTOOLS_DIR}/${cmake_Folder}"
		
		[ "${Host_Os}" = "Windows" ]   && cmake_exe=${cmake}/bin/cmake.exe
		[ "${Host_Os}" = "Mac" ]       && cmake_exe=${cmake}/CMake.app/Contents/bin/cmake
		[ "${Host_Os}" = "Linux" ]     && cmake_exe=${cmake}/bin/cmake
		[ "${Host_Os}" = "Raspberry" ] && cmake_exe=${cmake}/bin/cmake
		[ -z ${cmake_exe} ]            && dk_call dk_error "no cmake found for this OS"
		dk_call dk_assertVar cmake_exe
		
		dk_call dk_pathExists "${cmake_exe}" && return $(true);
		
		dk_call dk_echo
		dk_call dk_info "Installing cmake . . ."
		dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
		dk_call dk_download "${cmake_Import}" "${DKDOWNLOAD_DIR}"/"${cmake_Import_File}"
		#dk_call dk_extract "${dk_download}" "${DKTOOLS_DIR}"
		dk_call dk_smartExtract	"${dk_download}" "${cmake}"
		
		#dk_call dk_removeExtension ${cmake_Import_File} cmake_Import_Name
		#dk_call dk_rename "${DKTOOLS_DIR}/${cmake_Import_Name}" "${cmake}"
        
		dk_call dk_pathExists "${cmake_exe}" || dk_call dk_error "cannot find cmake"

	else	# Linux package
		dk_call dk_info "Installing CMake from package managers"
		
		export cmake_exe="$(command -v cmake)" || $(true)
		#dk_call dk_pathExists ${cmake_exe} && cmake_exe=$(realpath ${cmake_exe})
		#dk_call dk_realpath ${cmake_exe} cmake_exe
		#dk_call dk_printVar cmake_exe
		dk_call dk_commandExists cmake || dk_call dk_installPackage ${cmake_Import}
		export cmake_exe="$(command -v cmake)"
		#cmake_exe=$(dk_call dk_realpath "${cmake_exe}")
		dk_call dk_assertVar cmake_exe
	fi
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_installCmake
}
