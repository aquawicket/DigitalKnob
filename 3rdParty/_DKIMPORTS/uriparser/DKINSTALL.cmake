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


############ uriparser ############
# https://github.com/uriparser/uriparser
dk_validate(Config_Path  "dk_Config_Path()")

### INSTALL ###
dk_import(https://github.com/uriparser/uriparser/archive/2ab7b7df.zip)

### LINK ###
dk_define			(URI_STATIC_BUILD)
dk_include			(${URIPARSER}/include)
if(MSVC)
	dk_libDebug		(${URIPARSER_DEBUG_DIR}/uriparser.lib)
	dk_libRelease	(${URIPARSER_RELEASE_DIR}/uriparser.lib)
else()
	dk_libDebug		(${URIPARSER_DEBUG_DIR}/liburiparser.a)
	dk_libRelease	(${URIPARSER_RELEASE_DIR}/liburiparser.a)
endif()

### GENERATE ###
dk_configure(${URIPARSER}
	-DURIPARSER_BUILD_DOCS=OFF
	-DURIPARSER_BUILD_TESTS=OFF)

### COMPILE ###
dk_build(${URIPARSER} uriparser)
