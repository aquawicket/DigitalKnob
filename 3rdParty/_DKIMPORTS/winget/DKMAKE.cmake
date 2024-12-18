#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ winget ############
# https://learn.microsoft.com/en-us/windows/package-manager/winget

dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
dk_download(https://aka.ms/getwingetpreview ${DKDOWNLOAD_DIR}/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle)


