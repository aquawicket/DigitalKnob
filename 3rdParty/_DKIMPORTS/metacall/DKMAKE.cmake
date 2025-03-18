#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### metacall ######
# https://github.com/metacall/core

### DEPENDS ###
#dk_depend(metacall)

### INSTALL ###
dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
#dk_getFileParam	($ENV{DKIMPORTS_DIR}/metacall/dkconfig.txt METACALL_IMPORT)
set				(METACALL_DL https://github.com/metacall/core/archive/5b592ac0.zip)
dk_import		(${METACALL_DL})

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
