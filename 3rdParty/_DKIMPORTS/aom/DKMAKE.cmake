#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### Alliance for Open Media ######
# https://aomedia.googlesource.com/aom.git

### DEPEND ###
dk_depend			(nasm)

### IMPORT ###
dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam		(${DKIMPORTS_DIR}/aom/dkconfig.txt AOM_DL)
dk_import			(${AOM_DL})

### LINK ###
dk_validate			(triple "dk_target_triple()")
dk_include			(${AOM_DIR})
if(MSVC)
	dk_libDebug		(${AOM_DEBUG_DIR}/aom.lib)
	dk_libRelease	(${AOM_RELEASE_DIR}/aom.lib)
else()
	dk_libDebug		(${AOM_DEBUG_DIR}/libaom.a)
	dk_libRelease	(${AOM_RELEASE_DIR}/libaom.a)
endif()

### GENERATE ###
dk_configure		(${AOM_DIR}) # -DAOM_TARGET_CPU=generic)

### COMPILE ###
dk_build			(${AOM_DIR})
