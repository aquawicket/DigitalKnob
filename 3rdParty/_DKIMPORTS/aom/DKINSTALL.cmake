#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ aom ############
# Alliance for Open Media
# https://aomedia.googlesource.com/aom.git
#

### DEPEND ###
dk_depend			(nasm)

### IMPORT ###
dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam		($ENV{DKIMPORTS_DIR}/aom/dkconfig.txt AOM_IMPORT)
dk_import			(${AOM_IMPORT} NAME aom)

### LINK ###
dk_validate			(target_triple "dk_target_triple()")
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
