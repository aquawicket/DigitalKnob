#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://github.com/lighttpd/lighttpd1.4.git


### IMPORT ###
#dk_import(https://github.com/lighttpd/lighttpd1.4.git)
dk_import(https://github.com/lighttpd/lighttpd1.4/archive/refs/heads/master.zip)


### LINK ###
dk_include			(${LIGHTTPD}/lib)
Debug_dk_include	(${LIGHTTPD_DEBUG_DIR})
Release_dk_include	(${LIGHTTPD_RELEASE_DIR})
UNIX_dk_libDebug	(${LIGHTTPD}/${Target_Tuple}/lib/${Debug_Dir}/liblighttpd.a)
UNIX_dk_libRelease	(${LIGHTTPD}/${Target_Tuple}/lib/${Release_Dir}/liblighttpd.a)
Windows_dk_libDebug		(${LIGHTTPD}/${Target_Tuple}/lib/${Debug_Dir}/liblighttpd.lib)
Windows_dk_libRelease	(${LIGHTTPD}/${Target_Tuple}/lib/${Release_Dir}/liblighttpd.lib)


### GENERATE ###
dk_configure(${LIGHTTPD}) # -DLWS_WITH_SSL=OFF


### COMPILE ###
dk_build(${LIGHTTPD} LIGHTTPD)
