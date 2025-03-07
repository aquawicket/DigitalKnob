#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://github.com/lighttpd/lighttpd1.4.git


### IMPORT ###
#dk_import(https://github.com/lighttpd/lighttpd1.4.git)
dk_import(https://github.com/lighttpd/lighttpd1.4/archive/refs/heads/master.zip)


### LINK ###
dk_include			(${LIGHTTPD}/lib)
DEBUG_dk_include	(${LIGHTTPD_DEBUG_DIR})
RELEASE_dk_include	(${LIGHTTPD_RELEASE_DIR})
UNIX_dk_libDebug	(${LIGHTTPD}/${target_triple}/lib/${DEBUG_DIR}/liblighttpd.a)
UNIX_dk_libRelease	(${LIGHTTPD}/${target_triple}/lib/${RELEASE_DIR}/liblighttpd.a)
WIN_dk_libDebug		(${LIGHTTPD}/${target_triple}/lib/${DEBUG_DIR}/liblighttpd.lib)
WIN_dk_libRelease	(${LIGHTTPD}/${target_triple}/lib/${RELEASE_DIR}/liblighttpd.lib)


### GENERATE ###
dk_configure(${LIGHTTPD}) # -DLWS_WITH_SSL=OFF


### COMPILE ###
dk_build(${LIGHTTPD} LIGHTTPD)
