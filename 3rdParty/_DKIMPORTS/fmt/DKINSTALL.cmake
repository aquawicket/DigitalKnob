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

dk_validate(CONFIG_PATH  "dk_CONFIG_PATH()")

### DEPENDS ###
#dk_depend(python3)

### IMPORT ###
dk_import(https://github.com/fmtlib/fmt/archive/fade652a.zip)

### INCLUDE/LINK ###
dk_define(FMT_HEADER_ONLY)
dk_include(${FMT_DIR}/include)
###### Debug for FMT LIBRARY ######

# moved to DKBuildFlags.cmake
# needed by FMT library
#if(MSVC)
#	dk_append(CMAKE_C_FLAGS /utf-8)
#	dk_append(CMAKE_CXX_FLAGS /utf-8)
#endif()

#UNIX_dk_libDebug	(${FMT_DEBUG_DIR}/libfmtd.a)
#UNIX_dk_libRelease	(${FMT_RELEASE_DIR}/libfmt.a)
#Windows_dk_libDebug	(${FMT_DEBUG_DIR}/fmtd.lib)
#Windows_dk_libRelease	(${FMT_RELEASE_DIR}/fmt.lib)

### GENERATE ###
#dk_configure(${FMT_DIR} -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE)

### COMPILE ###
#dk_build(${FMT_DIR} fmt)
