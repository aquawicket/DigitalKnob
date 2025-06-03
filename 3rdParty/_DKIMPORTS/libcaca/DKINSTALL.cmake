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


########### libcaca ############
# https://github.com/cacalabs/libcaca.git
# http://caca.zoy.org/wiki/libcaca

dk_validate(Target_Config  "dk_Target_Config()")

### IMPORT ###
dk_import(https://github.com/cacalabs/libcaca/archive/refs/heads/main.zip)

### LINK ###
dk_include			(${LIBCACA}/include)
dk_include			(${LIBCACA}/${Target_Tuple})
UNIX_dk_libDebug	(${LIBCACA_DEBUG_DIR}/libcacad.a)
UNIX_dk_libRelease	(${LIBCACA_RELEASE_DIR}/libcaca.a)
Windows_dk_libDebug		(${LIBCACA_DEBUG_DIR}/libcacad.lib)
Windows_dk_libRelease	(${LIBCACA_RELEASE_DIR}/libcaca.lib)

### GENERATE ####
dk_configure(${LIBCACA_DIR})

### COMPILE ###
dk_build(${LIBCACA} libcaca)
