#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ windows-sdk ############
# https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/
#	Windows SDK for Windows 11 (10.0.22621.2428)	Released October 2023.
#	Windows SDK for Windows 11 (10.0.22621.1778)	Released in May 2023.
#	Windows SDK for Windows 11 (10.0.22621.755)		Released as part of Windows 11, version 22H2. Includes servicing update 10.0.22000.755 on October 25, 2022: ARM64 support 
#	Windows SDK for Windows 11 (10.0.22000.194)		Released in Windows 11. w/ servicing update 10.0.22000.832 on July 29, 2022: Critical updates for developers building Arm64EC applications
#	Windows 10 SDK version 2104 (10.0.20348.0)		intended for Windows Server development. For desktop development, see the release notes for changes you may benefit from by updating.	


dk_import(https://go.microsoft.com/fwlink/?linkid=2272523)   # iso
#dk_import(https://go.microsoft.com/fwlink/?linkid=2272610)  # installer