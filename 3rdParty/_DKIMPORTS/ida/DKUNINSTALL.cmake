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


########### ida ############
# https://hex-rays.com/ida-free/
# https://out7.hex-rays.com/files/idafree84_windows.exe

if(NOT Windows_Host)
	dk_disable(ida)
	dk_return()
endif()

dk_validate			(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
dk_importVariables	("${ida_${Host_Tuple}_Import}" IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR} INSTALL_ROOT ${DKTOOLS_DIR})

if(NOT EXISTS "${ida}")
	dk_notice("ida is not installed")
	return()
endif()

dk_echo("uninstalling ${ida_Install_Name} . . .")

if(EXISTS "${ida}/uninstall.exe")
	dk_exec("${ida}/uninstall.exe" --mode unattended)
endif()
dk_delete(${ida})


if(NOT EXISTS "${ida}")
	dk_success("ida uninstall complete")
else()
	dk_error("ida uninstall failed")
endif()