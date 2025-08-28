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


############ fmt ############
# https://github.com/fmtlib/fmt.git
# https://fmt.dev/latest/index.html

dk_validate(Target_Config  "dk_Target_Config()")

### DEPENDS ###
#dk_depend(python3)

### IMPORT ###
#dk_import(${fmt_Import})
dk_import()

### INCLUDE/LINK ###
dk_define(FMT_HEADER_ONLY)
dk_include(${FMT}/include)
###### Debug for FMT LIBRARY ######

# moved to DKBuildFlags.cmake
# needed by FMT library
#if(MSVC)
#	dk_append(CMAKE_C_FLAGS /utf-8)
#	dk_append(CMAKE_CXX_FLAGS /utf-8)
#endif()

#Unix_dk_libDebug	(${FMT_Debug_Dir}/libfmtd.a)
#Unix_dk_libRelease	(${FMT_Release_Dir}/libfmt.a)
#Windows_dk_libDebug	(${FMT_Debug_Dir}/fmtd.lib)
#Windows_dk_libRelease	(${FMT_Release_Dir}/fmt.lib)

### GENERATE ###
#dk_configure(${FMT} -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE)

### COMPILE ###
#dk_build()
