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

####################################################################
# dk_SH_EXE()
#
#
function(dk_SH_EXE)
	dk_debugFunc()

	if(EXISTS "${SH_EXE}")
		dk_debug("SH_EXE:${SH_EXE} already set")
		return()
	endif()

	### from SH_EXE environment variable ###
	if(NOT EXISTS "${SH_EXE}")
		dk_set(SH_EXE "$ENV{SH_EXE}")
	endif()
	
	### from SH environment variable ###
	if(NOT EXISTS "${SH_EXE}")
		dk_set(SH_EXE "$ENV{SH}")
	endif()

	### from Msys2 bash ###
	if(NOT EXISTS "${SH_EXE}")
		dk_depend(msys2)
		dk_findProgram(MSYS2_SH_EXE sh "${msys2}/usr/bin")
		dk_set(SH_EXE ${msys2_SH_EXE})
	endif()
	
	if(NOT EXISTS "${SH_EXE}")
		dk_fatal("SH_EXE:${SH_EXE} not found")
		return()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_SH_EXE()
	if(EXISTS "${SH_EXE}")
		dk_success("SH_EXE = ${SH_EXE}")
	else()
		dk_error("SH_EXE = ${SH_EXE}")
	endif()
endfunction()
