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

############ msinttypes ############
# https://raw.githubusercontent.com/SummersEpsilon/msinttypes/master/msinttypes-r26.zip

if(NOT Windows_Host)
	dk_disable(msinttypes)
	dk_return()
endif()

dk_import()

dk_set(MSINTTYPES_CMAKE "-DCMAKE_C_FLAGS=/I${MSINTTYPES}" "-DCMAKE_CXX_FLAGS=/I${MSINTTYPES}")
