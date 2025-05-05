#!/usr/bin/env sh
##################################################################################
[ -z "${DK_SH-}" ] && . ../../../DKBash/functions/DK.sh
##################################################################################


####################################################################
# DKUNINSTALL()
#
DKUNINSTALL

	dk_call dk_debugFunc 0
	
	::######### kill cmake.exe process #########
	dk_call dk_killProcess cmake.exe

	::######### kill cmake-gui.exe process #########
	dk_call dk_killProcess cmake-gui.exe
	
	dk_basename = $(dk_call dk_basename ${0})
	dk_call dk_getFileParams 		"${dk_basename}/dkconfig.txt"
	dk_call dk_validate 			Host_Triple "dk_call dk_Host_Triple"
	if defined LINUX_ARM64_HOST		(CMAKE_IMPORT=${CMAKE_LINUX_AARCH64_IMPORT}")
	if defined LINUX_X86_64_HOST	(CMAKE_IMPORT=${CMAKE_LINUX_X86_64_IMPORT}")
	if defined MAC_HOST				(CMAKE_IMPORT=${CMAKE_MAC_UNIVERSAL_IMPORT}")
	if defined WIN_ARM64_HOST		(CMAKE_IMPORT=${CMAKE_WIN_ARM64_IMPORT}")
	if defined WIN_X86_64_HOST		(CMAKE_IMPORT=${CMAKE_WIN_X86_64_IMPORT}")
	if defined WIN_X86_HOST			(CMAKE_IMPORT=${CMAKE_WIN_X86_IMPORT}")
	dk_call dk_assertVar 			CMAKE_IMPORT
	
	dk_call dk_basename "${CMAKE_IMPORT}" CMAKE_IMPORT_FILE
	
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
	dk_call dk_importVariables ${CMAKE_IMPORT} NAME cmake ROOT ${DKTOOLS_DIR}
	
	dk_call dk_assertVar CMAKE
	dk_call dk_delete 				"${CMAKE}"
	
	CMAKE_EXE="${CMAKE}/bin/cmake.exe"
	
::	if exist "${CMAKE_EXE}" 			(${return})
	dk_call dk_notice 			"UnInstalling CMake . . ."
::	dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"

::	dk_call dk_download 			"${CMAKE_IMPORT}" "${DKDOWNLOAD_DIR}/${CMAKE_IMPORT_FILE}"
::	dk_call dk_smartExtract 		"${DKDOWNLOAD_DIR}/${CMAKE_IMPORT_FILE}" "${CMAKE}"

::	dk_call dk_firewallAllow 		"CMake" "${CMAKE}/bin/cmake.exe"
::	dk_call dk_assertPath 		"${CMAKE_EXE}"
	
	dk_call dk_echo 				"${CMAKE}"
	dk_call dk_delete 			"${CMAKE}"
}




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal}
	dk_call dk_debugFunc 0
	
	call :DKUNINSTALL
%endfunction}