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


############ libjodycode ############
# https://github.com/jbruchon/libjodycode.git

dk_validate(Target_Config  "dk_Target_Config()")

### INSTALL ###
dk_import(https://github.com/jbruchon/libjodycode.git)

### LINK ###
dk_include			(${LIBJODYCODE}/include)
Unix_dk_libDebug	(${LIBJODYCODE.Debug_Dir}/libjodycode.a)
Unix_dk_libRelease	(${LIBJODYCODE.Release_Dir}/libjodycode.a)
Windows_dk_libDebug		(${LIBJODYCODE.Debug_Dir}/libjodycode.lib)
Windows_dk_libRelease	(${LIBJODYCODE.Release_Dir}/libjodycode.lib)

### GENERATE ###
dk_configure()

### COMPILE ###
dk_build(${LIBJODYCODE} libjodycode)
