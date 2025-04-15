#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ windows_firewall_control ############
# https://www.binisoft.org/wfc
# https://www.binisoft.org/download/wfc6setup.exe

dk_validate(host_triple "dk_host_triple()")
if(NOT WIN_HOST)
	dk_undepend(windows_firewall_control)
	dk_return()
endif()




dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParam("$ENV{DKIMPORTS_DIR}/windows_firewall_control/dkconfig.txt" WINDOWS_FIREWALL_CONTROL_IMPORT)
dk_set(WFCUI_EXE "${ProgramFiles}/Malwarebytes/Windows Firewall Control/wfcUI.exe")

### INSTALL ###
dk_basename(${WINDOWS_FIREWALL_CONTROL_IMPORT} WINDOWS_FIREWALL_CONTROL_IMPORT_FILE)
if(NOT EXISTS "${WFCUI_EXE}")
	dk_info("Installing ${WINDOWS_FIREWALL_CONTROL_IMPORT_FILE}")
	dk_download(${WINDOWS_FIREWALL_CONTROL_IMPORT_FILE})
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	dk_command($ENV{DKDOWNLOAD_DIR}/${WINDOWS_FIREWALL_CONTROL_IMPORT_FILE})
else()
	dk_notice("${WINDOWS_FIREWALL_CONTROL_IMPORT_FILE} is already installed")
endif()
dk_assertPath("${WFCUI_EXE}")
