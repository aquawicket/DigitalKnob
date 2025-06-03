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


############ libmd ############
# https://github.com/guillemj/libmd.git
dk_validate(Config_Path  "dk_Config_Path()")
if(NOT Iossim)
	dk_undepend(libmd)
	dk_return()
endif()

### DEPEND ###
dk_depend(autotools)

### IMPORT ###
dk_import(https://github.com/guillemj/libmd/archive/refs/heads/main.zip)

### LINK ###
dk_include			(${LIBMD}/include)
UNIX_dk_libDebug	(${LIBMD_DEBUG_DIR}/liblibmdd.a)
UNIX_dk_libRelease	(${LIBMD_RELEASE_DIR}/liblibmd.a)
Windows_dk_libDebug		(${LIBMD_DEBUG_DIR}/libmdd.lib)
Windows_dk_libRelease	(${LIBMD_RELEASE_DIR}/libmd.lib)


### 3RDPARTY LINK ###
dk_set(LIBMD_CMAKE -DLIBMD_LIBRARY=${LIBMD_DEBUG_DIR}/libmd.a)


### COMPILE ###
if(Android)
	ANDROID_dk_ndk			(${LIBMD})
else()
	DEBUG_dk_chdir			(${LIBMD})
	DEBUG_dk_queueCommand	(aclocal)
	
	#DEBUG_dk_chdir			(${LIBMD_DEBUG_DIR})
	#DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
	#RELEASE_dk_chdir		(${LIBMD_RELEASE_DIR})
	#RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
	dk_configure			(${LIBMD_DIR})
	
	
	dk_build				(${LIBMD_DIR})
endif()
