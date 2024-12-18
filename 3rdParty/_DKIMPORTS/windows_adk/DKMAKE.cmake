#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ windows_adk ############
# https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install


dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
dk_download(https://go.microsoft.com/fwlink/?linkid=2289980 "${DKDOWNLOAD_DIR}/adksetup.exe")
dk_download(https://go.microsoft.com/fwlink/?linkid=2289981 "${DKDOWNLOAD_DIR}/adkwinpesetup.exe")

