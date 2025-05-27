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


###### metacall ######
# https://github.com/metacall/core

### DEPENDS ###
#dk_depend(metacall)

### INSTALL ###
dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
#dk_getFileParams	("$ENV{DKIMPORTS_DIR}/metacall/dkconfig.txt")
set					(METACALL_DL https://github.com/metacall/core/archive/5b592ac0.zip)
dk_import			(${METACALL_DL})

### LINK ###
dk_include			(${METACALL}/include)
if(MSVC)
	dk_libDebug		(${METACALL_DEBUG_DIR}/metacall.lib)
	dk_libRelease	(${METACALL_RELEASE_DIR}/metacall.lib)
else()
	dk_libDebug		(${METACALL_DEBUG_DIR}/libmetacall.a)
	dk_libRelease	(${METACALL_RELEASE_DIR}/libmetacall.a)
endif()

### GENERATE ###
dk_configure(${METACALL})


### COMPILE ###
dk_build(${METACALL})
