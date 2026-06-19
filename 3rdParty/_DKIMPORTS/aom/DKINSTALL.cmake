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


############ aom ############
# Alliance for Open Media
# https://aomedia.googlesource.com/aom.git

dk_validate(nasm "dk_depend(nasm)")

dk_import()

dk_include			(${aom})
if(MSVC)
	dk_libDebug		(${aom_Debug_Dir}/aom.lib)
	dk_libRelease	(${aom_Release_Dir}/aom.lib)
else()
	dk_libDebug		(${aom_Debug_Dir}/libaom.a)
	dk_libRelease	(${aom_Release_Dir}/libaom.a)
endif()

### GENERATE ###
dk_configure		(${aom}) # -DAOM_TARGET_CPU=generic)

### COMPILE ###
dk_build			(${aom})
