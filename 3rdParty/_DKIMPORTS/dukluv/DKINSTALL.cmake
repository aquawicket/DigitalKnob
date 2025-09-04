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


############ dukluv ############
# https://github.com/creationix/dukluv.git
# https://github.com/creationix/dukluv/archive/f02103bcadd5a5b9280b7a07064649d0a465f70c.zip

dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
dk_depend(duktape)
dk_depend(libuv)

### IMPORT ###
dk_getFileParams		("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import				(${DUKLUV_DL})

### LINK ###
dk_include				(${DUKLUV}/include)
dk_include				(${DUKLUV}/${Target_Tuple})
if(MSVC)
	Windows_dk_libDebug		(${DUKLUV_Debug_Dir}/dukluv.lib)
	Windows_dk_libRelease	(${DUKLUV_Release_Dir}/dukluv.lib)
else()
	dk_libDebug			(${DUKLUV_Debug_Dir}/libdukluv.a)
	dk_libRelease		(${DUKLUV_Release_Dir}/libdukluv.a)
endif()

### GENERATE ###
dk_configure			(${DUKLUV} ${DUKTAPE_CMAKE} ${libuv_CMAKE})

### COMPILE ###
dk_build				(${DUKLUV})
