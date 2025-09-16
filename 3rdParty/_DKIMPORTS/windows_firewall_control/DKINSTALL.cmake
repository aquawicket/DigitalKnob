#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ windows_firewall_control ############
# https://www.binisoft.org/wfc
# https://www.binisoft.org/download/wfc6setup.exe

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT Windows_Host)
	dk_disable(windows_firewall_control)
	dk_return()
endif()




#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_set(WFCUI_EXE "${ProgramFiles}/Malwarebytes/Windows Firewall Control/wfcUI.exe")

### INSTALL ###
dk_basename(${WINDOWS_FIREWALL_CONTROL_Import} WINDOWS_FIREWALL_CONTROL_Import_File)
if(NOT EXISTS "${WFCUI_EXE}")
	dk_info("Installing ${WINDOWS_FIREWALL_CONTROL_Import_File}")
	dk_download(${WINDOWS_FIREWALL_CONTROL_Import_File})
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	dk_exec($ENV{DKDOWNLOAD_DIR}/${WINDOWS_FIREWALL_CONTROL_Import_File})
else()
	dk_notice("${WINDOWS_FIREWALL_CONTROL_Import_File} is already installed")
endif()
dk_assertPath("${WFCUI_EXE}")
