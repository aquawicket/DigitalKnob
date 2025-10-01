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


############ windows-sdk ############
# https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/26100.1.240331-1435.ge_release_WindowsSDK.iso
# https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/
# Windows SDK for Windows 11 (10.0.22621.2428)		Released October 2023.
# Windows SDK for Windows 11 (10.0.22621.1778)		Released in May 2023.
# Windows SDK for Windows 11 (10.0.22621.755)		Released as part of Windows 11, version 22H2. Servicing update 10.0.22000.755 on 10/25/22: ARM64 support 
# Windows SDK for Windows 11 (10.0.22000.194)		Released in Windows 11. w/ servicing update 10.0.22000.832 on 7/29/22: Critical updates for building Arm64EC
# Windows 10 SDK version 2104 (10.0.20348.0)		Windows Server development. Desktop development, see release notes for changes than benefit by updating.	
# https://go.microsoft.com/fwlink/?linkid=2272523)	# iso
# https://go.microsoft.com/fwlink/?linkid=2272610)	# installer
# https://aka.ms/windowsappsdk/1.8/1.8.250916003/windowsappruntimeinstall-arm64.exe
# https://aka.ms/windowsappsdk/1.8/1.8.250916003/windowsappruntimeinstall-x86.exe
# https://aka.ms/windowsappsdk/1.8/1.8.250916003/windowsappruntimeinstall-x64.exe


dk_import()
dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
dk_debug("${DKDOWNLOAD_DIR}/${${CURRENT_PLUGIN}_Download_Basename}")
dk_exec("${DKDOWNLOAD_DIR}/${${CURRENT_PLUGIN}_Download_Basename}")
