#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/lighttpd/lighttpd1.4.git


### IMPORT ###
#dk_import(https://github.com/lighttpd/lighttpd1.4.git)
dk_import(https://github.com/lighttpd/lighttpd1.4/archive/refs/heads/master.zip)


### LINK ###
dk_include			(${LIGHTTPD}/lib)
DEBUG_dk_include	(${LIGHTTPD}/${triple}/${DEBUG_DIR})
RELEASE_dk_include	(${LIGHTTPD}/${triple}/${RELEASE_DIR})
UNIX_dk_libDebug	(${LIGHTTPD}/${triple}/lib/${DEBUG_DIR}/liblighttpd.a)
UNIX_dk_libRelease	(${LIGHTTPD}/${triple}/lib/${RELEASE_DIR}/liblighttpd.a)
WIN_dk_libDebug		(${LIGHTTPD}/${triple}/lib/${DEBUG_DIR}/liblighttpd.lib)
WIN_dk_libRelease	(${LIGHTTPD}/${triple}/lib/${RELEASE_DIR}/liblighttpd.lib)


### GENERATE ###
dk_configure(${LIGHTTPD}) # -DLWS_WITH_SSL=OFF


### COMPILE ###
dk_build(${LIGHTTPD} LIGHTTPD)
