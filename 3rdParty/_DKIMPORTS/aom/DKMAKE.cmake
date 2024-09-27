#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://aomedia.googlesource.com/aom.git




### IMPORT ###
dk_import(https://aomedia.googlesource.com/aom.git)


### LINK ###
dk_include			(${AOM_DIR})
if(MSVC)
	dk_libDebug		(${AOM_DEBUG_DIR}/aom.lib)
	dk_libRelease	(${AOM_RELEASE_DIR}/aom.lib)
else()
	dk_libDebug		(${AOM_DEBUG_DIR}/libaom.a)
	dk_libRelease	(${AOM_RELEASE_DIR}/libaom.a)
endif()




### GENERATE ###
dk_configure(${AOM_DIR} -DAOM_TARGET_CPU=generic)


### COMPILE ###
dk_build(${AOM_DIR})
