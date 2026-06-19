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


########### glintercept ############
# https://github.com/dtrebilco/glintercept.git
# https://github.com/dtrebilco/glintercept/archive/e204189eff4045c24d48b82c93d4f012ed44e166.zip
# https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe

if(NOT Windows_Host)
	dk_disable(glintercept)
	dk_return()
endif()

dk_importVariables("${glintercept_${Host_Tuple}_Import}" IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})

# if HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\GLIntercept_is1 exists
#dk_set(glintercept "$ENV{SystemDrive}/Program Files (x86)/GLIntercept_1_3_4")
if(NOT EXISTS "${glintercept}/unins000.exe")
	dk_notice("glintercept not installed")
	dk_return()
endif()

dk_echo("uninstalling glintercept . . .")
dk_exec(${glintercept}/unins000.exe /SILENT)
dk_delete("${glintercept}")

if(NOT EXISTS "${glintercept}")
	dk_success("glintercept uninstall complete")
else()
	dk_error("glintercept uninstall failed")
endif()
