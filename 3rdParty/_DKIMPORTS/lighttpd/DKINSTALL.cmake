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


dk_validate(Target_Config  "dk_Target_Config()")
# https://github.com/lighttpd/lighttpd1.4.git


### IMPORT ###
#dk_import(https://github.com/lighttpd/lighttpd1.4.git)
dk_import(https://github.com/lighttpd/lighttpd1.4/archive/refs/heads/master.zip)


### LINK ###
dk_include			(${LIGHTTPD}/lib)
Debug_dk_include	(${LIGHTTPD_Debug_Dir})
Release_dk_include	(${LIGHTTPD_Release_Dir})
Unix_dk_libDebug	(${LIGHTTPD}/${Target_Tuple}/lib/${Debug_Dir}/liblighttpd.a)
Unix_dk_libRelease	(${LIGHTTPD}/${Target_Tuple}/lib/${Release_Dir}/liblighttpd.a)
Windows_dk_libDebug		(${LIGHTTPD}/${Target_Tuple}/lib/${Debug_Dir}/liblighttpd.lib)
Windows_dk_libRelease	(${LIGHTTPD}/${Target_Tuple}/lib/${Release_Dir}/liblighttpd.lib)


### GENERATE ###
dk_configure() # -DLWS_WITH_SSL=OFF


### COMPILE ###
dk_build(${LIGHTTPD} LIGHTTPD)
