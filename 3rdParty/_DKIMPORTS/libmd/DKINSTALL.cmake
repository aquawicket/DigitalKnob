#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ libmd ############
# https://github.com/guillemj/libmd.git
# https://github.com/guillemj/libmd/archive/refs/heads/main.zip

if(NOT Iossim)
	dk_disable(libmd)
	dk_return()
endif()

dk_depend(autotools)

dk_import()

dk_include			(${libmd}/include)
if(Windows)
	dk_libDebug		(${libmd_Debug_Dir}/libmdd.lib)
	dk_libRelease	(${libmd_Release_Dir}/libmd.lib)
else()
	dk_libDebug		(${libmd_Debug_Dir}/liblibmdd.a)
	dk_libRelease	(${libmd_Release_Dir}/liblibmd.a)
endif()

dk_set(libmd_CMAKE -DLIBMD_LIBRARY=${libmd_Debug_Dir}/libmd.a)

if(Android)
	dk_ndk				(${libmd})
else()
	DEBUG_dk_chdir		(${libmd})
	DEBUG_dk_exec		(aclocal)
	
	#DEBUG_dk_chdir		(${libmd_Debug_Dir})
	#DEBUG_dk_exec		(${DKCONFIGURE_BUILD})
	#RELEASE_dk_chdir	(${libmd_Release_Dir})
	#RELEASE_dk_exec	(${DKCONFIGURE_BUILD})
	dk_configure		(${libmd})
	
	dk_build			(${libmd})
endif()
