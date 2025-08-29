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


########### ida ############
# https://hex-rays.com/ida-free/
# https://out7.hex-rays.com/files/idafree84_windows.exe
dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT Windows_Host)
	dk_undepend(ida)
	dk_return()
endif()

dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_validate			(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")

dk_importVariables("${ida_${Host_Tuple}_Import}" IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR} INSTALL_ROOT ${DKTOOLS_DIR})
dk_set				(IDA64_EXE "${IDA}/ida64.exe")

if(EXISTS "${IDA64_EXE}")
	dk_notice("ida is already installed")
	return()
endif()

dk_echo("installing ${IDA.INSTALL_NAME} . . .")
dk_download(${IDA_Url})
dk_exec("${dk_download}" --prefix "${IDA}" --mode unattended)
