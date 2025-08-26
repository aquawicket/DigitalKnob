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
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import			(${AOM_IMPORT} NAME aom)

### LINK ###
dk_validate			(Target_Tuple "dk_Target_Tuple()")
dk_include			(${AOM)
if(MSVC)
	dk_libDebug		(${AOM_Debug_Dir}/aom.lib)
	dk_libRelease	(${AOM_Release_Dir}/aom.lib)
else()
	dk_libDebug		(${AOM_Debug_Dir}/libaom.a)
	dk_libRelease	(${AOM_Release_Dir}/libaom.a)
endif()

### GENERATE ###
dk_configure		(${AOM}) # -DAOM_TARGET_CPU=generic)

### COMPILE ###
dk_build			(${AOM})
