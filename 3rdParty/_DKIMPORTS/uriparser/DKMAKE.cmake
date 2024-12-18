#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ uriparser ############
# https://github.com/uriparser/uriparser
dk_load(dk_builder)

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
