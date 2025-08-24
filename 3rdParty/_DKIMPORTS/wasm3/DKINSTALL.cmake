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


############ wasm3 ############
# https://github.com/wasm3/wasm3.git
dk_validate(Target_Config  "dk_Target_Config()")

### IMPORT ###
dk_import(https://github.com/wasm3/wasm3/archive/79d412ea.zip)

### LINK ###
dk_include				(${WASM3})
dk_include				(${WASM3}/${Target_Tuple})
Apple_dk_libDebug		(${WASM3}/${Target_Tuple}/source/${Debug_Dir}/libm3.a)
Apple_dk_libRelease		(${WASM3}/${Target_Tuple}/source/${Release_Dir}/libm3.a)
if(NOT Apple)
	Unix_dk_libDebug	(${WASM3.Debug_Dir}/source/libm3.a)
	Unix_dk_libRelease	(${WASM3.Release_Dir}/source/libm3.a)
endif()
Windows_dk_libDebug			(${WASM3}/${Target_Tuple}/source/${Debug_Dir}/m3.lib)
Windows_dk_libRelease		(${WASM3}/${Target_Tuple}/source/${Release_Dir}/m3.lib)

### GENERATE ###
dk_configure()

### COMPILE ###
dk_build()
