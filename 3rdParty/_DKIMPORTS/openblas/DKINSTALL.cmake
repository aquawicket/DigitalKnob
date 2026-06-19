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


############ openblas ############
# https://github.com/xianyi/OpenBLAS.git
# https://github.com/OpenMathLib/OpenBLAS/archive/8a0cd5fc.zip

dk_import()

dk_include			(${openblas})
if(MSVC)
	dk_libDebug		(${openblas_Config_Dir}/lib/${Debug_Dir}/openblas.lib)
	dk_libRelease	(${openblas_Config_Dir}/lib/${Release_Dir}/openblas.lib)
else()
	dk_libDebug		(${openblas_Debug_Dir}/lib/libopenblas.a)
	dk_libRelease	(${openblas_Release_Dir}/lib/libopenblas.a)
endif()

#dk_set(openblas_CMAKE ???) # TODO

dk_configure()

dk_build()
