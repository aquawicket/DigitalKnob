#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ openblas ############
# https://github.com/xianyi/OpenBLAS.git
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/OpenMathLib/OpenBLAS/archive/8a0cd5fc.zip)

### LINK ###
dk_include			(${OPENBLAS})
if(MSVC)
	dk_libDebug		(${OPENBLAS_CONFIG_DIR}/lib/${DEBUG_DIR}/openblas.lib)
	dk_libRelease	(${OPENBLAS_CONFIG_DIR}/lib/${RELEASE_DIR}/openblas.lib)
else()
	dk_libDebug		(${OPENBLAS_DEBUG_DIR}/lib/libopenblas.a)
	dk_libRelease	(${OPENBLAS_RELEASE_DIR}/lib/libopenblas.a)
endif()

### 3RDPARTY LINK ###
#dk_set(OPENBLAS_CMAKE ???) # TODO

### GENERATE ###
dk_configure(${OPENBLAS})

### COMPILE ###
dk_build(${OPENBLAS})
