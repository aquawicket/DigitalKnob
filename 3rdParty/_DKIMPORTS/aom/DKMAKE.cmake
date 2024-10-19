#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)

###### Alliance for Open Media ######
# https://aomedia.googlesource.com/aom.git



### IMPORT ###
#dk_import(https://aomedia.googlesource.com/aom.git)
dk_import(https://aomedia.googlesource.com/aom.git/+archive/c2fe6bf370f7c14fbaf12884b76244a3cfd7c5fc.tar.gz)


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
