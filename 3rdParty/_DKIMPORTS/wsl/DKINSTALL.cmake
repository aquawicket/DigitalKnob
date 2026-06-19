#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################

if(NOT Windows_Host)
	dk_disable(wsl)
	return()
endif()


##################### wsl ###############################################
# https://learn.microsoft.com/en-us/windows/wsl
# https://learn.microsoft.com/en-us/windows/wsl/install#install-wsl-command
# https://learn.microsoft.com/en-us/windows/wsl/install-manual
# Troubleshooting:	https://learn.microsoft.com/en-us/windows/wsl/troubleshooting
# Custom Distro:	https://learn.microsoft.com/en-us/windows/wsl/use-custom-distro

#if(NOT Windows_Host)
#	dk_disable(wsl)
#	dk_return()
#endif()

#if(Windows_Host)
#	dk_exec(wsl --install)
#endif()


if(DEFINED ENV{WSL_DISTRO_NAME})
	dk_set(WSL 1)
endif()

dk_validate(wsl_exe	"dk_depend(wsl_exe)")
dk_validate(wslpath_exe "dk_depend(wslpath_exe)")
