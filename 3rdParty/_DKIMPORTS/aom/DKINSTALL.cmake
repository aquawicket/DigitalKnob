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


############ aom ############
# Alliance for Open Media
# https://aomedia.googlesource.com/aom.git

### DEPEND ###
dk_depend			(nasm)

### IMPORT ###
#dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
#dk_import			(${aom_Import} NAME aom)
dk_import			()

### LINK ###
dk_validate			(Target_Tuple "dk_Target_Tuple()")
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
