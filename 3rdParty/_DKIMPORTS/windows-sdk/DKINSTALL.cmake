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
# https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/
#	Windows SDK for Windows 11 (10.0.22621.2428)	Released October 2023.
#	Windows SDK for Windows 11 (10.0.22621.1778)	Released in May 2023.
#	Windows SDK for Windows 11 (10.0.22621.755)		Released as part of Windows 11, version 22H2. Includes servicing update 10.0.22000.755 on October 25, 2022: ARM64 support 
#	Windows SDK for Windows 11 (10.0.22000.194)		Released in Windows 11. w/ servicing update 10.0.22000.832 on July 29, 2022: Critical updates for developers building Arm64EC applications
#	Windows 10 SDK version 2104 (10.0.20348.0)		intended for Windows Server development. For desktop development, see the release notes for changes you may benefit from by updating.	

dk_set(CURRENT_PLUGIN "WINDOWS_SDK")
dk_set(CURRENT_IMPORT "${CMAKE_CURRENT_LIST_DIR}")
#dk_import(https://go.microsoft.com/fwlink/?linkid=2272523)   # iso
dk_import(https://go.microsoft.com/fwlink/?linkid=2272610)  # installer

dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
dk_exec(${DKDOWNLOAD_DIR}/winsdksetup.exe)