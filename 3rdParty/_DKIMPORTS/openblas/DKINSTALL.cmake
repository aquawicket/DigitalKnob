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


############ openblas ############
# https://github.com/xianyi/OpenBLAS.git
dk_validate(Target_Config  "dk_Target_Config()")

### IMPORT ###
dk_import(https://github.com/OpenMathLib/OpenBLAS/archive/8a0cd5fc.zip)

### LINK ###
dk_include			(${OPENBLAS})
if(MSVC)
	dk_libDebug		(${OPENBLAS_Config_Dir}/lib/${Debug_Dir}/openblas.lib)
	dk_libRelease	(${OPENBLAS_Config_Dir}/lib/${Release_Dir}/openblas.lib)
else()
	dk_libDebug		(${OPENBLAS_Debug_Dir}/lib/libopenblas.a)
	dk_libRelease	(${OPENBLAS_Release_Dir}/lib/libopenblas.a)
endif()

### 3RDPARTY LINK ###
#dk_set(OPENBLAS_CMAKE ???) # TODO

### GENERATE ###
dk_configure()

### COMPILE ###
dk_build()
