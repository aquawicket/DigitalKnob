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
dk_validate(Target_Config  "dk_Target_Config()")
if(NOT Iossim)
	dk_undepend(libmd)
	dk_return()
endif()

### DEPEND ###
dk_depend(autotools)

### IMPORT ###
dk_import(https://github.com/guillemj/libmd/archive/refs/heads/main.zip)

### LINK ###
dk_include				(${LIBMD}/include)
Unix_dk_libDebug		(${LIBMD.Debug_Dir}/liblibmdd.a)
Unix_dk_libRelease		(${LIBMD.Release_Dir}/liblibmd.a)
Windows_dk_libDebug		(${LIBMD.Debug_Dir}/libmdd.lib)
Windows_dk_libRelease	(${LIBMD.Release_Dir}/libmd.lib)


### 3RDPARTY LINK ###
dk_set(LIBMD_CMAKE -DLIBMD_LIBRARY=${LIBMD.Debug_Dir}/libmd.a)


### COMPILE ###
if(Android)
	Android_dk_ndk		(${LIBMD})
else()
	DEBUG_dk_chdir		(${LIBMD})
	DEBUG_dk_exec		(aclocal)
	
	#DEBUG_dk_chdir		(${LIBMD.Debug_Dir})
	#DEBUG_dk_exec		(${DKCONFIGURE_BUILD})
	#RELEASE_dk_chdir	(${LIBMD.Release_Dir})
	#RELEASE_dk_exec	(${DKCONFIGURE_BUILD})
	dk_configure		(${LIBMD})
	
	
	dk_build			(${LIBMD})
endif()
