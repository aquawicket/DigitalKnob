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


############ java ############
# https://www.java.com/en/download
# https://javadl.oracle.com/webapps/download/AutoDL?BundleId=245479_4d5417147a92418ea8b615e228bb6935
# http://deb.sambaedu.org/wpkg/files/jre/jre-8u311-windows-x64.exe
dk_validate(Host_Tuple "dk_Host_Tuple()")
dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_importVariables("${java_${Host_Tuple}_Import}" IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})

if(NOT EXISTS "${JAVA}")
	dk_notice("java is not installed")
	dk_return()
endif()

dk_echo("uninstalling java . . .")
dk_exec(msiexec /x {71024AE4-039E-4CA4-87B4-2F64180451F0} /quiet)
dk_delete(${JAVA})

if(NOT EXISTS "${JAVA}")
	dk_success("java uninstall complete")
else()
	k_error("java uninstall failed")
endif()