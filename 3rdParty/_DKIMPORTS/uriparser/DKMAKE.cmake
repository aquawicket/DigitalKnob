#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/uriparser/uriparser

### INSTALL ###
#dk_import(https://github.com/uriparser/uriparser.git)
dk_import(https://github.com/uriparser/uriparser/archive/refs/heads/master.zip)


### LINK ###
dk_define			(URI_STATIC_BUILD)
dk_include			(${URIPARSER}/include)
UNIX_dk_libDebug	(${URIPARSER}/${triple}/${DEBUG_DIR}/liburiparser.a)
UNIX_dk_libRelease	(${URIPARSER}/${triple}/${RELEASE_DIR}/liburiparser.a)
WIN_dk_libDebug		(${URIPARSER}/${triple}/${DEBUG_DIR}/uriparser.lib)
WIN_dk_libRelease	(${URIPARSER}/${triple}/${RELEASE_DIR}/uriparser.lib)


### GENERATE ###
dk_configure(${URIPARSER}
	-DURIPARSER_BUILD_DOCS=OFF
	-DURIPARSER_BUILD_TESTS=OFF)


### COMPILE ###
dk_build(${URIPARSER} uriparser)
