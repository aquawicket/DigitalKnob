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


############ dukluv ############
# https://github.com/creationix/dukluv.git
# https://github.com/creationix/dukluv/archive/f02103bcadd5a5b9280b7a07064649d0a465f70c.zip
# https://github.com/creationix/dukluv/archive/f02103bcadd5a5b9280b7a07064649d0a465f70c.zip

dk_depend(duktape)
dk_depend(libuv)

### IMPORT ###
dk_import()

### LINK ###
dk_include			(${dukluv}/include)
dk_include			(${dukluv}/${Target_Tuple})
if(Windows AND MSVC)
	dk_libDebug		(${dukluv_Debug_Dir}/dukluv.lib)
	dk_libRelease	(${dukluv_Release_Dir}/dukluv.lib)
else()
	dk_libDebug		(${dukluv_Debug_Dir}/libdukluv.a)
	dk_libRelease	(${dukluv_Release_Dir}/libdukluv.a)
endif()

### GENERATE ###
dk_configure		(${dukluv} ${duktape_CMAKE} ${libuv_CMAKE})

### COMPILE ###
dk_build			(${dukluv})
